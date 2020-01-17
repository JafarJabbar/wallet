<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/



Route::post('userLogin','Api\User@login');
Route::post('userRegister','Api\User@registration');
Route::post('userVerify','Api\User@verify');
Route::post('userInfo','Api\User@userInfo');
Route::post('userUpdate','Api\User@userUpdate');
Route::post('resetPassword','Api\User@resetPassword');
Route::post('newPassword','Api\User@newPassword');
Route::get('transaction/getcategories','Api\Transactions@get_categories');
Route::post('transaction/out','Api\Transactions@subcategories_out');
Route::post('transaction/in','Api\Transactions@subcategories_in');
Route::post('transaction/pay','Api\Transactions@pay');
Route::post('transaction/list','Api\Transactions@transactionList');
Route::post('transaction/increase','Api\Transactions@increaseBalance');
Route::post('chat/send','Api\Chat@send');
Route::post('chat/lastMessages','Api\Chat@lastMessages');
Route::post('admin/userUpdate','Api\Admin@userUpdate');
Route::post('admin/login','Api\Admin@login');
Route::post('admin/chat','Api\Admin@adminChat');
Route::post('admin/transactionUpdate','Api\Admin@transactionUpdate');
Route::post('admin/conversations','Api\Admin@conversations');
