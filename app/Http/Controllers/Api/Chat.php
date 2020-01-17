<?php

namespace App\Http\Controllers\Api;

use Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Response;

class Chat extends Controller
{
    public function send(Request $request){
        $val=Validator($request->all(),[
            'token'=>'required|string',
            'text'=>'required|string'
        ]);
        if ($val->fails()){
            return Response::json([
                'status' => 'error',
                'code'=>410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию!'
            ]);
        }else {
            $getRow = json_decode(DB::table('_users')
                ->where([['user_token', '=', @$request->json()->all()['token']], ['user_status', '=', 'active']])
                ->get(), true);
            if ( count($getRow) > 0 ) {
                $insertUser=DB::table('_chats')->insert([
                   'chat_sender_id' => $getRow[0]['user_id'],
                   'chat_sender_to' => 1,
                   'chat_text' => @$request->json()->all()['text'],
                   'chat_sender_type' => 'user',
                ]);
                if (count($insertUser)){
                    return Response::json([
                        'status'=>'success',
                        'code' => 200
                    ]);
                }else{
                    return Response::json([
                        'status' => 'error',
                        'code'=>406,
                        'error_type' => 'undefined_error',
                        'error' => 'Неопределенная ошибка! Пожалуйста, попробуйте еще раз!'
                    ]);
                }
            }
        }
    }
    public function lastMessages(Request $request){
        $val=Validator::make($request->all(),[
            'token'=>'required|string'
        ]);
        if ($val->fails()) {
            return Response::json([
                'status' => 'error',
                'code' => 410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию'
            ]);
        }
            else{
                $getRow=json_decode(DB::table('_users')
                    ->where([['user_token','=',@$request->json()->all()['token']],['user_status','=','active']])
                    ->get(), true);
                if (count($getRow)>0){
                    $getMessage=json_decode(DB::table('_chats')
                        ->where([['chat_sender_to','=',$getRow[0]['user_id']],['chat_sender_type','!=','user'],['chat_viewed_at','=',null]])->get(),true);
                    if (count($getMessage)>0){
                        $readMessage=DB::table('_chats')
                            ->where([['chat_sender_to','=',$getRow[0]['user_id']],['chat_sender_type','!=','user']])
                            ->update([
                                'chat_viewed_at'=>date('Y-m-d H-i-s')
                            ]);
                        return Response::json([
                            'status'=>'success',
                            'code' => 200,
                            'messages'=>$getMessage
                        ]);
                    }else{
                        return Response::json([
                            'status' => 'error',
                            'code'=>403,
                            'error_type' => 'permission_error',
                            'error' => 'Ваши учетные данные неверны!'
                        ]);
                    }
                }else{
                    return Response::json([
                        'status' => 'error',
                        'code'=>403,
                        'error_type' => 'permission_error',
                        'error' => 'Ваши учетные данные неверны'
                    ]);
                }
            }
        }
}
