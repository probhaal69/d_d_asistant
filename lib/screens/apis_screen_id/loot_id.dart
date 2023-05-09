import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';



class LootId extends StatefulWidget {
  // final String campo;

  // const LootId({required this.campo, Key? key}) : super(key: key);
  const LootId({Key? key}) : super(key: key);

  @override
  _LootIdState createState() => _LootIdState();
}

class _LootIdState extends State<LootId> {
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
        title: const Text("Detalles de la recompensa")),
      body: FutureBuilder(
        // future: conectarDnDid('loot', widget.campo),
        future: conectarDnDapi('loot'),
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
                  titulo: "Individual",
                  lista: registro['individual'],
                ),
                CustomJsonContainer(
                  titulo: "Acaparar",
                  lista: registro['hoard'],
                ),
                CustomJsonContainer(
                  titulo: "Dragon",
                  lista: registro['dragon'],
                ),
                CustomJsonContainer(
                  titulo: "Gemas",
                  lista: registro['gems'],
                ),
                CustomJsonContainer(
                  titulo: "Objetos de arte",
                  lista: registro['artObjects'],
                ),
                CustomJsonContainer(
                  titulo: "Objetos magicos",
                  lista: registro['magicItems'],
                ),
                CustomJsonContainer(
                  titulo: "objeto mundano de dragon",
                  lista: registro['dragonMundaneItems'],
                ),
              ];

              return ListView.builder(
                itemCount: listCustomContainer.length,
                itemBuilder: (BuildContext context, int i) {
                  return listCustomContainer[i];
                },
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
