<?php

namespace App\Http\Controllers\Api;
use App\Mail\OrderShipped;
use App\Mail\resetPassword;
use Illuminate\Support\Facades\Mail;
use Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Response;

class User extends Controller
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
            $getRow=json_decode(DB::table('_users')
                ->where([['user_username','=',@$request->json()->all()['username']],['user_password','=',md5(@$request->json()->all()['password'])],['user_status','=','active']])
                ->get(), true);
            if (count($getRow)>0) {
                $data = "sdsfsdssdf" . $getRow[0]["user_id"] . time();
                $token = hash_hmac('sha512', utf8_encode($data), utf8_encode($key), false);
                $updateToken = DB::table('_users')->where('user_id', '=', $getRow[0]['user_id'])->update(['user_token' => $token]);
                if ( $updateToken ) {
                    return Response::json([
                        'status' => 'success',
                        'code'=>200,
                        'token' => $token
                    ]);
                } else {
                    return Response::json([
                        'status'=>'error',
                        'error_type'=>'undefined_error',
                        'code' => 405,
                        'message'=>'Неопределенная ошибка! Пожалуйста, попробуйте еще раз!'
                    ]);
                }
            }else {
                return Response::json([
                    'status' => 'error',
                    'code'=>403,
                    'error_type' => 'permission_error',
                    'error' => 'Ваши учетные данные неверны'
                ]);
            }
        }
    }
    public function registration(Request $request)
    {
        $v = Validator::make($request->all(),[
            'username'=>'required| string | min:6',
            'name'=>'required| string | min:3',
            'surname'=>'required| string | min:3',
            'gender'=>'required| int',
            'email'=>'required| string | min:8',
            'password'=>'required| string | min:6'
        ]);
        if ($v->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию'
            ]);
        }else{
            $pin=rand(100000,999999);
            $username = @$request->json()->all()['username'];
            $password = md5(@$request->json()->all()['password']);
            $name = @$request->json()->all()['name'];
            $surname = @$request->json()->all()['surname'];
            $email = @$request->json()->all()['email'];
            $gender = @$request->json()->all()['gender'];

            $insertUser=DB::table('_users')->insert([
                'user_username'=>$username,
                'user_name'=>$name,
                'user_surname'=>$surname,
                'user_email'=>$email,
                'user_gender'=>$gender,
                'user_password'=>$password,
                'user_verify_code'=>$pin,
                'user_status' => 'waiting'
            ]);
            if ($insertUser){
                Mail::to($email)->send(new OrderShipped($pin));
                    return Response::json([
                        'status'=>'success',
                        'code' => 200,
                        'message'=>'Код подтверждения отправил ваш адрес электронной почты!'
                    ]);
            }
            else{
                return Response::json([
                    'status'=>'error',
                    'error_type'=>'undefined_error',
                    'code' => 405,
                    'message'=>'Неопределенная ошибка! Пожалуйста, попробуйте еще раз!'
                ]);
            }
        }
    }

    public function verify(Request $request)
    {
        $v = Validator::make($request->all(),[
            'email'=>'required| string | min:8',
            'pin'=>'required| string '
        ]);

        if ($v->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию'
            ]);
        }else{
            $getRow=json_decode(DB::table('_users')
                ->where([['user_email','=',@$request->json()->all()['email']],['user_verify_code','=',@$request->json()->all()['pin']],['user_status','=',"waiting"]])
                ->get(), true);
            if (count($getRow)>0) {
                $loginUpdate=DB::table('_users')->where('user_email','=',@$request->all()['email'])->update(['user_status'=>"active"]);
                if ($loginUpdate){
                    return Response::json([
                        'status'=>'success',
                        'code'=>200,
                        'message'=>'Ваш аккаунт успешно подтвержден!'
                    ]);
                }
            }
        }
    }

    public function userInfo(Request $request)
    {
        $v = Validator::make($request->all(),[
            'token'=>'required| string',
        ]);

        if ($v->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию'
            ]);
        }else{
            $getRow=json_decode(DB::table('_users')
                ->where([['user_token','=',@$request->json()->all()['token']],['user_status','=','active']])
                ->get(), true);
            if (count($getRow)>0) {
                return Response::json([
                    'status' => 'success',
                    'code'=>200,
                    'data' => [
                        'username' => $getRow[0]['user_username'],
                        'name' => $getRow[0]['user_name'],
                        'surname' => $getRow[0]['user_surname'],
                        'gender' => $getRow[0]['user_gender'],
                        'email' => $getRow[0]['user_email']
                    ]
                ]);
            }else {
                return Response::json([
                    'status' => 'error',
                    'code'=>403,
                    'error_type' => 'permission_error',
                    'error' => 'Ваши учетные данные неверны! '
                ]);
            }
        }
    }
    public function userUpdate(Request $request)
    {
        $v = Validator::make($request->all(),[
            'token'=>'required| string',
            'name'=>'required| string | min:3',
            'surname'=>'required| string | min:3',
            'gender'=>'required| int',
            ]);

        if ($v->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию'
            ]);
        }else{
            $updateUser=DB::table('_users')->where([['user_token','=',@$request->json()->all()['token']],['user_status','=',"active"]])
                ->update([
                    'user_name'=>@$request->json()->all()['name'],
                    'user_surname'=>@$request->json()->all()['surname'],
                    'user_gender'=>@$request->json()->all()['gender']
                ]);
            if (count($updateUser)>0) {
                    return Response::json([
                        'status' => 'success',
                        'code'=>200,
                        'message'=>'Информация о пользователе успешно изменена!'
                        ]);
            }else {
                return Response::json([
                    'status' => 'error',
                    'code'=>406,
                    'error_type' => 'undefined_error',
                    'error' => 'Неопределенная ошибка! Пожалуйста, попробуйте еще раз!'
                ]);
            }
        }
    }
    public function resetPassword(Request $request){
        $v = Validator::make($request->all(),[
            'email'=>'required| email',
        ]);

        if ($v->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию!'
            ]);
        }else {
            $checkUser=json_decode(DB::table('_users')->where([['user_email','=',@$request->json()->all()['email']],['user_status','!=','deleted']])->get(),true);
            $pin=rand(100000,999999);
            if ($checkUser){
                $pinUpdate=DB::table('_users')->where('user_email','=',@$request->json()->all()['email'])->update([
                   'user_verify_code'=>$pin,
                    'user_status'=>'waiting'
                ]);
                if ($pinUpdate){
                    Mail::to(@$request->json()->all()['email'])->send(new resetPassword($pin));
                    return Response::json([
                        'status'=>'success',
                        'code' => 200,
                        'message'=>'Код подтверждения отправил ваш адрес электронной почты!'
                    ]);
                }else{
                    return Response::json([
                        'status' => 'error',
                        'code'=>406,
                        'error_type' => 'undefined_error',
                        'error' => 'Неопределенная ошибка! Пожалуйста, попробуйте еще раз!'
                    ]);
                }
            }else{
                return Response::json([
                    'status'=>'error',
                    'error_type'=>'undefined_error',
                    'code' => 405,
                    'message'=>'Неопределенная ошибка! Пожалуйста, попробуйте еще раз!'
                ]);
            }
        }
    }
    public function newPassword(Request $request)
    {
        $v = Validator::make($request->all(),[
            'pin'=>'required| int ',
            'password'=>'required|string',
            'confirmPassword'=>'required|string|same:password'
        ]);

        if ($v->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию'
            ]);
        }else{
            $getRow=json_decode(DB::table('_users')
                ->where([['user_verify_code','=',@$request->json()->all()['pin']],['user_status','=',"waiting"]])
                ->get(), true);
            if (count($getRow)>0) {
                $password=md5(@$request->json()->all()['password']);
                $loginUpdate=DB::table('_users')->where('user_verify_code','=',@$request->json()->all()['pin'])->update([
                    'user_status'=>"active",
                    'user_password'=>$password
                ]);
                if ($loginUpdate){
                    return Response::json([
                        'status'=>'success',
                        'code'=>200,
                        'message'=>'Пароль успешно изменен!'
                    ]);
                }else{
                    return Response::json([
                        'status'=>'error',
                        'error_type'=>'undefined_error',
                        'code' => 405,
                        'message'=>'Неопределенная ошибка! Пожалуйста, попробуйте еще раз!'
                    ]);
                }
            }else{
                return Response::json([
                    'status' => 'error',
                    'code'=>406,
                    'error_type' => 'operation_error',
                    'error' => 'Неверный пин'
                ]);
            }
        }
    }

}
