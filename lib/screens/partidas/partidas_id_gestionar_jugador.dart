import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';

class PartidasIdGestionarJugador extends StatefulWidget {
  final int idUser;
  final int idPartida;

  const PartidasIdGestionarJugador({required this.idUser, required this.idPartida, Key? key}) : super(key: key);

  @override
  _PartidasIdGestionarJugadorState createState() => _PartidasIdGestionarJugadorState();
}

class _PartidasIdGestionarJugadorState extends State<PartidasIdGestionarJugador> {
  int? idSesion;    //! Variable para recoger el id del usuario

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }
  Future<void> _loadUserId() async {
    idSesion = await getUserId();
    setState(() {});
  }
  void _cerrarSesion() async {
    await removeUserId();
    Navigator.of(context).pushReplacementNamed('/login');
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _cerrarSesion,
            tooltip: 'Cerrar sesión',
          ),
        ],
        title: const Text("Partida"),
        // leading: IconButton(
        //   icon: const Icon(Icons.home),
        //   onPressed: () {
        //     Navigator.pushNamed(context, 'home');
        //   },
        // ),
      ),
      body: FutureBuilder(
        future: conectarJugadorEnPartidaAtributos('${widget.idUser}', '${widget.idPartida}'),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            } else if (snapshot.hasData) {
              List<dynamic> data = snapshot.data!;
              if (data.isNotEmpty) {
              Map registro = data[0];
              List<Widget> listCustomContainer = [
                CustomJsonContainer(
                  titulo: "Nombre del jugador",
                  lista: '${registro['username']}',
                ),
                if (registro['master'] == 1)
                  const Text('Es master', style: TextStyle(color: Colors.red)),
                if (registro['master'] == 0)
                  const Text('No es master', style: TextStyle(color: Colors.green)),
                CustomJsonContainer(
                  titulo: "Email del jugador",
                  lista: registro['email'],
                ),
                CustomJsonContainer(
                  titulo: "Estado de la solicitud",
                  lista: registro['estado'],
                ),
              ];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: listCustomContainer.map((container) => container).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (registro['estado'] == 'rechazada') ...[
                          ElevatedButton(
                            onPressed: () async {
                              int success = await incorporarEnPartida(widget.idUser, widget.idPartida);
                              switch (success) {
                                case 200:
                                case 201:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Jugador incorporado a la partida')),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => PartidasIdGestionarJugador(idUser : widget.idUser, idPartida: widget.idPartida),
                                    ),
                                  );
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error al incorporar a la partida')),
                                  );
                              }
                            },
                            child: const Text('Incorporar a la partida'),
                          ),
                        ],
                        if (registro['estado'] == 'en partida') ...[
                          ElevatedButton(
                            onPressed: () async {
                              int success = await expulsarDePartida(widget.idUser, widget.idPartida);
                              switch (success) {
                                case 200:
                                case 201:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Jugador expulsado de la partida')),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => PartidasIdGestionarJugador(idUser : widget.idUser, idPartida: widget.idPartida),
                                    ),
                                  );
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error al expulsar jugador de la partida')),
                                  );
                              }
                            },
                            child: const Text('Expulsar de la partida'),
                          ),
                        ],
                        if (registro['estado'] == 'pendiente') ...[
                          ElevatedButton(
                            onPressed: () async {
                              int success = await incorporarEnPartida(widget.idUser, widget.idPartida);
                              switch (success) {
                                case 200:
                                case 201:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Jugador aceptado en la partida')),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => PartidasIdGestionarJugador(idUser : widget.idUser, idPartida: widget.idPartida),
                                    ),
                                  );
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error al aceptar la solicitud')),
                                  );
                              }
                            },
                            child: const Text('Aceptar solicitud'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              int success = await expulsarDePartida(widget.idUser, widget.idPartida);
                              switch (success) {
                                case 200:
                                case 201:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Solicitud enviada')),
                                  );
                                  // Navigator.pushReplacementNamed(context, 'partidas_id', arguments: widget.idUser);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => PartidasIdGestionarJugador(idUser : widget.idUser, idPartida: widget.idPartida),
                                    ),
                                  );
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error al solicitar unirte a partida')),
                                  );
                              }
                            },
                            child: const Text('Denegar solicitud'),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (registro['estado'] != 'pendiente' && registro['estado'] != 'rechazada') ...[
                          if (registro['master'] == 0) ...[
                            ElevatedButton(
                              onPressed: () async {
                                int success = await darMasterPartida(widget.idUser, widget.idPartida);
                                switch (success) {
                                  case 200:
                                  case 201:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('El jugador es master de la partida')),
                                    );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => PartidasIdGestionarJugador(idUser : widget.idUser, idPartida: widget.idPartida),
                                      ),
                                    );
                                    break;
                                  default:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Error al convertir en master')),
                                    );
                                }
                              },
                              child: const Text('Convertir en master'),
                            ),
                          ],
                          if (registro['master'] == 1) ...[
                            ElevatedButton(
                              onPressed: () async {
                                int success = await quitarMasterPartida(widget.idUser, widget.idPartida);
                                switch (success) {
                                  case 200:
                                  case 201:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('El jugador ya no es master de la partida')),
                                    );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => PartidasIdGestionarJugador(idUser : widget.idUser, idPartida: widget.idPartida),
                                      ),
                                    );
                                    break;
                                  default:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Error al quitar master de partida')),
                                    );
                                }
                              },
                              child: const Text('Quitar master'),
                            ),
                          ],
                        ],
                      ],
                    ),
                  ],
                ),
              );

              } else {
                return const Center(child: Text('Empty data'));
              }
            } else {
              return const Center(child: Text('Empty data'));
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}
