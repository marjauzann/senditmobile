<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddNoHpPengirimToPemesanansTable extends Migration
{
    public function up()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->string('no_hp_pengirim')->nullable(); // Menambahkan kolom no_hp_pengirim
        });
    }

    public function down()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->dropColumn('no_hp_pengirim'); // Menghapus kolom no_hp_pengirim jika migrasi dibatalkan
        });
    }
}