// import 'package:flutter/material.dart';
// import '/order/order_tracking_page.dart'; // Pastikan untuk mengimpor halaman OrderTrackingPage

// class PaymentPage extends StatefulWidget {
//   const PaymentPage({super.key});

//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   String? _selectedPaymentMethod;
//   String? _selectedEWallet;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Set background color to white
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF6C63FF),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/sendit.png',
//               height: 24,
//               color: Colors.white,
//             ),
//             const SizedBox(width: 8),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Handle profile action
//             },
//             child: const Text(
//               'Profile',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTotalAmount(),
//             const SizedBox(height: 24),
//             _buildPaymentMethodSelection(),
//             const SizedBox(height: 24),
//             if (_selectedPaymentMethod == 'E-Wallet') _buildEWalletOptions(),
//             if (_selectedPaymentMethod == 'Bank') _buildBankOptions(),
//             const Spacer(), // Pushes the buttons to the bottom
//             _buildConfirmationButtons(context), // Pass context here
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTotalAmount() {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Besar Tagihan',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Rp. xxx.xxx.xxx,xx',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF6C63FF),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPaymentMethodSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Metode Pembayaran',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () => setState(() => _selectedPaymentMethod = 'E-Wallet'),
//                 style: OutlinedButton.styleFrom(
//                   side: BorderSide(
//                     color: _selectedPaymentMethod == 'E-Wallet'
//                         ? const Color(0xFF6C63FF)
//                         : Colors.grey,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text('E-Wallet'),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () => setState(() => _selectedPaymentMethod = 'Bank'),
//                 style: OutlinedButton.styleFrom(
//                   side: BorderSide(
//                     color: _selectedPaymentMethod == 'Bank'
//                         ? const Color(0xFF6C63FF)
//                         : Colors.grey,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text('Bank'),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildEWalletOptions() {
//     return Column(
//       children: [
//         _buildEWalletOption('GoPay', 'Biaya Admin Rp.1000', 'assets/gopay.png'),
//         _buildEWalletOption('Dana', 'Biaya Admin Rp.1500', 'assets/dana.png'),
//         _buildEWalletOption('ShopeePay', 'Biaya Admin Rp.1250', 'assets/shopeepay.png'),
//       ],
//     );
//   }

//   Widget _buildEWalletOption(String name, String adminFee, String logoAsset) {
//     return GestureDetector(
//       onTap: () => setState(() => _selectedEWallet = name),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: _selectedEWallet == name ? const Color(0xFF6C63FF) : Colors.grey[300]!,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Image.asset(logoAsset, width: 40, height: 40),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                   Text(adminFee, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//                 ],
//               ),
//             ),
//             if (_selectedEWallet == name)
//               const Icon(Icons.check_circle, color: Color(0xFF6C63FF)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBankOptions() {
//     return Column(
//       children: [
//         _buildBankOption('BNI', 'Biaya Admin Rp.2000', 'assets/bni.png'),
//         _buildBankOption('BCA', 'Biaya Admin Rp.3000', 'assets/bca.png'),
//       ],
//     );
//   }

//   Widget _buildBankOption(String name, String adminFee, String logoAsset) {
//     return GestureDetector(
//       onTap: () => setState(() {
//         _selectedEWallet = name; // This is a temporary placeholder
//       }),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: _selectedEWallet == name ? const Color(0xFF6C63FF) : Colors.grey[300]!,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Image.asset(logoAsset, width: 40, height: 40),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                   Text(adminFee, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//                 ],
//               ),
//             ),
//             if (_selectedEWallet == name)
//               const Icon(Icons.check_circle, color: Color(0xFF6C63FF)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildConfirmationButtons(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: _selectedPaymentMethod != null ? () {
//             // Navigate to Order Tracking Page on confirmation
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const OrderTrackingPage()),
//             );
//           } : null,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF6C63FF),
//             minimumSize: const Size(double.infinity, 50),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25),
//             ),
//           ),
//           child: const Text('Konfirmasi', style: TextStyle(fontSize: 16, color: Colors.white)),
//         ),
//         const SizedBox(height: 12),
//         OutlinedButton(
//           onPressed: () {
//             // Handle cancellation
//           },
//           style: OutlinedButton.styleFrom(
//             side: const BorderSide(color: Color(0xFF6C63FF)),
//             minimumSize: const Size(double.infinity, 50),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25),
//             ),
//           ),
//           child: const Text('Batal', style: TextStyle(fontSize: 16, color: Color(0xFF6C63FF))),
//         ),
//       ],
//     );
//   }
// }
