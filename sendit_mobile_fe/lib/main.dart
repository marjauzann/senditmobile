import 'package:flutter/material.dart';
import 'package:sendit/FAQ/faqPage.dart';
import 'package:sendit/home/ProfilePage.dart';
import 'package:sendit/home/WelcomeScreen.dart';
import 'package:sendit/home/homepage.dart';
import 'package:sendit/home/historyPage.dart';
import 'package:sendit/local_notifications.dart';
import 'package:sendit/order/orderPage.dart';
import 'package:sendit/order/order_chat.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'Kurir/Auth/LoginKurir.dart';
import 'order/orderPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SendIt!',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: const WelcomeScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => const MainScreen(),
        '/OrderPage': (context) => const OrderPage(),
        '/FAQPage': (context) => FAQPage(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const HistoryPage(),
    // const Placeholder(), // Tracking page placeholder
    const ProfilePage(), // Profile page placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF6C63FD),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.location_on), label: 'Tracking'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
