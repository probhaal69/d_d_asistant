import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';
import 'package:d_d_asistant/screens/partidas/partidas_id_master.dart';



class SubClassesId extends StatefulWidget {
  final int id;

  const SubClassesId({required this.id, Key? key}) : super(key: key);

  @override
  _SubClassesIdState createState() => _SubClassesIdState();
}

class _SubClassesIdState extends State<SubClassesId> {
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
        title: const Text("Detalles de subclase")),
      body: FutureBuilder(
        future: conectarDnDid('subclass', '${widget.id}'),
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
                  titulo: "Subclase [${registro['id']}]",
                  lista: '${registro['name']}',
                ),
                CustomJsonContainer(
                  titulo: "Nombre corto",
                  lista: '${registro['shortName']}',
                ),
                CustomJsonContainer(
                  titulo: "Recurso",
                  lista: '${registro['source']}',
                ),
                CustomJsonContainer(
                  titulo: "Nombre de clase",
                  lista: '${registro['className']}',
                ),
                CustomJsonContainer(
                  titulo: "Recurso de clase",
                  lista: '${registro['classSource']}',
                ),
                CustomJsonContainer(
                  titulo: "Caraceristic opcionales de progresion",
                  lista: registro['optionalfeatureProgression'],
                ),
                CustomJsonContainer(
                  titulo: "Caracteristicas de subclase",
                  lista: registro['subclassFeatures'],
                ),
                CustomJsonContainer(
                  titulo: "Hechizos adicionales",
                  lista: registro['additionalSpells'],
                ),
                CustomJsonContainer(
                  titulo: "Habilidad de lanzamiento de hechizos",
                  lista: '${registro['spellcastingAbility']}',
                ),
                CustomJsonContainer(
                  titulo: "RProgresion de lanzador",
                  lista: '${registro['casterProgression']}',
                ),
                CustomJsonContainer(
                  titulo: "Progresion de trucos",
                  lista: registro['cantripProgression'],
                ),
                CustomJsonContainer(
                  titulo: "Progresion de hechizos",
                  lista: registro['spellsKnownProgression'],
                ),
                CustomJsonContainer(
                  titulo: "Tablas de subclase",
                  lista: registro['subclassTableGroups'],
                ),
              ];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            int success = await insertContenidoUser('subclass', idSesion!, widget.id);
                            switch (success) {
                              case 200:
                              case 201:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Contenido añadida a tu lista')),
                                );
                                break;
                              case 409:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('El contenido ya estaba en la lista anteriormente')),
                                );
                                break;
                              case 500:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error al Guardar en lista')),
                                );
                                break;
                              default:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error al Guardar en lista')),
                                );
                            }
                          },
                          child: const Text('Guardar en lista'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () async {
                            int success = await removeContenidoUser('subclass', idSesion!, widget.id);
                            switch (success) {
                              case 200:
                              case 201:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Contenido removido de tu lista')),
                                );
                                break;
                              case 409:
                              case 404:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Este contenido no estaba en tu lista')),
                                );
                                break;
                              case 500:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error al    Quitar de lista   ')),
                                );
                                break;
                              default:
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error al    Quitar de lista   ')),
                                );
                            }
                          },
                          child: const Text('   Quitar de lista   '),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => PartidasIdMaster(id: widget.id, tabla: 'subclass'),
                              ),
                            );
                          },
                          child: const Text('Gestionar lista partida'),
                        ),
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
