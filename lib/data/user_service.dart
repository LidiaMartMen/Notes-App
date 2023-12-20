import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _userKey = 'user';

  ///*FUNCIÓN GUARDAR DATOS CON SHARED_PREFERENCES:
  static Future<void> saveUserInfo(String name, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //Lo guardo con un JSON:
    final userMap = {'name': name, 'password': password};
    final userJson = jsonEncode(userMap);

    //Guardar en SharedPreferences:
    prefs.setString(_userKey, userJson);
  }

  ///*FUNCIÓN OBTENER DATOS DESDE SHARED_PREFERENCES:
  static Future<Map<String, String>?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //Obtener el usuario del JSON:
    final userJson = prefs.getString(_userKey);

    //Comprobar si hay usuario:
    if (userJson != null) {
      //Entonces decodifico el JSON:
      final userMap = jsonDecode(userJson);
      //Devuelve un mapa con los datos:
      return userMap.cast<String, String>();
    } else {
      return null;
    }
  }
}
