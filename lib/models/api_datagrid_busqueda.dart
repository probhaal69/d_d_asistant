import 'package:flutter/material.dart';

contentBusqueda (label){
  switch (label) {
    case 'Search':
      return 'Buscar';
    case 'Hint':
      return 'Ingrese el término de búsqueda';
    case 'Icon':
      return const Icon(Icons.youtube_searched_for);
    default:
      return '';
  }
}