import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/screens/apis_screen_id/_screens.dart';
import 'package:d_d_asistant/models/sesion.dart';



class LootDnD extends StatefulWidget {
  const LootDnD({Key? key}) : super(key: key);

  @override
  _LootDnDState createState() => _LootDnDState();
}

class _LootDnDState extends State<LootDnD> {
  String _searchTerm = '';
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
        title: const Text("Recompensas"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
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
          Expanded(
            child: FutureBuilder(
              future: conectarDnDapi('loot'),
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
                      // return element['name']
                      return element['individual'][0]['name']
                          .toString()
                          .toLowerCase()
                          .contains(_searchTerm.toLowerCase());
                    }).toList();

                    return AnimationLimiter(
                      child: ListView.builder(
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
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => const LootId(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        MostrarCampo(
                                        campo: '${registro['individual'][0]['name']}',
                                        ),
                                        // MostrarCampo(
                                        // campo: '${registro['hoard'][0]['name']}',
                                        // ),
                                        // MostrarCampo(
                                        // campo: '${registro['dragon'][0]['name']}',
                                        // ),
                                        // MostrarCampo(
                                        // campo: '${registro['gems'][0]['name']}',
                                        // ),
                                        // MostrarCampo(
                                        // campo: '${registro['artObjects'][0]['name']}',
                                        // ),
                                        // MostrarCampo(
                                        // campo: '${registro['magicItems'][0]['name']}',
                                        // ),
                                        // MostrarCampo(
                                        // campo: '${registro['dragonMundaneItems'][0]['name']}',
                                        // ),
                                      ]
                                    )
                                  ),
                                )
                              )
                          );
                        },
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
