<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{
    public function index()
    {
        $users = User::all();
        return response()->json($users);
    }
    public function getUser($id_user)
    {
        $user = User::where('id_user', $id_user)->first();
        if ($user) {
            return response()->json($user, 200);
        } else {
            return response()->json(['message' => 'User not found'], 404);
        }
    }
}
