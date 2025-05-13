import 'package:flutter/material.dart';
import 'package:sendit/home/historyPage.dart';
import 'package:sendit/local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPeriodicNotificationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: const Text('Nyalakan Notifikasi'),
                  secondary: const Icon(Icons.notifications_outlined),
                  value: _isPeriodicNotificationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _isPeriodicNotificationEnabled = value;
                      if (value) {
                        LocalNotifications.showSimpleNotification(
                          title: "Bro, paketnya udah dikirim?",
                          body: "Jangan sampai teman kamu nungguin terus!",
                          payload: "This is periodic data",
                        );
                      }
                    });
                  },
                ),
                _buildPromoSection(context),
                const SizedBox(height: 24),
                _buildFeatureSection(context),
                const SizedBox(height: 24),
                _buildCategorySection(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: const Color(0xFF4834DF),
    elevation: 0,
    title: const Text(
      'SendIt!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    actions: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Text(
              'User',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile_image.png'),
              radius: 20,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildPromoSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Promo Menarik',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6C63FD), Color(0xFF4834DF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Buat Tetangga!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Diskon hingga 30% untuk pengiriman dalam kota',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke OrderInformationPage
                      Navigator.pushNamed(context, '/OrderPage');
                    },
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.white,
                      shadowColor: const Color(0xFF6C63FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Kirim Sekarang!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromARGB(255, 232, 231, 255),
              ),
              child: Image.asset(
                'assets/ilustrasi_login.png',
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildFeatureSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Fitur',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              width: 150,
              height: 110,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4834DF), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                ),
                onPressed: () {
                  // Navigasi ke OrderInformationPage
                  Navigator.pushNamed(context, '/OrderPage');
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_shipping, // Shipping icon
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Kirim Barang',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              width: 150,
              height: 110,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF4834DF), // Background color for FAQ
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                ),
                onPressed: () {
                  // Aksi untuk FAQ
                  Navigator.pushNamed(context, '/FAQPage');
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help_outline, // FAQ icon
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'FAQ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildCategorySection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Pilih Kategori',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              width: 150,
              height: 110,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4834DF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                onPressed: () {
                  // Navigasi ke kategori ringan
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.indeterminate_check_box_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ringan',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              width: 150,
              height: 110,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF4834DF), // Background color for FAQ
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                ),
                onPressed: () {
                  // Navigasi ke kategori berat
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_box_outlined, //
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Berat',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
