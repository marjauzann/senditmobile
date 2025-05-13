<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddKeteranganToPemesanansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->text('keterangan')->nullable(); // Menambahkan kolom keterangan
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
            $table->dropColumn('keterangan'); // Menghapus kolom keterangan jika migrasi dibatalkan
        });
    }
}