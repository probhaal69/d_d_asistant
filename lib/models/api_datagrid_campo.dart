import 'package:flutter/material.dart';

class MostrarCampo extends StatelessWidget {
  const MostrarCampo(
      {
      required this.campo,
      this.master,
      this.creador,
      super.key
      }
  );
  final String campo;
  final int? master;
  final int? creador;

  Color getColor() {
    if (creador == 1) {
      return Color.fromARGB(157, 218, 186, 6);
    } else if (master == 1) {
      return Color.fromARGB(157, 15, 199, 125);
    } else {
      return Color.fromARGB(157, 125, 15, 199);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 40,
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius:
            const BorderRadius.all(Radius.circular(5))
      ),
      child: Row(
        children: [
          Text(campo),
        ],
      ),
    );
  }
}
