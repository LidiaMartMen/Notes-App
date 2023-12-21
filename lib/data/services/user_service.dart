import 'dart:convert';

import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _userListKey = 'user_list';

  ///*FUNCIÓN GUARDAR DATOS CON SHARED_PREFERENCES:
  static Future<void> saveUserList(List<User> userList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //EL mapa lo paso a una lista:
    final userListJson = userList.map((user) => user.toJson()).toList();
    //La lista la transformo a JSON:
    final userListJsonString = jsonEncode(userListJson);

    //Guardar en SharedPreferences:
    prefs.setString(_userListKey, userListJsonString);
  }

  ///*FUNCIÓN OBTENER LISTA USUARIOS DESDE SHARED_PREFERENCES:
  static Future<List<User>> getUsersList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Obtener la lista de usuarios del JSON:
    final userListJsonString = prefs.getString(_userListKey);

    //Comprobar si hay usuario:
    if (userListJsonString != null) {
      //Entonces decodifico el JSON:
      final userListJson = jsonDecode(userListJsonString) as List<dynamic>;
      //Devuelve un mapa con los datos:
      return userListJson.map((userMap) => User.fromJson(userMap)).toList();
    } else {
      return [];
    }
  }

  ///*FUNCIÓN GUARDAR USUARIO EN SHARED_PREFERENCES:
  static Future<void> addUser(User user) async {
    final List<User> userList = await getUsersList();
    //Añado al usuario:
    userList.add(user);
    //Guardo la lista:
    await saveUserList(userList);
  }
}
