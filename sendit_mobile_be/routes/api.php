<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\PemesananController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\AuthController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);
Route::get('/user/{id}', [UserController::class, 'getUser']);
Route::get('/users', [UserController::class, 'index']);
Route::get('/pemesanan/{id}', [PemesananController::class, 'show']);
Route::get('/pemesanans', [PemesananController::class, 'index']);
Route::post('/pemesanan', [PemesananController::class, 'create']);
Route::put('/pemesanan/{id}', [PemesananController::class, 'update']);
Route::delete('/pemesanan/{id}', [PemesananController::class, 'delete']);
Route::prefix('pemesanan')->group(function () {
          Route::get('/', [PemesananController::class, 'index']);
          Route::post('/', [PemesananController::class, 'store']);
          Route::get('/{id}', [PemesananController::class, 'show']);
          Route::put('/{id}', [PemesananController::class, 'update']);
          Route::delete('/{id}', [PemesananController::class, 'destroy']);
          Route::patch('/{id}/status', [PemesananController::class, 'updateStatus']);
      });
Route::get('/payments/{id}', [PaymentController::class, 'show']);
Route::get('/payments', [PaymentController::class, 'index']);
Route::post('/payments', [PaymentController::class, 'create']);
Route::put('/payments/{id}', [PaymentController::class, 'update']);
Route::delete('/payments/{id}', [PaymentController::class, 'delete']);