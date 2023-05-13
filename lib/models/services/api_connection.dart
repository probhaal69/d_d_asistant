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
Future<dynamic> crearPartida(String nombrePartida, String historia) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/crearPartida"),
      body: {
        'nombrePartida': nombrePartida,
        'historia': historia,
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
Future<dynamic> crearRelasionPartidaUsuario(String nombrePartida, dynamic idUser) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/crearRelasionPartidaUsuario"),
      body: {
        'nombrePartida': nombrePartida,
        'idUser': idUser.toString(),
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
Future<dynamic> insertContenidoPartida(dynamic tabla, dynamic idPartida, dynamic idContenido) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/partidaRegistraContenido"),
      body: {
        'idPartida': idPartida.toString(),
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
Future<dynamic> removeContenidoPartida(dynamic tabla, dynamic idPartida, dynamic idContenido) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/partidaRemueveContenido"),
      body: {
        'idPartida': idPartida.toString(),
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
Future<dynamic> conectarPartida() async {
  final response =
    await http.get(Uri.parse("$apiUrl:$apiPort/partidas"));
  switch (response.statusCode) {
    case 200:
      final parsed = json.decode(response.body);
      return parsed;
    default:
      throw Exception("Falló la carga");
  }
}
Future<dynamic> filtrarPartidaUser(dynamic idSesion) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/usuarioFiltraPartida"),
      body: {
        'idSesion': idSesion.toString(),
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
Future<dynamic> conectarPartidaUserId(String idPartida, String idUsuario) async {
  final response =
    await http.post(Uri.parse("$apiUrl:$apiPort/partidasAtributosUser"),
      body: {
        'idUsuario': idUsuario.toString(),
        'idPartida': idPartida.toString(),
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
Future<dynamic> conectarPartidaMasterId(dynamic idUsuario) async {
  final response =
    await http.post(Uri.parse("$apiUrl:$apiPort/partidasAtributosMaster"),
      body: {
        'idUsuario': idUsuario.toString(),
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
Future<dynamic> eliminarPartida(dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/eliminarPartida"),
      body: {
        'idPartida': idPartida.toString(),
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
Future<dynamic> salirDePartida(dynamic idUsuario, dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/salirDePartida"),
      body: {
        'idUsuario': idUsuario.toString(),
        'idPartida': idPartida.toString(),
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
Future<dynamic> solicitarUnirsePartida(dynamic idUsuario, dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/solicitarUnirsePartida"),
      body: {
        'idUsuario': idUsuario.toString(),
        'idPartida': idPartida.toString(),
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
Future<dynamic> partidaListaUser(dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/partidaListaUser"),
      body: {
        'idPartida': idPartida.toString(),
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
Future<dynamic> conectarJugadorEnPartidaAtributos(dynamic idUser, dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/JugadorEnPartidaAtributo"),
      body: {
        'idUser': idUser.toString(),
        'idPartida': idPartida.toString(),
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
Future<dynamic> incorporarEnPartida(dynamic idUser, dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/incorporarEnPartida"),
      body: {
        'idUser': idUser.toString(),
        'idPartida': idPartida.toString(),
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
Future<dynamic> expulsarDePartida(dynamic idUser, dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/expulsarDePartida"),
      body: {
        'idUser': idUser.toString(),
        'idPartida': idPartida.toString(),
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
Future<dynamic> darMasterPartida(dynamic idUser, dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/darMasterPartida"),
      body: {
        'idUser': idUser.toString(),
        'idPartida': idPartida.toString(),
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
Future<dynamic> quitarMasterPartida(dynamic idUser, dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/quitarMasterPartida"),
      body: {
        'idUser': idUser.toString(),
        'idPartida': idPartida.toString(),
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
Future<dynamic> filtrarContenidoPartida(dynamic tabla, dynamic idPartida) async {
  final response =
    await http.post(
      Uri.parse("$apiUrl:$apiPort/filtrarContenidoPartida"),
      body: {
        'tabla': tabla.toString(),
        'idPartida': idPartida.toString(),
      },
    );
  switch (response.statusCode) {
    case 200:
      final parsed = json.decode(response.body);
      return parsed;
    case 409:
      return 409;
    case 500:
      return 500;
    default:
      throw Exception("Falló la carga");
  }
}