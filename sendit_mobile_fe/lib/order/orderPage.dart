//last update 19/12 18:24
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sendit/auth/urlPort.dart';

// ORDER PAGE
class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String selectedWeight = 'Kecil (Maks 5kg)';
  double totalDistance = 10.0;
  double price = 0.0;
  final int id_user = 1; // Sesuaikan dengan user yang sedang login
  final int id_kurir = 3; // Contoh id kurir

  final TextEditingController senderAddressController = TextEditingController();
  final TextEditingController receiverAddressController = TextEditingController();

  String? senderAddressError;
  String? receiverAddressError;

  @override
  void initState() {
    super.initState();
    _calculatePrice();
  }

  Future<void> submitOrder() async {
    final url = Uri.parse('${urlPort}api/pemesanan');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id_user': id_user,
          'id_kurir': id_kurir,
          'jarak': totalDistance,
          'lokasi_jemput': senderAddressController.text,
          'lokasi_tujuan': receiverAddressController.text,
          'status': 'On Progress',
          'nama_penerima': 'Tes A',
          'total_harga': price,
          'metode_pembayaran': 'QRIS'
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final orderData = json.decode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderInformationPage(
              orderId: orderData['id_pemesanan'],
              totalPrice: price,
              selectedWeight: selectedWeight,
              ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to create order: ${response.statusCode}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error detail: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to connect to server: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _calculatePrice() {
    double pricePerKm = 3000;
    double weightFactor;

    if (selectedWeight == 'Kecil (Maks 5kg)') {
      weightFactor = 1.0;
    } else if (selectedWeight == 'Sedang (Maks 20kg)') {
      weightFactor = 1.5;
    } else {
      weightFactor = 2.0;
    }

    setState(() {
      price = totalDistance * pricePerKm * weightFactor;
    });
  }

  bool _validateInputs() {
    setState(() {
      senderAddressError =
          senderAddressController.text.isEmpty ? 'Alamat pengirim harus diisi.' : null;
      receiverAddressError =
          receiverAddressController.text.isEmpty ? 'Alamat penerima harus diisi.' : null;
    });

    return senderAddressError == null && receiverAddressError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/sendit.png',
              height: 24,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
          ],
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.png'),
            radius: 16,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Kirim Barang!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Ambil paket di',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildAddressInput(senderAddressController, senderAddressError,
                  'Masukkan alamat pengirim...', Icons.home),
              const SizedBox(height: 12),

              const Text(
                'Alamat Penerima',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildAddressInput(
                  receiverAddressController,
                  receiverAddressError,
                  'Cari alamat penerima...',
                  Icons.search),

              const SizedBox(height: 12),
              _buildDistanceInfo(),

              const SizedBox(height: 24),
              const Text(
                'Pilih Berat Paket',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildWeightSelectionBox(),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saved addresses',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print("View All clicked");
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildSavedAddress('Rumah Catheez', 'Jl. Kembang Kertas No. 1'),
              const SizedBox(height: 12),
              _buildSavedAddress('Rumah Mama', 'Jl. Bunga Matahari No. 3'),
              const SizedBox(height: 24),

              _buildPriceInfo(),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () async {
                  if (_validateInputs()) {
                    await submitOrder();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Lanjutkan',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressInput(TextEditingController controller, String? errorText,
      String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
                color: errorText == null ? Colors.transparent : Colors.red),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  onSubmitted: (value) {
                    print("Search for: $value");
                  },
                ),
              ),
            ],
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildDistanceInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Jarak Pengiriman',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('$totalDistance km', style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildWeightSelectionBox() {
    return GestureDetector(
      onTap: () {
        _showWeightSelectionDialog();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey[300]!)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedWeight, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Future<void> _showWeightSelectionDialog() async {
    String? selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String tempWeight = selectedWeight;
        return AlertDialog(
          title: const Text('Pilih Berat Paket'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Kecil (Maks 5kg)'),
                value: 'Kecil (Maks 5kg)',
                groupValue: tempWeight,
                onChanged: (value) {
                  setState(() {
                    tempWeight = value!;
                  });
                  Navigator.pop(context, tempWeight);
                },
              ),
              RadioListTile<String>(
                title: const Text('Sedang (Maks 20kg)'),
                value: 'Sedang (Maks 20kg)',
                groupValue: tempWeight,
                onChanged: (value) {
                  setState(() {
                    tempWeight = value!;
                  });
                  Navigator.pop(context, tempWeight);
                },
              ),
              RadioListTile<String>(
                title: const Text('Besar (Maks 100kg)'),
                value: 'Besar (Maks 100kg)',
                groupValue: tempWeight,
                onChanged: (value) {
                  setState(() {
                    tempWeight = value!;
                  });
                  Navigator.pop(context, tempWeight);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedWeight = selected;
        _calculatePrice();
      });
    }
  }

  Widget _buildPriceInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Harga Pengiriman',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          'Rp ${price.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 18, color: Colors.green)
        ),
      ],
    );
  }

  Widget _buildSavedAddress(String name, String address) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Color(0xFF6C63FF)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                address,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ORDER INFORMATION PAGE
class OrderInformationPage extends StatefulWidget {
  final int orderId;
  final double totalPrice;  // Add this field
  final String selectedWeight;
  const OrderInformationPage({
    Key? key,
    required this.orderId,
    required this.totalPrice, 
    required this.selectedWeight, // Add this parameter
  }) : super(key: key);

  @override
  _OrderInformationPageState createState() => _OrderInformationPageState();
}

class _OrderInformationPageState extends State<OrderInformationPage> {
  String? selectedPackageType;
  final TextEditingController senderNameController = TextEditingController();
  final TextEditingController senderNumberController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverNumberController = TextEditingController();
  final TextEditingController otherPackageController = TextEditingController();
  String selectedPaymentMethod = 'QRIS'; // Default payment method

  String? senderNameError;
  String? senderNumberError;
  String? receiverNameError;
  String? receiverNumberError;
  String? packageTypeError;
  String? otherPackageError;

Future<void> updateOrderWithReceiverInfo(String selectedWeight) async {
  final url = Uri.parse('${urlPort}api/pemesanan/${widget.orderId}');

  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'nama_penerima': receiverNameController.text,
        'no_hp_penerima': receiverNumberController.text,
        'jenis_paket': selectedPackageType ?? '',
        'keterangan': selectedPackageType == 'Lainnya'
            ? otherPackageController.text
            : selectedPackageType ?? '',
        'nama_pengirim': senderNameController.text,
        'no_hp_pengirim': senderNumberController.text,
        'berat_paket': selectedWeight, // Kirim selectedWeight
        'total_harga': widget.totalPrice,
        'metode_pembayaran': selectedPaymentMethod,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            orderId: widget.orderId,
            selectedWeight: selectedWeight, // Teruskan ke PaymentPage
          ),
        ),
      );
    } else {
      throw Exception('Failed to update order: ${response.statusCode}');
    }
  } catch (e) {
    print('Error updating order: $e');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('Failed to update order: $e'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/sendit.png',
              height: 24,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
          ],
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.png'),
            radius: 16,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Informasi Pengirim',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildInputField('Nama Pengirim', senderNameController, senderNameError),
            const SizedBox(height: 16),
            _buildNumberInputField('Nomor Pengirim', senderNumberController, senderNumberError),
            const SizedBox(height: 24),

            const Text(
              'Informasi Penerima',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildInputField('Nama Penerima', receiverNameController, receiverNameError),
            const SizedBox(height: 16),
            _buildNumberInputField('Nomor Penerima', receiverNumberController, receiverNumberError),
            const SizedBox(height: 24),

            const Text(
              'Detail Paket',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPackageTypeButtons(() {
              if (selectedPackageType == null) {
                setState(() {
                  packageTypeError = 'Silakan pilih jenis paket.';
                });
              } else {
                setState(() {
                  packageTypeError = null;
                });
              }
            }),
            if (packageTypeError != null) ...[
              const SizedBox(height: 4),
              Text(
                packageTypeError!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
            if (selectedPackageType == 'Lainnya') ...[
              const SizedBox(height: 16),
              _buildInputField('Jenis Paket Lainnya', otherPackageController, otherPackageError),
            ],
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                if (_validateInput()) {
                  updateOrderWithReceiverInfo(widget.selectedWeight);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Lanjutkan',
                style: TextStyle(fontSize: 16, color: Colors.white)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, String? error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: error != null ? Colors.red : Colors.transparent,
                width: 1.5),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ],
    );
  }

  Widget _buildNumberInputField(String label, TextEditingController controller, String? error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: error != null ? Colors.red : Colors.transparent,
                width: 1.5),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(13),
            ],
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ],
    );
  }

  Widget _buildPackageTypeButtons(Function onPackageSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPackageButton('Makanan', Icons.fastfood, onPackageSelected),
        _buildPackageButton('Baju', Icons.checkroom, onPackageSelected),
        _buildPackageButton('Dokumen', Icons.folder, onPackageSelected),
        _buildPackageButton('Obat-obatan', Icons.medical_services, onPackageSelected),
        _buildPackageButton('Buku', Icons.book, onPackageSelected),
        _buildPackageButton('Lainnya', Icons.add, onPackageSelected),
      ],
    );
  }

  Widget _buildPackageButton(String label, IconData icon, Function onPackageSelected) {
    return GestureDetector(
      onTap: () {
      setState(() {
        selectedPackageType = label;
        // Jika bukan "Lainnya", langsung set keterangan sesuai label
        if (label != 'Lainnya') {
          otherPackageController.text = label;
        } else {
          // Jika "Lainnya", kosongkan controller untuk diisi manual
          otherPackageController.clear();
        }
        onPackageSelected();
      });
    },
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selectedPackageType == label
                ? const Color(0xFF6C63FF)
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon,
              color: selectedPackageType == label ? Colors.white : Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
              color: selectedPackageType == label ? Colors.black : Colors.black),
        ),
      ],
    ),
  );
}

bool _validateInput() {
    bool isValid = true;

    setState(() {
      // Sender validation
      if (senderNameController.text.isEmpty) {
        senderNameError = 'Nama Pengirim harus diisi';
        isValid = false;
      } else {
        senderNameError = null;
      }

      if (senderNumberController.text.isEmpty) {
        senderNumberError = 'Nomor Pengirim harus diisi';
        isValid = false;
      } else if (senderNumberController.text.length < 10 || 
                 senderNumberController.text.length > 13) {
        senderNumberError = 'Nomor Pengirim harus 10-13 digit';
        isValid = false;
      } else {
        senderNumberError = null;
      }

      // Receiver validation
      if (receiverNameController.text.isEmpty) {
        receiverNameError = 'Nama Penerima harus diisi';
        isValid = false;
      } else {
        receiverNameError = null;
      }

      if (receiverNumberController.text.isEmpty) {
        receiverNumberError = 'Nomor Penerima harus diisi';
        isValid = false;
      } else if (receiverNumberController.text.length < 10 || 
                 receiverNumberController.text.length > 13) {
        receiverNumberError = 'Nomor Penerima harus 10-13 digit';
        isValid = false;
      } else {
        receiverNumberError = null;
      }

      // Package type validation
      if (selectedPackageType == null) {
        packageTypeError = 'Pilih jenis paket';
        isValid = false;
      } else {
        packageTypeError = null;
        
        // Only validate other package input if "Lainnya" is selected
        if (selectedPackageType == 'Lainnya') {
          if (otherPackageController.text.isEmpty) {
            otherPackageError = 'Isi detail jenis paket';
            isValid = false;
          } else {
            otherPackageError = null;
          }
        } else {
          // Clear any existing error for other package when not "Lainnya"
          otherPackageError = null;
        }
      }
    });

    return isValid;
}
}

// PAYMENT PAGE
class PaymentPage extends StatefulWidget {
  final int orderId;
  final String selectedWeight;

  const PaymentPage({
    super.key,
    required this.orderId,
    required this.selectedWeight,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<dynamic> paymentMethods = [];

  @override
  void initState() {
    super.initState();
    fetchPaymentMethods();
  }

  Future<void> fetchPaymentMethods() async {
    final response = await http.get(Uri.parse('${urlPort}api/payments/'));

    if (response.statusCode == 200) {
      setState(() {
        paymentMethods = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load payment methods');
    }
  }

Future<void> updatePaymentMethod(String method) async {
  final url = Uri.parse('${urlPort}api/pemesanan/${widget.orderId}');

  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'metode_pembayaran': method,
        'berat_paket': widget.selectedWeight, // Gunakan widget.selectedWeight
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body); // Dekode responseBody
      final pickupAddress = responseBody['lokasi_jemput'] ?? 'Unknown';
      final deliveryAddress = responseBody['lokasi_tujuan'] ?? 'Unknown';
      final tripFare = double.tryParse(responseBody['total_harga'].toString()) ?? 0.0;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderTrackingPage(
            pickupAddress: pickupAddress,
            deliveryAddress: deliveryAddress,
            totalWeight: widget.selectedWeight, // Kirim widget.selectedWeight
            tripFare: tripFare,
            paymentMethod: method,
          ),
        ),
      );
    } else {
      throw Exception('Failed to update payment method: ${response.statusCode}');
    }
  } catch (e) {
    print('Error updating payment method: $e');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('Failed to update payment method: $e'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text('Pembayaran'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: paymentMethods.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Pilih Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...paymentMethods.map((method) {
                    return _buildPaymentMethod(
                      method['metode_pembayaran'],
                      'Bayar dengan ${method['metode_pembayaran']}',
                      Icons.payment,
                      () async {
                        await updatePaymentMethod(method['metode_pembayaran']);
                      },
                    );
                  }).toList(),
                ],
              ),
      ),
    );
  }

  Widget _buildPaymentMethod(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6C63FF)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

// ORDER TRACKING PAGE
class OrderTrackingPage extends StatelessWidget {
  final String pickupAddress;
  final String deliveryAddress;
  final String totalWeight; // Sudah menerima totalWeight
  final double tripFare;
  final String paymentMethod; 

  const OrderTrackingPage({
    Key? key,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.totalWeight,
    required this.tripFare,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double platformFee = 0;
    const double extraPackageProtection = 0;
    final double totalCost = tripFare + platformFee + extraPackageProtection;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text(
          'Order Tracking',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage()),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTrackingStatus(),
              const SizedBox(height: 20),
              _buildCourierInfo(context),
              const SizedBox(height: 20),
              _buildAddressSection('Pickup Address', pickupAddress),
              const SizedBox(height: 20),
              _buildAddressSection('Delivery Address', deliveryAddress),
              const SizedBox(height: 20),
              _buildWeightSection(totalWeight), // Tampilkan totalWeight
              const SizedBox(height: 20),
              _buildPaymentDetails(tripFare, platformFee, extraPackageProtection, totalCost, paymentMethod),
              const SizedBox(height: 30),
              _buildDeliveryStatus(),
              const SizedBox(height: 20),
              _buildCancelButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeightSection(String weight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Weight',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(weight), // Menampilkan berat yang diterima dari navigasi
      ],
    );
  }
}

  Widget _buildTrackingStatus() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Menjemput paket dalam 1 menit',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/sendit.png',
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildCourierInfo(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/darwin.png'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Muhammad Irawan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'D 1203 FE',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.chat, color: Color(0xFF6C63FF)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatPage()),
                      );
                    },
                  ),
                  const SizedBox(width: 24),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.phone, color: Color(0xFF6C63FF)),
                    onPressed: () {
                      // Handle phone call action
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection(String title, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          address,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildWeightSection(String weight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Weight',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(weight),
      ],
    );
  }

Widget _buildPaymentDetails(
    double tripFare, double platformFee, double extraPackageProtection, double totalCost, String paymentMethod) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Payment Details',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      _buildPaymentDetailRow('Trip fare', 'Rp ${tripFare.toStringAsFixed(0)}'),
      _buildPaymentDetailRow('Platform fee', 'Rp ${platformFee.toStringAsFixed(0)}'),
      _buildPaymentDetailRow('Extra package protection', 'Rp ${extraPackageProtection.toStringAsFixed(0)}'),
      const Divider(),
      _buildPaymentDetailRow('Total', 'Rp ${totalCost.toStringAsFixed(0)}', isTotal: true),
      const SizedBox(height: 8),
      _buildPaymentDetailRow('Payment Method', paymentMethod), // Tampilkan metode pembayaran
    ],
  );
}


  Widget _buildPaymentDetailRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showCancelConfirmationDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Batalkan Pesanan',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Pembatalan'),
          content: const Text('Apakah anda yakin untuk membatalkan pesanan?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Tidak',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Ya',
                style: TextStyle(
                  color: Color(0xFF6C63FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }

  Widget _buildDeliveryStatus() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatusPoint(true, isActive: true),
              _buildStatusLine(true),
              _buildStatusPoint(true, isActive: true),
              _buildStatusLine(false),
              _buildStatusPoint(false, isActive: false),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Dijemput',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C63FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Dikirim',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C63FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Selesai',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPoint(bool isCompleted, {required bool isActive}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF6C63FF) : Colors.grey.shade300,
        border: Border.all(
          color: isActive ? const Color(0xFF6C63FF) : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: isCompleted
          ? const Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            )
          : null,
    );
  }

  Widget _buildStatusLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? const Color(0xFF6C63FF) : Colors.grey.shade300,
      ),
    );
  }


// CHAT PAGE
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: _messageController.text,
          isUser: true,
        ));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text('Chat dengan Kurir'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: const Color(0xFF6C63FF),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: isUser ? const Color(0xFF6C63FF) : Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}