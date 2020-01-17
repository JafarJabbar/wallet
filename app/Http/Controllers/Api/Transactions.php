<?php

namespace App\Http\Controllers\Api;

use Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;

class Transactions extends Controller
{

    public function get_categories()
    {
        $getCategories = DB::table('_categories')->select('cat_name')->get();
        if ( $getCategories ) {
            return Response::json([
                $getCategories
            ]);
        }
    }


    public function subcategories_in()
    {

                $array = array();
                    $getRow2 = json_decode(DB::table('_sub_categories')
                        ->where([['subcategory_type', '=', 'money_in']])
                        ->get(), true);
                    if (count($getRow2)>0){
                        foreach ($getRow2 as $key=>$value){
                            $alt_arr = array(
                                "id" => $getRow2[$key]['subcategory_id'],
                                "name" => $getRow2[$key]['subcategory_name'],
                                "image" => $getRow2[$key]['image'],
                                "elements" => json_decode($getRow2[$key]['elements'])
                            );
                            array_push($array, $alt_arr);

                        }
                        return Response::json([
                            'status' => 'success',
                            'code' => 200,
                            'data' => $array
                        ]);
                    }
                    else{
                        return Response::json([
                            'status' => 'error',
                            'code' => 200,
                            'message' => 'Category is not found!'
                        ]);

                    }
    }

    public function subcategories_out(Request $request)
    {

        $valid = Validator::make($request->all(), [
            'id' => 'required|int'
        ]);
        if ( $valid->fails() ) {
            return Response::json([
                'status' => 'error',
                'code' => 410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию'
            ]);
        } else {
            $getRow = json_decode(DB::table('_categories')
                ->where('cat_id', '=', $request->json()->all()['id'])
                ->get(), true);
            if ( $getRow ) {
                $array = array();
                foreach (explode(',', trim($getRow[0]['subcategory_id'], '\[\]')) as $key => $value) {
                    $getRow2 = json_decode(DB::table('_sub_categories')
                        ->where([['subcategory_id', '=', $value],['subcategory_type', '=', 'money_out']])
                        ->get(), true);
                  if (count($getRow2)>0){
                      $alt_arr = array(
                          "id" => $getRow2[0]['subcategory_id'],
                          "name" => $getRow2[0]['subcategory_name'],
                          "image" => $getRow2[0]['image'],
                          "elements" => json_decode($getRow2[0]['elements'])
                      );
                      array_push($array, $alt_arr);
                  }else{
                      return Response::json([
                          'status' => 'error',
                          'code' => 404,
                          'message' => 'Категория не найдена!'
                      ]);

                  }
                }


                return Response::json([
                    'status' => 'success',
                    'code' => 200,
                    'data' => $array
                ]);
            } else {
                return Response::json([
                    'status' => 'error',
                    'code' => 406,
                    'error_type' => 'operation_error',
                    'error' => 'Ошибка операции!'
                ]);
            }
        }
    }


    public function pay(Request $request)
    {

        $val = Validator($request->all(), [
            'token' => 'required|string',
            'data' => 'required|array',
            'id' => 'required|int'
        ]);
        if ( $val->fails() ) {
            return Response::json([
                'status' => 'error',
                'code' => 410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию'
            ]);
        } else {
            $getRow = json_decode(DB::table('_users')
                ->where([['user_token', '=', @$request->json()->all()['token']], ['user_status', '=', 'active']])
                ->get(), true);
            if ( count($getRow) > 0 ) {
                $amount = floatval(0.00);
                $transaction_user_id = $getRow[0]['user_id'];
                $transaction_user_number = rand(000, 999) . time();
                $category = json_decode(DB::table('_sub_categories')->where(['subcategory_id', '=', @$request->json()->all()['id'],['subcotegory_type','=','money_out']])->get(), true);
                $transaction_title = $category[0]['subcategory_name'];
                $transaction_icon = $category[0]['image'];
                $transaction_elements = @$request->json()->all()['data'];
                $transaction_currency = 'ruble';
                $transaction_type = 'money_out';
                $transaction_description = $category[0]['description'];
                foreach (@$request->json()->all()['data'] as $key => $value) {
                    if ( $value['name'] == 'amount' ) {
                        $amount = floatval($value['value']);
                    }
                }
                $balance = $getRow[0]['user_balance'];
                $diff = floatval(floatval($balance) - floatval($amount));
                if ( $diff >= 0 ) {
                    $insertRow = DB::table('_transactions')
                        ->insert([
                            'transaction_user_id' => $transaction_user_id,
                            'transaction_number' => $transaction_user_number,
                            'transaction_type' => $transaction_type,
                            'transaction_category_id' => @$request->json()->all()['id'],
                            'transaction_amount' => $amount,
                            'transaction_title' => $transaction_title,
                            'transaction_description' => $transaction_description,
                            'transaction_icon' => $transaction_icon,
                            'transaction_elements' => json_encode($transaction_elements),
                            'transaction_currency' => $transaction_currency,
                        ]);
                    $updateBalance = DB::table('_users')
                        ->where('user_id', '=', $getRow[0]['user_id'])
                        ->update(['user_balance' => $diff]);
                    if ( $insertRow ) {
                        if ( $updateBalance ) {
                            return Response::json([
                                'status' => 'success',
                                'code' => 200,
                                'message' => 'Платеж завершен'
                            ]);
                        } else {
                            return Response::json([
                                'status' => 'error',
                                'code' => 405,
                                'error_type' => 'undefined_error',
                                'error' => 'Неопределенная ошибка! Пожалуйста, попробуйте еще раз'
                            ]);

                        }
                    } else {
                        return Response::json([
                            'status' => 'error',
                            'code' => 405,
                            'error_type' => 'undefined_error',
                            'error' => 'Неопределенная ошибка! Пожалуйста, попробуйте еще раз'
                        ]);
                    }
                } else {
                    return Response::json([
                        'status' => 'error',
                        'code' => 408,
                        'error_type' => 'balance_error',
                        'error' => 'Вашего баланса недостаточно!'
                    ]);
                }


            } else {
                return Response::json([
                    'status' => 'error',
                    'code' => 403,
                    'error_type' => 'permission_error',
                    'error' => 'Ваши учетные данные неверны!'
                ]);
            }

        }
    }

    public function transactionList(Request $request)
    {

        $val = Validator($request->all(), [
            'token' => 'required|string',
            'page' => 'required|int',
            'type' => 'required|string'
        ]);
        if ( $val->fails() ) {
            return Response::json([
                'status' => 'error',
                'code' => 410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию'
            ]);
        } else {
            $getRow = json_decode(DB::table('_users')
                ->where([['user_token', '=', @$request->json()->all()['token']], ['user_status', '=', 'active']])
                ->get(), true);
            if ( count($getRow) > 0 ) {
                if ( @$request->json()->all()['type'] == 'all' ) {
                    $getTransactions = json_decode(DB::table('_transactions')
                        ->where([['transaction_status', '!=', 'deleted'], ['transaction_user_id', '=', $getRow[0]['user_id']]])
                        ->take(15)
                        ->skip((@$request->json()->all()['page'] - 1) * 15)
                        ->orderBy('created_at', 'DESC')
                        ->get(), true);
                    if ( count($getTransactions) > 0 ) {
                        $array = [];
                        foreach ($getTransactions as $key => $transaction) {
                            array_push($array, [
                                'title' => $transaction['transaction_title'],
                                'number' => $transaction['transaction_number'],
                                'type' => $transaction['transaction_type'],
                                'status' => $transaction['transaction_status'],
                                'amount' => $transaction['transaction_amount'],
                                'description' => $transaction['transaction_description'],
                                'icon' => $transaction['transaction_icon'],
                                'currency' => $transaction['transaction_amount'],
                                'date' => $transaction['created_at']
                            ]);
                        }

                        return Response::json([
                            'status' => 'success',
                            'code' => 200,
                            'data' => $array
                        ]);
                    } else {
                        return Response::json([
                            'status' => 'error',
                            'code' => 405,
                            'error_type' => 'list_empty',
                            'error' => 'Список пуст!'
                        ]);
                    }
                } else {
                    $getTransactions = json_decode(DB::table('_transactions')
                        ->where([['transaction_status', '!=', 'deleted'], ['transaction_user_id', '=', $getRow[0]['user_id']], ['transaction_type', '=', @$request->json()->all()['type']]])
                        ->take(15)
                        ->skip((@$request->json()->all()['page'] - 1) * 15)
                        ->orderBy('created_at', 'DESC')
                        ->get(), true);
                    if ( count($getTransactions) > 0 ) {
                        $array = [];
                        foreach ($getTransactions as $key => $transaction) {
                            array_push($array, [
                                'title' => $transaction['transaction_title'],
                                'number' => $transaction['transaction_number'],
                                'type' => $transaction['transaction_type'],
                                'status' => $transaction['transaction_status'],
                                'amount' => $transaction['transaction_amount'],
                                'description' => $transaction['transaction_description'],
                                'icon' => $transaction['transaction_icon'],
                                'currency' => $transaction['transaction_amount'],
                                'date' => $transaction['created_at']
                            ]);
                        }

                        return Response::json([
                            'status' => 'success',
                            'code' => 200,
                            'data' => $array
                        ]);
                    } else {
                        return Response::json([
                            'status' => 'error',
                            'code' => 405,
                            'error_type' => 'list_empty',
                            'error' => 'Список пуст'
                        ]);
                    }
                }

            } else {
                return Response::json([
                    'status' => 'error',
                    'code' => 403,
                    'error_type' => 'permission_error',
                    'error' => 'Ваши учетные данные неверны!'
                ]);
            }
        }
    }

    public function increaseBalance(Request $request)
    {
        $v = Validator::make($request->all(), [
            'token' => 'required| string',
            'id' => 'required| string',
            'data'=>'required|array'
        ]);

        if ( $v->fails() ) {
            return Response::json([
                'status' => 'error',
                'code' => 410,
                'error_type' => 'validation_error',
                'error' => 'Пожалуйста, введите правильную информацию!'
            ]);
        } else {
            $getRow = json_decode(DB::table('_users')
                ->where([['user_token', '=', @$request->json()->all()['token']], ['user_status', '=', 'active']])->get(), true);

            if ( count($getRow) > 0 ) {
                $amount = floatval(0.00);
                $category=json_decode(DB::table('_sub_categories')->where([['subcategory_type','=','money_in'],['subcategory_id','=',@$request->json()->all()['id']]])->get(),true);
                $transaction_title=$category[0]['subcategory_name'];
                $transaction_icon=$category[0]['image'];
                $transaction_user_id = $getRow[0]['user_id'];
                $transaction_number = rand(000, 999) . time();
                $transaction_elements = @$request->json()->all()['data'];
                $transaction_currency = 'ruble';
                $transaction_type = 'money_in';
                $transaction_description=$category[0]['description'];
                foreach (@$request->json()->all()['data'] as $key => $value) {
                    if ( $value['name'] == 'key' ) {
                        $key = floatval($value['value']);
                    }
                }


                    $insertRow = DB::table('_transactions')
                        ->insert([
                            'transaction_user_id' => $transaction_user_id,
                            'transaction_number' => $transaction_number,
                            'transaction_type' => $transaction_type,
                            'transaction_category_id' => $category[0]['subcategory_id'],
                            'transaction_amount' => $amount,
                            'transaction_title' => $transaction_title,
                            'transaction_description' => $transaction_description,
                            'transaction_icon' => $transaction_icon,
                            'transaction_elements' => json_encode($transaction_elements),
                            'transaction_currency' => $transaction_currency,
                        ]);
                    if ( isset($insertRow) ) {
                        return Response::json([
                            'status' => 'success',
                            'code' => 200,

                        ]);
                    } else {
                        return Response::json([
                            'status' => 'error',
                            'code' => 405,
                            'error_type' => 'undefined_error',
                            'error' => ' ошибка! Пожалуйста, попробуйте еще раз!'
                        ]);
                    }

            }else{
                return Response::json([
                    'status' => 'error',
                    'code' => 403,
                    'error_type' => 'permission_error',
                    'error' => 'Ваши учетные данные неверны!'
                ]);
            }
        }
    }

}
