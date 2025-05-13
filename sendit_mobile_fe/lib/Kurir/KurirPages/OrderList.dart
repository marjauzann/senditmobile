import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sendit/auth/urlPort.dart';
class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  String getWeightCategory(dynamic tarif) {
    double harga = 0;
    
    if (tarif is String) {
      harga = double.tryParse(tarif.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    } else if (tarif is num) {
      harga = tarif.toDouble();
    }

    if (harga == 30000) {
      return 'Kecil (Maks 5kg)';
    } else if (harga == 45000) {
      return 'Sedang (Maks 20kg)';
    } else if (harga == 60000) {
      return 'Besar (Maks 100kg)';
    }
    return 'Tidak diketahui';
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(
        Uri.parse('${urlPort}api/pemesanan'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (mounted) {
          setState(() {
            orders = data.map((item) => {
              'id': item['id_pemesanan'].toString(),
              'jemput': item['lokasi_jemput'] ?? 'Alamat tidak tersedia',
              'antar': item['lokasi_tujuan'] ?? 'Alamat tidak tersedia',
              'tarif': 'Rp${item['total_harga']}',
              'jarak': getWeightCategory(item['total_harga']),
            }).toList();
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to load orders: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : orders.isEmpty 
          ? const Center(child: Text('Tidak ada pesanan'))
          : RefreshIndicator(
              onRefresh: fetchOrders,
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderItem(
                    order: Map<String, String>.from(orders[index]),
                    onOrderDeleted: fetchOrders,
                  );
                },
              ),
            ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Map<String, String> order;
  final VoidCallback? onOrderDeleted;

  const OrderItem({
    required this.order,
    this.onOrderDeleted,
    super.key,
  });

  Future<void> deleteOrder(BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse('${urlPort}api/pemesanan/${order['id']}'),
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pesanan berhasil ditolak')),
          );
          onOrderDeleted?.call();
        }
      } else {
        throw Exception('Failed to delete order: ${response.statusCode}');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order['jarak'] ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const PhosphorIcon(
                PhosphorIconsDuotone.package,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  order['antar'] ?? 'Alamat tidak tersedia',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Tarif: ${order['tarif'] ?? 'Tidak tersedia'}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => deleteOrder(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tolak',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pesanan diterima')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Terima',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}