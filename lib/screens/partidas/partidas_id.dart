import 'package:d_d_asistant/screens/partidas/partidas.dart';
import 'package:d_d_asistant/screens/partidas/partidas_id_gestionar.dart';
import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';

class PartidasId extends StatefulWidget {
  final int id;

  const PartidasId({required this.id, Key? key}) : super(key: key);

  @override
  _PartidasIdState createState() => _PartidasIdState();
}

class _PartidasIdState extends State<PartidasId> {
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
        future: conectarPartidaUserId('${widget.id}', '${idSesion}'),
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
              List<CustomJsonContainer> listCustomContainer = [
                CustomJsonContainer(
                  titulo: "Nombre partida",
                  lista: '${registro['name']}',
                ),
                CustomJsonContainer(
                  titulo: "Historia",
                  lista: registro['historia'],
                ),
              ];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    if (registro['master'] == 1 && registro['creador'] == 0 && registro['estado'] == 'en partida') ...[
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('Master de partida'),
                        ],
                      ),
                    ],
                    if (registro['creador'] == 1) ...[
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dueño de partida'),
                        ],
                      ),
                    ],
                    if (registro['master'] == 0 && registro['creador'] == 0 && registro['estado'] == 'en partida') ...[
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('en partida'),
                        ],
                      ),
                    ],
                    if (registro['estado'] == 'rechazada' || registro['estado'] == 'pendiente') ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('estado solicitud: '),
                          Text('${registro['estado']}'),
                        ],
                      ),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (registro['creador'] == 1) ...[
                          ElevatedButton(
                            onPressed: () async {
                              int success = await eliminarPartida(widget.id);
                              switch (success) {
                                case 200:
                                case 201:
                                Navigator.of(context).pushNamedAndRemoveUntil('/partidas', ModalRoute.withName('/home'));
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error al eliminar la partida')),
                                  );
                              }
                            },
                            child: const Text('Eliminar partida'),
                          ),
                        ],
                        if (registro['estado'] == 'en partida' && registro['creador'] == 0) ...[
                          ElevatedButton(
                            onPressed: () async {
                              int success = await salirDePartida(idSesion!, widget.id);
                              switch (success) {
                                case 200:
                                case 201:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Bye bye')),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => const Partidas(),
                                    ),
                                  );
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error al salir de la partida')),
                                  );
                              }
                            },
                            child: const Text('Salir de la partida'),
                          ),
                        ],
                        if (registro['estado'] == null) ...[
                          ElevatedButton(
                            onPressed: () async {
                              int success = await solicitarUnirsePartida(idSesion!, widget.id);
                              switch (success) {
                                case 200:
                                case 201:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Solicitud enviada')),
                                  );
                                  // Navigator.pushReplacementNamed(context, 'partidas_id', arguments: widget.id);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => PartidasId(id : widget.id),
                                    ),
                                  );
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error al solicitar unirte a partida')),
                                  );
                              }
                            },
                            child: const Text('Solicitar unirse'),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (registro['creador'] == 1) ...[
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => PartidasIdGestionar(id: widget.id),
                                ),
                              );
                            },
                            child: const Text('Gestionar'),
                          ),
                        ],
                      ],
                    ),
                    Column(
                      children: listCustomContainer.map((container) => container).toList(),
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
