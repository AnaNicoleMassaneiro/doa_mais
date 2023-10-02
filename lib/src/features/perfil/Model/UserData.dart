class UserData {
  final int id;
  final String name;
  final String cpf;
  final String email;
  final String password;

  UserData({
    required this.id,
    required this.name,
    required this.cpf,
    required this.email,
    required this.password,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      cpf: json['cpf'],
      email: json['email'],
      password: json['password'],
    );
  }
}
