import 'package:d_d_asistant/screens/partidas/partidas.dart';
import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/models/sesion.dart';
import '../../models/validar.dart';


class PartidasCrear extends StatefulWidget {
  const PartidasCrear({Key? key}) : super(key: key);

  @override
  _PartidasCrearState createState() => _PartidasCrearState();
}

class _PartidasCrearState extends State<PartidasCrear> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _historiaController = TextEditingController();

  Future<void> _crearPartida() async {
    if (!isFormularioCompleto(_nameController.text, _historiaController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Faltan datos')),
      );
      return;
    }
    final respuesta = await crearPartida(_nameController.text, _historiaController.text);
    switch (respuesta) {
      case 200:
      case 201:
        await crearRelasionPartidaUsuario(_nameController.text, idSesion!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Partida creada ♥')),
        );                                 
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const Partidas()
          )
        );
        break;
      case 409:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('El nombre de partida ya existe')),
        );
        break;
      case 500:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creando partida')),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creando partida')),
        );
    }
  }

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
        title: const Text("Crear partida"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Nombre de partida',
                  hintText: 'Introduce partida',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                minLines: 3,
                maxLines: null,
                controller: _historiaController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Historia de partida',
                  hintText: 'Introduce la historia',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: _crearPartida,
                child: const Text('Crear partida'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
