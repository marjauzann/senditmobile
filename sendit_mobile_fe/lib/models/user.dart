class User {
  final int id_user;
  final String nama;
  final String alamat;
  final String noHp;
  final String email;
  final String username; // Tambahkan username
  final String role;

  User({
    required this.id_user,
    required this.nama,
    required this.email,
    required this.alamat,
    required this.noHp,
    required this.username, // Tambahkan ini
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Print untuk debugging
    print('Parsing user data: $json');

    return User(
      id_user:
          json['id_user'] is String // Ubah dari id_user_user menjadi id_user
              ? int.tryParse(json['id_user']) ??
                  0 // Ubah dari id_user_user menjadi id_user
              : json['id_user'] ?? 0,
      nama: json['nama']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      alamat: json['alamat']?.toString() ?? '',
      noHp: json['no_hp']?.toString() ?? '',
      username: json['username']?.toString() ?? '', // Tambahkan username
      role: json['role']?.toString() ?? '',
    );
  }
}