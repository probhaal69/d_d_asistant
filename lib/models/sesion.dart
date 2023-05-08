import 'package:shared_preferences/shared_preferences.dart';

//! Para guardar id usuario en la sesion
Future<void> saveUserId(int userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', userId);
}

//! Para recoger id usuario de la sesion
Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}

//! Para cerrar sesion
Future<void> removeUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
}
