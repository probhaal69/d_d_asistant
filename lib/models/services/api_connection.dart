import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:d_d_asistant/models/sesion.dart';
String apiUrl = dotenv.env['RUTA_API']!;
String apiPort = dotenv.env['PORT_API']!;

Future<dynamic> conectarDnDapi(String url) async {
  final response =
    await http.get(Uri.parse("$apiUrl:$apiPort/$url"));
  switch (response.statusCode) {
    case 200:
      final parsed = json.decode(response.body);
      return parsed;
    default:
      throw Exception("Falló la carga");
  }
}

Future<dynamic> conectarDnDid(String url, String id) async {
  final response =
    await http.get(Uri.parse("$apiUrl:$apiPort/$url/$id"));
  switch (response.statusCode) {
    case 200:
      final parsed = json.decode(response.body);
      return parsed;
    default:
      throw Exception("Falló la carga");
  }
}

Future<dynamic> registrarUsuario(String username, String email, String pass) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/register"),
      body: {
        'username': username,
        'pass': pass,
        'email': email,
      },
    );
  switch (response.statusCode) {
    case 200:
      return 201;
    case 409:
      return 409;
    case 500:
      return 500;
    default:
      throw Exception("Falló la carga");
  }
}
Future<dynamic> iniciarSession(String email, String pass) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/login"),
      body: {
        'email': email,
        'pass': pass,
      },
    );
  switch (response.statusCode) {
    case 200:
      final parsed = json.decode(response.body);
      saveUserId(parsed['id']);
      return 200;
    case 404:
      return 404;
    case 500:
      return 500;
    default:
      throw Exception("Falló la carga");
  }
}

Future<dynamic> insertContenidoUser(dynamic tabla, dynamic idSesion, dynamic idContenido) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/usuarioRegistraContenido"),
      body: {
        'idSesion': idSesion.toString(),
        'idContenido': idContenido.toString(),
        'tabla': tabla.toString(),
      },
    );
  switch (response.statusCode) {
    case 200:
      return 201;
    case 409:
      return 409;
    case 500:
      return 500;
    default:
      throw Exception("Falló la carga");
  }
}
Future<dynamic> filtrarContenidoUser(dynamic tabla, dynamic idSesion) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/usuarioFiltraContenido"),
      body: {
        'idSesion': idSesion.toString(),
        'tabla': tabla.toString(),
      },
    );
  switch (response.statusCode) {
    case 200:
      final parsed = json.decode(response.body);
      return parsed;
    default:
      throw Exception("Falló la carga");
  }
}
Future<dynamic> removeContenidoUser(dynamic tabla, dynamic idSesion, dynamic idContenido) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/usuarioRemueveContenido"),
      body: {
        'idSesion': idSesion.toString(),
        'idContenido': idContenido.toString(),
        'tabla': tabla.toString(),
      },
    );
  switch (response.statusCode) {
    case 200:
    case 201:
      return 200;
    case 409:
    case 404:
      return 404;
    case 500:
      return 500;
    default:
      throw Exception("Falló la carga");
  }
}