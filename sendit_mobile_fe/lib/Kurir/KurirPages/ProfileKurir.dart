import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sendit/auth/urlPort.dart';
class ProfileKurir extends StatefulWidget {
  const ProfileKurir({super.key});

  @override
  _ProfileKurirState createState() => _ProfileKurirState();
}

class _ProfileKurirState extends State<ProfileKurir> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

Future<void> fetchUserData() async {
    final url = Uri.parse('${urlPort}api/user/3');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Tambahkan logging untuk debug
      print('Status Code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        print('Decoded data: $decodedData');
        
        setState(() {
          // Jika response berupa array, ambil data pertama
          userData = decodedData is List ? decodedData[0] : decodedData;
          isLoading = false;
        });
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else {
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error detail: $e');
      setState(() {
        isLoading = false;
        userData = null;
      });

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to load user data: $e\n\nPlease check your API connection and try again.'),
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
  }

  // Fungsi untuk handle edit profile
  void _handleEditProfile() {
    // Implementasi edit profile
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Text('Feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      // Format tanggal dengan leading zero
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            const Text(
              'Profile Kurir',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: _handleEditProfile,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchUserData,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                ),
              )
            : userData == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 60,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load user data',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: fetchUserData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        _buildProfileHeader(),
                        const SizedBox(height: 20),
                        _buildInfoSection(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildProfileImage(),
          const SizedBox(height: 16),
          Text(
            userData?['nama'] ?? 'N/A',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            userData?['role']?.toUpperCase() ?? 'KURIR',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/darwin.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt,
            color: Color(0xFF6C63FF),
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildInfoCard(
            'Personal Information',
            Icons.person_outline,
            [
              _buildInfoRow('Name', userData?['nama'] ?? 'N/A'),
              _buildInfoRow('Phone', userData?['no_hp'] ?? 'N/A'),
              _buildInfoRow('Email', userData?['email'] ?? 'N/A'),
              _buildInfoRow('Address', userData?['alamat'] ?? 'N/A'),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            'Account Information',
            Icons.security,
            [
              _buildInfoRow('Username', userData?['username'] ?? 'N/A'),
              _buildInfoRow('Role', (userData?['role'] ?? 'N/A').toUpperCase()),
              _buildInfoRow(
                  'Member Since', _formatDate(userData?['created_at'] ?? '')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xFF6C63FF),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2A2A2A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
