import 'package:flutter/material.dart';

class MostrarCampo extends StatelessWidget {
  const MostrarCampo(
      {
      required this.campo,
      super.key
      }
  );
  final String campo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 40,
      decoration: const BoxDecoration(
        color: Color.fromARGB(157, 125, 15, 199),
        borderRadius:
            BorderRadius.all(Radius.circular(5))
      ),
      child: Row(
        children: [
          Text(campo),
        ],
      ),
    );
  }
}
