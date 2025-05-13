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
        Schema::create('pemesanans', function (Blueprint $table) {
            $table->id('id_pemesanan');
            $table->unsignedBigInteger('id_user');
            $table->foreign('id_user')->references('id_user')->on('users')->onDelete('cascade');
            $table->integer('jarak');
            $table->string('lokasi_jemput');
            $table->string('lokasi_tujuan');
            $table->enum('status', ['On Progress', 'Selesai'])->default('On Progress');
            $table->string('nama_penerima');
            $table->unsignedBigInteger('id_kurir');
            $table->foreign('id_kurir')->references('id_user')->on('users')->onDelete('cascade');
            $table->timestamps();
        });
    }
    

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pemesanans');
    }
};
