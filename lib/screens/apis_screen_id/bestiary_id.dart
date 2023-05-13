import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';
import 'package:d_d_asistant/screens/partidas/partidas_id_master.dart';



class BestiaryId extends StatefulWidget {
  final int id;

  const BestiaryId({required this.id, Key? key}) : super(key: key);

  @override
  _BestiaryIdState createState() => _BestiaryIdState();
}

class _BestiaryIdState extends State<BestiaryId> {
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
        title: const Text("Detalles de la criatura")),
      body: FutureBuilder(
        future: conectarDnDid('bestiary', '${widget.id}'),
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
                  titulo: "Criatura [${registro['id']}]",
                  lista: '${registro['name']}',
                ),
                CustomJsonContainer(
                  titulo: "Recurso",
                  lista: '${registro['source']}',
                ),
                CustomJsonContainer(
                  titulo: "Tamaño",
                  lista: '${registro['size']}',
                ),
                CustomJsonContainer(
                  titulo: "Tipo",
                  lista: '${registro['type']}',
                ),
                CustomJsonContainer(
                  titulo: "Alineamiento",
                  lista: '${registro['alignment']}',
                ),
                CustomJsonContainer(
                  titulo: "Aarmor Class",
                  lista: '${registro['AC']}',
                ),
                CustomJsonContainer(
                  titulo: "Hit Points",
                  lista: '${registro['HP']}',
                ),
                CustomJsonContainer(
                  titulo: "Velocidad",
                  lista: '${registro['Speed']}',
                ),
                CustomJsonContainer(
                  titulo: "Fuerza",
                  lista: '${registro['Strength']}',
                ),
                CustomJsonContainer(
                  titulo: "Destreza",
                  lista: '${registro['dexterity']}',
                ),
                CustomJsonContainer(
                  titulo: "Constitucion",
                  lista: '${registro['constitution']}',
                ),
                CustomJsonContainer(
                  titulo: "Inteligencia",
                  lista: '${registro['intelligence']}',
                ),
                CustomJsonContainer(
                  titulo: "Sabiduria",
                  lista: '${registro['wisdom']}',
                ),
                CustomJsonContainer(
                  titulo: "Carisma",
                  lista: '${registro['charisma']}',
                ),
                CustomJsonContainer(
                  titulo: "Tiradas de salvacion",
                  lista: '${registro['saving_throws']}',
                ),
                CustomJsonContainer(
                  titulo: "Habilidades",
                  lista: '${registro['skills']}',
                ),
                CustomJsonContainer(
                  titulo: "Vulnerabilidades",
                  lista: '${registro['damage_vulnerabilities']}',
                ),
                CustomJsonContainer(
                  titulo: "Resistencias",
                  lista: '${registro['damage_resistances']}',
                ),
                CustomJsonContainer(
                  titulo: "Inmunidad a daños",
                  lista: '${registro['damage_immunities']}',
                ),
                CustomJsonContainer(
                  titulo: "Inmunidad a condiciones",
                  lista: '${registro['condition_immunities']}',
                ),
                CustomJsonContainer(
                  titulo: "Sentidos",
                  lista: '${registro['senses']}',
                ),
                CustomJsonContainer(
                  titulo: "Idiomas",
                  lista: '${registro['languages']}',
                ),
                CustomJsonContainer(
                  titulo: "CR",
                  lista: '${registro['CR']}',
                ),
                CustomJsonContainer(
                  titulo: "Rasgos",
                  lista: '${registro['Traits']}',
                ),
                CustomJsonContainer(
                  titulo: "Acciones",
                  lista: '${registro['Actions']}',
                ),
                CustomJsonContainer(
                  titulo: "Accion bonus",
                  lista: '${registro['bonus_actions']}',
                ),
                CustomJsonContainer(
                  titulo: "Reaccion",
                  lista: '${registro['reactions']}',
                ),
                CustomJsonContainer(
                  titulo: "Accion legendaria",
                  lista: '${registro['legendary_actions']}',
                ),
                CustomJsonContainer(
                  titulo: "Accion mitica",
                  lista: '${registro['mythic_actions']}',
                ),
                CustomJsonContainer(
                  titulo: "Accion de entorno",
                  lista: '${registro['lair_actions']}',
                ),
                CustomJsonContainer(
                  titulo: "Accion regional",
                  lista: '${registro['regional_effects']}',
                ),
                CustomJsonContainer(
                  titulo: "Entorno",
                  lista: '${registro['environment']}',
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
                            int success = await insertContenidoUser('bestiary', idSesion!, widget.id);
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
                            int success = await removeContenidoUser('bestiary', idSesion!, widget.id);
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
                                builder: (BuildContext context) => PartidasIdMaster(id: widget.id, tabla: 'bestiary'),
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
