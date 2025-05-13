<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->decimal('total_harga', 10, 2)->nullable();
            $table->string('metode_pembayaran')->nullable();
        });
    }
    
    public function down()
    {
        Schema::table('pemesanans', function (Blueprint $table) {
            $table->dropColumn(['total_harga', 'metode_pembayaran']);
        });
    }
};
