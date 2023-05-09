import 'package:flutter/material.dart';

import 'package:d_d_asistant/theme/app_theme.dart';
import 'package:d_d_asistant/router/app_routes.dart';

import 'package:d_d_asistant/models/sesion.dart';


class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  final menuOptions = AppRoutes.menuOptions;
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: _cerrarSesion,
                tooltip: 'Cerrar sesión',
              ),
            ],
            title: const Text('Main Api D&D'),
          ),
          body: ListView.separated(
              itemBuilder: (context, i) => ListTile(
                    leading: Icon(menuOptions[i].icon,
                        color: AppTheme.darkTheme.primaryColor),
                    title: Text(menuOptions[i].name),
                    onTap: () {
                      Navigator.pushNamed(context, menuOptions[i].route);
                    },
                  ),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: menuOptions.length
              ),
          ),
    );
  }
}
