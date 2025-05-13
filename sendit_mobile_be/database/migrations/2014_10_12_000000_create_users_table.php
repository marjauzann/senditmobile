<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id('id_user'); 
            $table->string('nama');
            $table->text('alamat');
            $table->string('no_hp');
            $table->string('email')->unique();
            $table->string('username')->unique();
            $table->string('password');
            $table->timestamp('email_verified_at')->nullable();
            $table->rememberToken();
            $table->enum('role', ['admin', 'kurir', 'pemesan'])->default('pemesan');
            $table->timestamps();
        });
    
        // $table->string('password');
       
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
