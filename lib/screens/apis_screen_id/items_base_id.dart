import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';



class ItemBaseId extends StatefulWidget {
  final int id;

  const ItemBaseId({required this.id, Key? key}) : super(key: key);

  @override
  _ItemBaseIdState createState() => _ItemBaseIdState();
}

class _ItemBaseIdState extends State<ItemBaseId> {
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
        title: const Text("Detalles de objeto base")),
      body: FutureBuilder(
        future: conectarDnDid('Items_base', '${widget.id}'),
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
                  titulo: "Objeto [${registro['id']}]",
                  lista: '${registro['name']}',
                ),
                CustomJsonContainer(
                  titulo: "Recurso",
                  lista: '${registro['source']}',
                ),
                CustomJsonContainer(
                  titulo: "Rareza",
                  lista: '${registro['rarity']}',
                ),
                CustomJsonContainer(
                  titulo: "Peso",
                  lista: '${registro['weight']}',
                ),
                CustomJsonContainer(
                  titulo: "Categoria de arma",
                  lista: '${registro['weaponCategory']}',
                ),
                CustomJsonContainer(
                  titulo: "Antiguedad",
                  lista: '${registro['age']}',
                ),
                CustomJsonContainer(
                  titulo: "Rango effectivo",
                  lista: '${registro['effective_range']}',
                ),
                CustomJsonContainer(
                  titulo: "Recarga",
                  lista: '${registro['reload']}',
                ),
                CustomJsonContainer(
                  titulo: "Daño 1",
                  lista: '${registro['dmg1']}',
                ),
                CustomJsonContainer(
                  titulo: "Arma de fuego",
                  lista: '${registro['firearm']}',
                ),
                CustomJsonContainer(
                  titulo: "Arma",
                  lista: '${registro['weapon']}',
                ),
                CustomJsonContainer(
                  titulo: "Tipo de municion",
                  lista: '${registro['ammoType']}',
                ),
                CustomJsonContainer(
                  titulo: "Valor",
                  lista: '${registro['value']}',
                ),
                CustomJsonContainer(
                  titulo: "Daño 2",
                  lista: '${registro['dmg2']}',
                ),
                CustomJsonContainer(
                  titulo: "Hacha",
                  lista: '${registro['axe']}',
                ),
                CustomJsonContainer(
                  titulo: "Clase de armadura",
                  lista: '${registro['ac']}',
                ),
                CustomJsonContainer(
                  titulo: "Armadura",
                  lista: '${registro['armor']}',
                ),
                CustomJsonContainer(
                  titulo: "Entradas",
                  lista: registro['entries'],
                ),
                CustomJsonContainer(
                  titulo: "Fuerza",
                  lista: '${registro['strength']}',
                ),
                CustomJsonContainer(
                  titulo: "Vida",
                  lista: '${registro['stealth']}',
                ),
                CustomJsonContainer(
                  titulo: "Porra",
                  lista: '${registro['club']}',
                ),
                CustomJsonContainer(
                  titulo: "Daga",
                  lista: '${registro['dagger']}',
                ),
                CustomJsonContainer(
                  titulo: "Espada",
                  lista: '${registro['sword']}',
                ),
                CustomJsonContainer(
                  titulo: "Ballesta",
                  lista: '${registro['crossbow']}',
                ),
                CustomJsonContainer(
                  titulo: "Lanza",
                  lista: '${registro['spear']}',
                ),
                CustomJsonContainer(
                  titulo: "Martillo",
                  lista: '${registro['hammer']}',
                ),
                CustomJsonContainer(
                  titulo: "Arco",
                  lista: '${registro['bow']}',
                ),
                CustomJsonContainer(
                  titulo: "Mazo",
                  lista: '${registro['mace']}',
                ),
                CustomJsonContainer(
                  titulo: "Red",
                  lista: '${registro['net']}',
                ),
                CustomJsonContainer(
                  titulo: "Cetro",
                  lista: '${registro['staff']}',
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
                            int success = await insertContenidoUser('Items_base', idSesion!, widget.id);
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
                            int success = await removeContenidoUser('Items_base', idSesion!, widget.id);
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
