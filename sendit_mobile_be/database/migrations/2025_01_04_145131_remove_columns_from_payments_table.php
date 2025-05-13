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
        Schema::table('payments', function (Blueprint $table) {
            $table->dropForeign(['id_user']);
            $table->dropForeign(['id_pemesanan']);
            $table->dropColumn(['harga', 'id_user', 'id_pemesanan']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('payments', function (Blueprint $table) {
            $table->bigInteger('harga');
            $table->foreignId('id_user')->constrained('users', 'id_user')->onDelete('cascade');
            $table->foreignId('id_pemesanan')->constrained('pemesanans', 'id_pemesanan')->onDelete('cascade');
        });
    }
};