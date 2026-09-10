<?php

use App\Http\Controllers\RegisterController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return redirect()->route('register.form');
});

Route::get('/register', [RegisterController::class, 'showForm'])
    ->name('register.form');

Route::post('/register', [RegisterController::class, 'register'])
    ->name('register.submit');
