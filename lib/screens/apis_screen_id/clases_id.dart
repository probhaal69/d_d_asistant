import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';



class ClasesId extends StatefulWidget {
  final int id;

  const ClasesId({required this.id, Key? key}) : super(key: key);

  @override
  _ClasesIdState createState() => _ClasesIdState();
}

class _ClasesIdState extends State<ClasesId> {
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
        title: const Text("Detalles de clase")),
      body: FutureBuilder(
        future: conectarDnDid('class', '${widget.id}'),
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
                  titulo: "Clase [${registro['id']}]",
                  lista: '${registro['name']}',
                ),
                CustomJsonContainer(
                  titulo: "Recurso",
                  lista: '${registro['source']}',
                ),
                CustomJsonContainer(
                  titulo: "Requisitos",
                  lista: registro['requirements'],
                ),
                CustomJsonContainer(
                  titulo: "Dado de vida",
                  lista: registro['hd'],
                ),
                CustomJsonContainer(
                  titulo: "Competencia",
                  lista: registro['proficiency'],
                ),
                CustomJsonContainer(
                  titulo: "Caracteristica de hechizos",
                  lista: '${registro['spellcastingAbility']}',
                ),
                CustomJsonContainer(
                  titulo: "Progreso de lanzamientos",
                  lista: '${registro['casterProgression']}',
                ),
                CustomJsonContainer(
                  titulo: "Progresion de trucos",
                  lista: registro['cantripProgression'],
                ),
                CustomJsonContainer(
                  titulo: "Progresion de hechizos conocidos",
                  lista: registro['spellsKnownProgression'],
                ),
                CustomJsonContainer(
                  titulo: "Progresion de hechizos conocidos por nivel (brujo)",
                  lista: registro['spellsKnownProgressionFixedByLevel'],
                ),
                CustomJsonContainer(
                  titulo: "Progresion de hechizos de mago por nivel",
                  lista: registro['spellsKnownProgressionFixedAllowLowerLevel'],
                ),
                CustomJsonContainer(
                  titulo: "Hechizos preparados",
                  lista: '${registro['preparedSpells']}',
                ),
                CustomJsonContainer(
                  titulo: "Hechizos adicionales",
                  lista: registro['additionalSpells'],
                ),
                CustomJsonContainer(
                  titulo: "Progreso de caracteristica opcional",
                  lista: registro['optionalfeatureProgression'],
                ),
                CustomJsonContainer(
                  titulo: "Competencias iniciales",
                  lista: registro['startingProficiencies'],
                ),
                CustomJsonContainer(
                  titulo: "Equipamiento inicial",
                  lista: registro['startingEquipment'],
                ),
                CustomJsonContainer(
                  titulo: "Multiclase",
                  lista: registro['multiclassing'],
                ),
                CustomJsonContainer(
                  titulo: "Tablas de clase",
                  lista: registro['classTableGroups'],
                ),
                CustomJsonContainer(
                  titulo: "Caracteristicas de clase",
                  lista: registro['classFeatures'],
                ),
                CustomJsonContainer(
                  titulo: "Titulo subclase",
                  lista: '${registro['subclassTitle']}',
                ),
                CustomJsonContainer(
                  titulo: "Registros relacionados",
                  lista: registro['fluff'],
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
                            int success = await insertContenidoUser('class', idSesion!, widget.id);
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
                            int success = await removeContenidoUser('class', idSesion!, widget.id);
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
