class User {
  final String name;
  final String password;

//COnstructor: para crear instancias de la clase:
  User(this.name, this.password);

//COnvierte una instancia de User a un mapa para guardarlo a formato JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'password': password};
  }

//Toma un mapa y crea una instancia de User, para convertir los datos JSON a un User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'], json['password']);
  }
}
