import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';

class PartidasIdMaster extends StatefulWidget {
  final int id;
  final String tabla;

  const PartidasIdMaster({required this.id, required this.tabla, Key? key}) : super(key: key);

  @override
  _PartidasIdMasterState createState() => _PartidasIdMasterState();
}

class _PartidasIdMasterState extends State<PartidasIdMaster> {

  String _searchTerm = '';

  int? idSesion;    //! Variable para recoger el id del usuario

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserId();
    });
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
    return (idSesion == null)
    ? const CircularProgressIndicator()
    : Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _cerrarSesion,
            tooltip: 'Cerrar sesión',
          ),
        ],
        title: const Text("Gestionar partidas"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
              decoration: InputDecoration(
                labelText: contentBusqueda('Search'),
                hintText: contentBusqueda('Hint'),
                suffixIcon: contentBusqueda('Icon'),
              ),
            ),
          ),
          const Text('Tus partidas como master'),
          Expanded(
            child: FutureBuilder(
              future: conectarPartidaMasterId(idSesion),
              builder: (
                _,
                AsyncSnapshot<dynamic> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error'));
                  } else if (snapshot.hasData) {
                    List data = snapshot.data!;
                    List filteredData = data.where((element) {
                      return element['name']
                          .toString()
                          .toLowerCase()
                          .contains(_searchTerm.toLowerCase());
                    }).toList();

                    return AnimationLimiter(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              itemCount: filteredData.length,
                              itemBuilder: (BuildContext context, int i) {
                                Map registro = filteredData[i];
                                return AnimationConfiguration.staggeredList(
                                    position: i,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // PopUp para gestionar contenido en partida
                                                return AlertDialog(
                                                  title: const Text("Gestionar contenido en partida"),
                                                  content: const Text("Añade o elimina"),
                                                  actions: <Widget>[
                                                    // Botón 1
                                                    TextButton(
                                                      child: const Text("Añade"),
                                                      onPressed: () async {
                                                        int success = await insertContenidoPartida(widget.tabla, registro['id_partida'], widget.id);
                                                        Navigator.of(context).pop();
                                                        switch (success) {
                                                          case 200:
                                                          case 201:
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Contenido añadido a la partida')),
                                                            );
                                                            break;
                                                          case 409:
                                                          case 404:
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Este contenido ya estaba en la partida anteriormente')),
                                                            );
                                                            break;
                                                          case 500:
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Error al    guardar en la partida   ')),
                                                            );
                                                            break;
                                                          default:
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Error al    guardar en la partida   ')),
                                                            );
                                                        }
                                                      },
                                                    ),
                                                    // Botón 2
                                                    TextButton(
                                                      child: const Text("Eliminar"),
                                                      onPressed: () async {
                                                        int success = await removeContenidoPartida(widget.tabla, registro['id_partida'], widget.id);
                                                        Navigator.of(context).pop();
                                                        switch (success) {
                                                          case 200:
                                                          case 201:
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Contenido removido de la partida')),
                                                            );
                                                            break;
                                                          case 409:
                                                          case 404:
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Este contenido no estaba en la partida')),
                                                            );
                                                            break;
                                                          case 500:
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Error al    Quitar de la partida   ')),
                                                            );
                                                            break;
                                                          default:
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Error al    Quitar de la partida   ')),
                                                            );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: MostrarCampo(
                                            campo: '${registro['name']}',
                                          ),
                                        ),
                                      )
                                    )
                                );
                              },
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: Text('Empty data'));
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
