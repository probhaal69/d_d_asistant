import 'package:d_d_asistant/screens/apis_screen/_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';


class PartidasJugador extends StatefulWidget {
  final dynamic tabla;

  const PartidasJugador({required this.tabla, Key? key}) : super(key: key);

  @override
  _PartidasJugadorState createState() => _PartidasJugadorState();
}

class _PartidasJugadorState extends State<PartidasJugador> {

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
        title: const Text("Partidas"),
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
              future: filtrarPartidaUser(idSesion!),
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
                                            switch (widget.tabla) {
                                              case 'abilityscores':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => AbilityDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'actions':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => ActionsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'alignments':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => AlignmentsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'backgrounds':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => BackgroundsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'bestiary':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => BestiaryDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'boons':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => BoonsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'class':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => ClasesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'conditionsdiseases':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => ConditionsDiseasesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'cults':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => CultsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'deities':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => DeitiesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'encounters':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => EncountersDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'feats':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => FeatsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'Items_base':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => ItemBaseDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'Items':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => ItemsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'languages':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => LanguagesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'magicvariants':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => MagicvariantsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'monsterfeatures':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => MonsterfeaturesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'names':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => NamesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'objects':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => ObjectsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'races':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => RacesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'senses':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => SensesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'skills':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => SkillsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'spells':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => SpellsDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'subclass':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => SubClassesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'subraces':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => SubRacesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              case 'tables':
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => TablesDnD(filtroPartida: registro['id'])
                                                  ),
                                                );
                                                break;
                                              default:
                                                return;
                                            }
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
