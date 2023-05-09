import 'package:flutter/material.dart';

class CustomJsonContainer extends StatelessWidget {
  final String titulo;
  final dynamic lista;

  const CustomJsonContainer({required this.titulo, required this.lista, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lista == null || lista == "") {
      return Container();
    }
    List<dynamic> items;

    if (lista is Map || lista is String || lista is int) {
      items = [lista];
    } else if (lista is List) {
      items = lista;
    } else if (lista == true) {
      items = [lista];
    } else {
      throw ArgumentError("Invalid json data type");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            var item = items[index];
            String text;
            if (item is Map) {
              text = item.entries.map((e) => '${e.key}: ${e.value}').join(', ');
            } else {
              text = item.toString();
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}