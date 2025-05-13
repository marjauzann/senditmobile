import 'package:flutter/material.dart';
import 'package:sendit/Kurir/Auth/LoginKurir.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:sendit/auth/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background putih
          Container(
            color: Colors.white,
          ),

          // Gelombang ungu dengan WaveWidget
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [const Color(0xFF4338CA), const Color(0xFF6366F1)],
                    [const Color(0xFF6366F1), const Color(0xFF818CF8)],
                  ],
                  durations: [35000, 19440],
                  heightPercentages: [0.35, 0.45],
                  blur: const MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 10,
                size: const Size(
                    double.infinity, 1000), // Ukuran tinggi gelombang
              ),
            ),
          ),

          // Konten utama
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: Column(
                  children: [
                    // Logo dan welcome text section
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        Container(
                          width: 250,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset('assets/dasLogo.png'),
                        ),
                        const SizedBox(height: 50),
                        const SizedBox(height: 150),
                        // Welcome text
                        const Text(
                          'Selamat Datang\ndi SendIt',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Pilih kategori pengguna',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),

                        // Buttons
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginKurir()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(0xFF5C3BFF),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xFF5C3BFF),
                                      width: 1,
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Kurir',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color(0xFF5C3BFF),
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Pengirim',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),  
              ),
            ),
          ),
        ],
      ),
    );
  }
}
