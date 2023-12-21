class User {
  final String name;
  final String password;

  User(this.name, this.password);

  Map<String, dynamic> toJson() {
    return {'name': name, 'password': password};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'], json['password']);
  }
}
