import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';



class SpellsId extends StatefulWidget {
  final int id;

  const SpellsId({required this.id, Key? key}) : super(key: key);

  @override
  _ActionIdState createState() => _ActionIdState();
}

class _ActionIdState extends State<SpellsId> {
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
        title: const Text("Detalles de hechizo")),
      body: FutureBuilder(
        future: conectarDnDid('spells', '${widget.id}'),
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
                  titulo: "Hechizo [${registro['id']}]",
                  lista: '${registro['name']}',
                ),
                CustomJsonContainer(
                  titulo: "Recurso",
                  lista: '${registro['source']}',
                ),
                CustomJsonContainer(
                  titulo: "Nivel",
                  lista: '${registro['level']}',
                ),
                CustomJsonContainer(
                  titulo: "Tiempo de lanzamiento",
                  lista: '${registro['casting_time']}',
                ),
                CustomJsonContainer(
                  titulo: "Duracion",
                  lista: '${registro['duration']}',
                ),
                CustomJsonContainer(
                  titulo: "Escuela",
                  lista: '${registro['school']}',
                ),
                CustomJsonContainer(
                  titulo: "Rango",
                  lista: '${registro['range']}',
                ),
                CustomJsonContainer(
                  titulo: "Componentes",
                  lista: '${registro['components']}',
                ),
                CustomJsonContainer(
                  titulo: "Clases",
                  lista: '${registro['classes']}',
                ),
                CustomJsonContainer(
                  titulo: "Variante de clase opcional",
                  lista: '${registro['optional_variant_classes']}',
                ),
                CustomJsonContainer(
                  titulo: "Entradas",
                  lista: '${registro['text']}',
                ),
                CustomJsonContainer(
                  titulo: "A niveles altos",
                  lista: '${registro['at_higher_levels']}',
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
                            int success = await insertContenidoUser('spells', idSesion!, widget.id);
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
                            int success = await removeContenidoUser('spells', idSesion!, widget.id);
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
                    ListView.builder(
                      itemCount: listCustomContainer.length,
                      itemBuilder: (BuildContext context, int i) {
                        return listCustomContainer[i];
                      },
                      shrinkWrap: true, // Esto es importante para usar ListView dentro de Column
                      physics: const NeverScrollableScrollPhysics(), // Esto es importante para evitar conflictos de desplazamiento
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