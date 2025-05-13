import 'package:flutter/material.dart';
import 'package:sendit/Kurir/KurirPages/HistoryKurir.dart';
import 'BottomNavigation.dart';
import 'package:sendit/Kurir/KurirPages/OrderList.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sendit/FAQ/faqPage.dart';

class HomeKurir extends StatefulWidget {
  const HomeKurir({super.key});

  @override
  _HomeKurirState createState() => _HomeKurirState();
}

class _HomeKurirState extends State<HomeKurir> {
  bool isSwitched = false;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C63FF),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/sendit.png',
                        height: 24,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Muhammad',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/profile.png'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView( // Added ScrollView to handle overflow
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Switch section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Menerima Pesanan',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Switch(
                              value: isSwitched,
                              activeColor: const Color(0xFF6C63FF),
                              onChanged: (bool value) {
                                setState(() {
                                  isSwitched = value;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isSwitched
                                            ? 'Anda mulai menerima pesanan'
                                            : 'Anda tidak menerima pesanan',
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Illustration section
                        Center(
                          child: Image.asset(
                            'assets/kurir.png',
                            height: 180, // Reduced height slightly
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Tombol Pesanan
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const OrderListPage()),
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.local_shipping_outlined,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Terima Pesanan!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Banyak Pelanggan yang menunggu\nkehadiran mu, semangat!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // FAQ section
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FAQPage()),
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.help_outline,
                                      color: Color(0xFF6C63FF),
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'FAQ!',
                                            style: TextStyle(
                                              color: Color(0xFF6C63FF),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Anda memiliki pertanyaan? Silahkan mengakses fitur ini',
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF6C63FF),
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}