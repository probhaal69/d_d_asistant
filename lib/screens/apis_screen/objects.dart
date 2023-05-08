import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/screens/apis_screen_id/_screens.dart';
import 'package:d_d_asistant/models/sesion.dart';



class ObjectsDnD extends StatefulWidget {
  const ObjectsDnD({Key? key}) : super(key: key);

  @override
  _ObjectsDnDState createState() => _ObjectsDnDState();
}

class _ObjectsDnDState extends State<ObjectsDnD> {
  String _searchTerm = '';

  bool _mostrarContenidoGlobal = true;
  dynamic _mostrarListado;
  String _botonFiltrarContenido = '';
  int? idSesion;    //! Variable para recoger el id del usuario

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }
  Future<void> _loadUserId() async {
    idSesion = await getUserId();
    if (mounted) {
      setState(() {
        // ignore: prefer_conditional_assignment
        if (_mostrarListado == null) {
          _mostrarListado = _mostrarContenidoGlobal
              ? conectarDnDapi('objects')
              : filtrarContenidoUser('objects', idSesion!);
        }
        _botonFiltrarContenido = _mostrarContenidoGlobal
          ? 'Contenido global'
          : 'Contenido personal';
      });
    }
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
        title: const Text("Otros objetos")),
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
              future: _mostrarListado,
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
                            ElevatedButton(
                              onPressed: () {
                              setState(() {
                                _mostrarContenidoGlobal = !_mostrarContenidoGlobal;
                                _mostrarListado = _mostrarContenidoGlobal
                                    ? conectarDnDapi('objects')
                                    : filtrarContenidoUser('objects', idSesion!);
                                _botonFiltrarContenido = _mostrarContenidoGlobal
                                    ? 'Contenido global'
                                    : 'Contenido personal';
                              });
                              },
                              child: Text(_botonFiltrarContenido),
                            ),
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
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => ObjectsId(id: registro['id'],)
                                              ),
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
