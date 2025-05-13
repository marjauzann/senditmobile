<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddNoHpPenerimaToPemesanansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->string('no_hp_penerima', 15)->nullable(); // Menambahkan kolom no_hp_penerima
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->dropColumn('no_hp_penerima'); // Menghapus kolom no_hp_penerima jika migrasi dibatalkan
        });
    }
}