import 'package:flutter/material.dart';
import 'package:sendit/Kurir/Auth/LoginKurir.dart';
import '../../auth/login.dart';

class Registerkurir extends StatefulWidget {
  const Registerkurir({super.key});

  @override
  _RegisterkurirState createState() => _RegisterkurirState();
}

class _RegisterkurirState extends State<Registerkurir> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    // color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/ilustrasi_login.png',
                      fit: BoxFit.contain,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Daftar Sebagai Kurir',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama Pengguna',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan nama pengguna';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan email';
                    }
                    // Add email validation if needed
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan kata sandi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Kata Sandi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon konfirmasi kata sandi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginKurir()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      // iconColor: Colors.blue,
                      backgroundColor: const Color.fromARGB(255, 66, 72, 255),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginKurir()));
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah memiliki akun?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginKurir()));
                      },
                      child: const Text('Masuk'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Dengan mendaftar berarti Anda setuju dengan\nSyarat & Ketentuan yang berlaku',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
