<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pemesanan extends Model
{
    use HasFactory;

    protected $table = 'pemesanans';
    protected $primaryKey = 'id_pemesanan';

    protected $fillable = [
        'id_user',
        'id_kurir',
        'jarak',
        'lokasi_jemput',
        'lokasi_tujuan',
        'status',
        'nama_penerima',
        'no_hp_penerima',
        'jenis_paket',
        'keterangan',
        'nama_pengirim',
        'no_hp_pengirim',
        'total_harga',
        'metode_pembayaran'
    ];

    // Relasi dengan User (pengirim)
    public function user()
    {
        return $this->belongsTo(User::class, 'id_user');
    }

    // Relasi dengan User (kurir)
    public function kurir()
    {
        return $this->belongsTo(User::class, 'id_kurir');
    }
}