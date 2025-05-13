// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:sendit/auth/urlPort.dart';

// // PAYMENT PAGE
// class PaymentPage extends StatefulWidget {
//   final int orderId;
//   final String selectedWeight;

//   const PaymentPage({
//     super.key,
//     required this.orderId,
//     required this.selectedWeight,
//   });

//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   List<dynamic> paymentMethods = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchPaymentMethods();
//   }

//   Future<void> fetchPaymentMethods() async {
//     final response = await http.get(Uri.parse('${urlPort}api/payments/'));

//     if (response.statusCode == 200) {
//       setState(() {
//         paymentMethods = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load payment methods');
//     }
//   }

// Future<void> updatePaymentMethod(String method) async {
//   final url = Uri.parse('${urlPort}api/pemesanan/${widget.orderId}');

//   try {
//     final response = await http.put(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'metode_pembayaran': method,
//         'berat_paket': widget.selectedWeight, // Gunakan widget.selectedWeight
//       }),
//     );

//     if (response.statusCode == 200) {
//       final responseBody = json.decode(response.body); // Dekode responseBody
//       final pickupAddress = responseBody['lokasi_jemput'] ?? 'Unknown';
//       final deliveryAddress = responseBody['lokasi_tujuan'] ?? 'Unknown';
//       final tripFare = double.tryParse(responseBody['total_harga'].toString()) ?? 0.0;

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => OrderTrackingPage(
//             pickupAddress: pickupAddress,
//             deliveryAddress: deliveryAddress,
//             totalWeight: widget.selectedWeight, // Kirim widget.selectedWeight
//             tripFare: tripFare,
//             paymentMethod: method,
//           ),
//         ),
//       );
//     } else {
//       throw Exception('Failed to update payment method: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error updating payment method: $e');
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Error'),
//         content: Text('Failed to update payment method: $e'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }