import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';
import 'package:d_d_asistant/screens/partidas/partidas_id_master.dart';



class SubRacesId extends StatefulWidget {
  final int id;

  const SubRacesId({required this.id, Key? key}) : super(key: key);

  @override
  _SubRacesIdState createState() => _SubRacesIdState();
}

class _SubRacesIdState extends State<SubRacesId> {
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
        title: const Text("Detalles de subraza")),
      body: FutureBuilder(
        future: conectarDnDid('subraces', '${widget.id}'),
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
                  titulo: "Raza [${registro['id']}]",
                  lista: '${registro['name']}',
                ),
                CustomJsonContainer(
                  titulo: "Recurso",
                  lista: '${registro['source']}',
                ),
                CustomJsonContainer(
                  titulo: "Nombre de raza",
                  lista: '${registro['raceName']}',
                ),
                CustomJsonContainer(
                  titulo: "Recurso de raza",
                  lista: '${registro['raceSource']}',
                ),
                CustomJsonContainer(
                  titulo: "Habilidad",
                  lista: registro['ability'],
                ),
                CustomJsonContainer(
                  titulo: "Entradas",
                  lista: registro['entries'],
                ),
                CustomJsonContainer(
                  titulo: "Competencia de habilidades",
                  lista: registro['skilProficiencies'],
                ),
                CustomJsonContainer(
                  titulo: "Versiones",
                  lista: registro['_versions'],
                ),
                CustomJsonContainer(
                  titulo: "Vision nocturna",
                  lista: '${registro['darkvision']}',
                ),
                CustomJsonContainer(
                  titulo: "Resistencias",
                  lista: registro['resist'],
                ),
                CustomJsonContainer(
                  titulo: "traitTags",
                  lista: registro['traitTags'],
                ),
                CustomJsonContainer(
                  titulo: "Competencia de idiomas",
                  lista: registro['languageProficiencies'],
                ),
                CustomJsonContainer(
                  titulo: "Hechizos adicionales",
                  lista: registro['additionalSpells'],
                ),
                CustomJsonContainer(
                  titulo: "Alto y ancho",
                  lista: registro['heightAndWeight'],
                ),
                CustomJsonContainer(
                  titulo: "Competencia de armaduras",
                  lista: registro['armorProficiencies'],
                ),
                CustomJsonContainer(
                  titulo: "Velocidad",
                  lista: registro['speed'],
                ),
                CustomJsonContainer(
                  titulo: "Competencia de armas",
                  lista: registro['weaponProficiencies'],
                ),
                CustomJsonContainer(
                  titulo: "Competencias varias",
                  lista: registro['skillToolLanguageProficiencies'],
                ),
                CustomJsonContainer(
                  titulo: "Edad",
                  lista: registro['age'],
                ),
                CustomJsonContainer(
                  titulo: "Competencia de herramientas",
                  lista: registro['toolProficiencies'],
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
                            int success = await insertContenidoUser('subraces', idSesion!, widget.id);
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
                            int success = await removeContenidoUser('subraces', idSesion!, widget.id);
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
                                builder: (BuildContext context) => PartidasIdMaster(id: widget.id, tabla: 'subraces'),
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
