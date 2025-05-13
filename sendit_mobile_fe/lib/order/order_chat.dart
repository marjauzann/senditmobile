import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6C63FF),
        title: Row(
          children: [
            SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Muhammad Irawan',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  'D 1203 FE',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 115, 108, 247),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '30 Okt 24',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ChatBubble(
                    isSender: false,
                    message: "Hai, saya akan segera mengambil paket."),
                SizedBox(height: 8),
                ChatBubble(isSender: true, message: "Baik Pak"),
                SizedBox(height: 8),
                ChatBubble(isSender: true, message: "Saya tunggu"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF6C63FF)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isSender;
  final String message;

  ChatBubble({required this.isSender, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSender
              ? Color.fromARGB(255, 154, 149, 251)
              : const Color(0xFF6C63FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
