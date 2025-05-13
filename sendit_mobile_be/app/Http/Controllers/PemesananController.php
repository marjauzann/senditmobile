<?php

namespace App\Http\Controllers;

use App\Models\Pemesanan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class PemesananController extends Controller
{
    public function create(Request $request)  // Mengubah store menjadi create
    {
        try {
            $validator = Validator::make($request->all(), [
                'id_user' => 'required',
                'id_kurir' => 'required',
                'jarak' => 'required|numeric',
                'lokasi_jemput' => 'required|string',
                'lokasi_tujuan' => 'required|string',
                'status' => 'required|string',
                'nama_penerima' => 'nullable|string'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validasi gagal',
                    'errors' => $validator->errors()
                ], 422);
            }

            $pemesanan = Pemesanan::create([
                'id_user' => $request->id_user,
                'id_kurir' => $request->id_kurir,
                'jarak' => $request->jarak,
                'lokasi_jemput' => $request->lokasi_jemput,
                'lokasi_tujuan' => $request->lokasi_tujuan,
                'status' => $request->status,
                'nama_penerima' => $request->nama_penerima
            ]);

            return response()->json($pemesanan, 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Gagal membuat pemesanan',
                'error' => $e->getMessage()
            ], 500);
        }
    }
    /**
     * Menampilkan semua data pemesanan
     */
    public function index()
    {
        try {
            $pemesanan = Pemesanan::all();
            return response()->json($pemesanan, 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Gagal mengambil data pemesanan',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Menyimpan pemesanan baru
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'id_user' => 'required|exists:users,id_user',
                'id_kurir' => 'required|exists:users,id_user',
                'jarak' => 'required|numeric',
                'lokasi_jemput' => 'required|string',
                'lokasi_tujuan' => 'required|string',
                'status' => 'required|string',
                'nama_penerima' => 'nullable|string'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validasi gagal',
                    'errors' => $validator->errors()
                ], 422);
            }

            $pemesanan = Pemesanan::create([
                'id_user' => $request->id_user,
                'id_kurir' => $request->id_kurir,
                'jarak' => $request->jarak,
                'lokasi_jemput' => $request->lokasi_jemput,
                'lokasi_tujuan' => $request->lokasi_tujuan,
                'status' => $request->status,
                'nama_penerima' => $request->nama_penerima
            ]);

            return response()->json($pemesanan, 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Gagal membuat pemesanan',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Menampilkan detail pemesanan
     */
    public function show($id)
    {
        try {
            $pemesanan = Pemesanan::findOrFail($id);
            return response()->json($pemesanan, 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Pemesanan tidak ditemukan',
                'error' => $e->getMessage()
            ], 404);
        }
    }

    /**
     * Update data pemesanan
     */
    public function update(Request $request, $id)
    {
        try {
            $pemesanan = Pemesanan::findOrFail($id);
            
            $validator = Validator::make($request->all(), [
                'id_user' => 'exists:users,id_user',
                'id_kurir' => 'exists:users,id_user',
                'jarak' => 'numeric',
                'lokasi_jemput' => 'string',
                'lokasi_tujuan' => 'string',
                'status' => 'string',
                'nama_penerima' => 'string',
                'no_hp_penerima' => 'string',
                'jenis_paket' => 'string',
                'keterangan' => 'string',
                'nama_pengirim' => 'string',
                'no_hp_pengirim' => 'string',
                'total_harga' => 'numeric',
                'metode_pembayaran' => 'string'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validasi gagal',
                    'errors' => $validator->errors()
                ], 422);
            }

            $pemesanan->update($request->all());

            return response()->json($pemesanan, 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Gagal mengupdate pemesanan',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Menghapus pemesanan
     */
    public function destroy($id)
    {
        try {
            $pemesanan = Pemesanan::findOrFail($id);
            $pemesanan->delete();

            return response()->json([
                'message' => 'Pemesanan berhasil dihapus'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Gagal menghapus pemesanan',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update status pemesanan
     */
    public function updateStatus(Request $request, $id)
    {
        try {
            $validator = Validator::make($request->all(), [
                'status' => 'required|string|in:On Progress,Selesai,Dibatalkan'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validasi gagal',
                    'errors' => $validator->errors()
                ], 422);
            }

            $pemesanan = Pemesanan::findOrFail($id);
            $pemesanan->status = $request->status;
            $pemesanan->save();

            return response()->json($pemesanan, 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Gagal mengupdate status pemesanan',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
