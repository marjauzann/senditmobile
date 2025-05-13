import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C63FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Image.asset(
            'assets/sendit.png',
            height: 24,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          const SizedBox(width: 40),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group A
              Container(
                decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                ),
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: const [
                    Center(
                      child: Text(
                        'Package Delivered',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '30 February 2020, 11:39 AM',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Group B
              Container(
                decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                ),
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'How was the courier?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: const Color(0xFF6C63FF),
                            size: 32,
                          ),
                          onPressed: () {
                            setState(() {
                              rating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Group C
              Container(
                decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                ),
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/courier.png'),
                      ),
                      title: const Text(
                        'Muhammad',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('D 1203 FE'),
                    ),
                    const SizedBox(height: 16),
                    _buildDeliveryInfo('Catheez Putri', 'Proof of pickup'),
                    _buildDeliveryInfo('Husein Ahmad', 'Proof of delivery',
                        delivered: true),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Group D
              Container(
                decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                ),
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard('Total Weight', 'Max. 5kg'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInfoCard('Payment Method', 'DANA'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Group E
              Container(
                decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                ),
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPaymentRow('Trip fare', 'Rp28.000'),
                    _buildPaymentRow('Platform fee', 'Rp2.000'),
                    _buildPaymentRow('Extra package protection', 'Rp5.000'),
                    const Divider(),
                    _buildPaymentRow('Total', 'Rp35.000', isTotal: true),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Group F
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bill berhasil diunduh'),
                          backgroundColor: Color(0xFF413B9D),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Download bill',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryInfo(String name, String proof,
      {bool delivered = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                delivered ? Icons.assignment_turned_in : Icons.local_shipping,
                color: const Color(0xFF6C63FF),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (delivered)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Delivered',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                proof,
                style: const TextStyle(color: Colors.grey),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage('assets/proof.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String title, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isTotal ? Colors.black : Colors.grey[600],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
