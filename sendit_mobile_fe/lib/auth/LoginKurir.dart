import 'package:flutter/material.dart';
import 'package:sendit/Kurir/Auth/RegisterKurir.dart';
import 'package:sendit/main.dart';
import 'package:sendit/auth/forgotpw.dart';

class LoginKurir extends StatefulWidget {
  const LoginKurir({super.key});

  @override
  _LoginKurirState createState() => _LoginKurirState();
}

class _LoginKurirState extends State<LoginKurir> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _rememberMe = false;

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
                      'assets/kurir.png',
                      fit: BoxFit.contain,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Login Sebagai Kurir',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 1, 10)),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama Kurir/Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan nama Kurir atau email';
                    }
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                        const Text('Ingat Sandi'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Text('Lupa Sandi?'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 66, 72, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Atau",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () {
                    // Ini gimana implemennya??
                  },
                  icon: const Icon(Icons.apple),
                  label: const Text('Lanjutkan dengan Apple ID'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.indigo,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum memiliki akun?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registerkurir()));
                      },
                      child: const Text('Daftar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
