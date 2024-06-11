class User {
  final int id;
  final String fullname;
  final String token;


  User({required this.id, required this.fullname, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    print(json['fullname']);
    return User(
      id: json['id'],
      fullname: json['full_name'],
      token: json['token'],
    );
  }
}