<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddJenisPaketToPemesanansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->string('jenis_paket')->nullable(); // Menambahkan kolom jenis_paket
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
            $table->dropColumn('jenis_paket'); // Menghapus kolom jenis_paket jika migrasi dibatalkan
        });
    }
}