class UserModal {
  String id;
  String name;
  String email;
  String password;

  UserModal({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserModal.fromMap({required Map data}) {
    return UserModal(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
