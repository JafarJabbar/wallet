<?php
namespace App\Http\Controllers\Api;
use Validator;
use Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class Admin extends Controller
{
    public function login(Request $request)
    {
        $key='1234567890qwertyuiop';
        $v = Validator::make($request->all(),[
            'username'=>'required| string | min:6',
            'password'=>'required| string | min:6'
        ]);

        if ($v->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию!'
            ]);
        }else{
            $getRow=json_decode(DB::table('_admins')
                ->where([['admin_username','=',@$request->json()->all()['username']],['admin_password','=',md5(@$request->json()->all()['password'])],['admin_status','=','active']])
                ->get(), true);
            if (isset($getRow)) {
                $data = "123456789" . $getRow[0]["admin_id"] . time();
                $token = hash_hmac('sha512', utf8_encode($data), utf8_encode($key), false);
                $updateToken = DB::table('_admins')->where('admin_id', '=', $getRow[0]['admin_id'])->update(['admin_token' => $token]);
                    return Response::json([
                        'status' => 'success',
                        'code'=>200,
                        'token' => $token
                    ]);
            }else {
                return Response::json([
                    'status' => 'error',
                    'code'=>403,
                    'error_type' => 'permission_error',
                    'error' => 'Ваши учетные данные неверны!'
                ]);
            }
        }
    }
//
    public function userUpdate(Request $request)
    {
        $v = Validator::make($request->all(),[
            'token'=>'required| string',
            'user_token'=>'required | string',
            'name'=>'required| string | min:3',
            'surname'=>'required| string | min:3',
            'password'=>'required| string | min:6',
            'status'=>'required| string ',
            'gender'=>'required| int',
        ]);

        if ($v->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию!'
            ]);
        }else{
            $admin=json_decode(DB::table('_admins')->where([['admin_token','=',@$request->json()->all()['token']]])->get(),true);

            if (count($admin)>0){
                $updateUser=DB::table('_users')->where([['user_token','=',@$request->json()->all()['user_token']]])
                    ->update([
                        'user_name'=>@$request->json()->all()['name'],
                        'user_surname'=>@$request->json()->all()['surname'],
                        'user_password'=>md5(@$request->json()->all()['password']),
                        'user_status'=>@$request->json()->all()['status'],
                        'user_gender'=>@$request->json()->all()['gender']
                    ]);
                if (count($updateUser)>0) {
                    return Response::json([
                        'status' => 'success',
                        'code'=>200,
                    ]);
                }else {
                    return Response::json([
                        'status' => 'error',
                        'code'=>406,
                        'error_type' => 'operation_error',
                        'error' => 'Ошибка операции!'
                    ]);
                }
            }else{
                return Response::json([
                    'status' => 'error',
                    'code'=>406,
                    'error_type' => 'operation_error',
                    'error' => 'Ошибка операции!'
                ]);

            }
        }
    }
    public function transactionUpdate(Request $request)
    {
        $v = Validator::make($request->all(),[
            'token'=>'required| string',
            'number'=>'required | string',
            'description'=>'required | string',
            'status'=>'required| string '
        ]);

        if ($v->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию!'
            ]);
        }else{
            $admin=json_decode(DB::table('_admins')->where([['admin_token','=',@$request->json()->all()['token']]])->get(),true);

            if (count($admin)>0){
                $updateTr=DB::table('_transactions')->where([['transaction_number','=',@$request->json()->all()['number']]])
                    ->update([
                        'transaction_status'=>@$request->json()->all()['status'],
                        'transaction_description'=>@$request->json()->all()['description'],
                    ]);
                if (count($updateTr)>0) {
                    return Response::json([
                        'status' => 'success',
                        'code'=>200,
                    ]);
                }else {
                    return Response::json([
                        'status' => 'error',
                        'code'=>406,
                        'error_type' => 'operation_error',
                        'error' => 'Ошибка операции!'
                    ]);
                }
            }
        }
    }
    public function adminChat(Request $request)
    {
        $val = Validator::make($request->all(), [
            'token' => 'required | string'
        ]);
        if ( $val->fails() ) {
            return Response::json([
                'status' => 'error',
                'code' => 410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию!'
            ]);
        } else {
            $getAdmin = json_decode(DB::table('_admins')->where([['admin_token', '=', @$request->json()->all()['token']]])->get(), true);
           if (count($getAdmin)>0){
               $getUser= json_decode(DB::table('_chats')->select('chat_sender_id')->distinct()->get(), true);
               $array = array();
               if (count($getUser)>0){
                   foreach ($getUser as $user){
                       $data=[];
                     $getMess=json_decode(DB::table('_chats')
                         ->select('chat_text','chat_send_at','chat_sender_type')
                         ->where([['chat_sender_id','=',$user],['chat_sender_type', '=', 'user']])
                         ->orWhere([['chat_sender_to','=',$user],['chat_sender_type', '=', 'admin']])->orderBy('chat_send_at', 'DESC')->get(),true);
                     $data['user_id']=$user;
                     $data['messages']=$getMess;
                     array_push($array, $data);
                   }
                   return Response::json([
                       'status' => 'success',
                       'code'=>200,
                       'data'=> $array
                   ]);

               }else{
                   return Response::json([
                       'status' => 'error',
                       'code'=>406,
                       'error_type' => 'operation_error',
                       'error' => 'У этого пользователя нет сообщений!'
                   ]);
               }
           }else{
               return Response::json([
                   'status' => 'error',
                   'code'=>403,
                   'error_type' => 'permission_error',
                   'error' => 'Ваши учетные данные неверны!'
               ]);
           }
        }
    }

}
