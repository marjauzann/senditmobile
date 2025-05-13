<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddNamaPengirimToPemesanansTable extends Migration
{
    public function up()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->string('nama_pengirim')->nullable(); // Menambahkan kolom nama_pengirim
        });
    }

    public function down()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->dropColumn('nama_pengirim'); // Menghapus kolom nama_pengirim jika migrasi dibatalkan
        });
    }
}