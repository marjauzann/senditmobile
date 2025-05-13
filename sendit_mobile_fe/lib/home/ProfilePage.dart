import 'dart:convert';
import 'dart:io'; // Add this import for File
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:sendit/auth/urlPort.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class ImageFromGalleryEx extends StatefulWidget {
  final ImageSource type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  late ImagePicker imagePicker;
  final ImageSource type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == ImageSource.camera
            ? 'Image from Camera'
            : 'Image from Gallery'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSource.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile? image = await imagePicker.pickImage(
                    source: source,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);
                setState(() {
                  if (image != null) {
                    _image = File(image.path);
                  }
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.red[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  Future<void> _editUserData() async {
    if (userData == null) return;

    final editedData = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        final nameController = TextEditingController(text: userData?['nama']);
        final phoneController = TextEditingController(text: userData?['no_hp']);
        final emailController = TextEditingController(text: userData?['email']);
        final addressController =
            TextEditingController(text: userData?['alamat']);

        return AlertDialog(
          title: const Text('Edit User Data'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'nama': nameController.text,
                  'no_hp': phoneController.text,
                  'email': emailController.text,
                  'alamat': addressController.text,
                });
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (editedData != null) {
      setState(() {
        userData = {
          ...userData!,
          ...editedData,
        };
      });

      final url = Uri.parse('${urlPort}api/user/1');
      try {
        final response = await http.put(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(userData),
        );

        if (response.statusCode == 200) {
          print('User data updated successfully');
        } else {
          throw Exception('Failed to update user data: ${response.statusCode}');
        }
      } catch (e) {
        print('Error updating user data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final url = Uri.parse('${urlPort}api/user/1');
    try {
      print('Fetching from URL: $url');
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          userData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error detail: $e');
      setState(() {
        isLoading = false;
      });
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
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              await _editUserData();
            },
          ),
        ],
      ),
      body: isLoading
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
                  child: Column(
                    children: [
                      _buildProfileHeader(),
                      const SizedBox(height: 20),
                      _buildInfoSection(),
                    ],
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
            userData?['role']?.toUpperCase() ?? 'USER',
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
          //profile picture
          child: ClipOval(
            child: Image.asset(
              'assets/darwin.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
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
          width: 45,
          height: 45,
          //camera button
          child: IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Color(0xFF6C63FF),
              size: 24,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Choose an option'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Gallery'),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImageFromGalleryEx(ImageSource.gallery),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_camera),
                          title: const Text('Camera'),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImageFromGalleryEx(ImageSource.camera),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
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

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }
}
