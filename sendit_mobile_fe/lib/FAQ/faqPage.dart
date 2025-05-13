import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FAQPage(),
    );
  }
}

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      "question": "Apa itu SendIt?",
      "answer":
          "SendIt adalah sebuah aplikasi mobile yang dirancang untuk memfasilitasi pengiriman dan penerimaan paket dengan mudah dan efisien. Dengan antarmuka yang intuitif, SendIt memberikan kemudahan bagi pengguna, khususnya mahasiswa di lingkungan kampus, dalam mengelola pengiriman barang. Aplikasi ini dilengkapi dengan fitur pelacakan, integrasi dengan jasa kurir terpercaya."
    },
    {
      "question": "Bagaimana cara mengirim paket melalui SendIt?",
      "answer":
          "Anda dapat memilih layanan pengiriman yang diinginkan, memasukkan detail paket, dan melacak pengiriman dari aplikasi. Setelah paket diserahkan ke kurir, pengguna akan menerima notifikasi dan bisa memantau kiriman hingga sampai tujuan."
    },
    {
      "question":
          "Apakah SendIt bisa digunakan oleh umum atau hanya untuk mahasiswa?",
      "answer":
          "Aplikasi SendIt dirancang terutama untuk mahasiswa di lingkungan kampus, namun bisa juga digunakan oleh siapa saja di area sekitar kampus yang membutuhkan layanan pengiriman."
    },
    {
      "question": "Bagaimana saya bisa melacak paket saya di SendIt?",
      "answer":
          "Fitur pelacakan di aplikasi SendIt memungkinkan Anda memantau status paket secara real-time. Setiap pembaruan status akan diinformasikan langsung melalui notifikasi aplikasi."
    },
    {
      "question":
          "Apakah ada batasan jenis barang yang bisa dikirim melalui SendIt?",
      "answer":
          "Ya, SendIt memiliki ketentuan terkait barang yang dapat dikirim. Barang-barang berbahaya atau ilegal tidak diperbolehkan, dan pengguna disarankan untuk memeriksa syarat dan ketentuan terkait batasan tersebut."
    },
    {
      "question": "Berapa biaya pengiriman melalui aplikasi SendIt?",
      "answer":
          "Biaya pengiriman bervariasi tergantung jarak pengiriman, ukuran, dan berat paket. Informasi lebih lanjut dapat dilihat langsung di aplikasi sebelum melakukan pengiriman."
    },
    {
      "question": "Apakah SendIt memiliki opsi pengiriman instan?",
      "answer":
          "Saat ini SendIt belum memiliki fitur tersebut, kedepannya akan kami kembangkan lagi."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4834DF),
        title: Text(
          'FAQ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ExpansionTile(
                title: Text(
                  faqs[index]['question']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(faqs[index]['answer']!),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
