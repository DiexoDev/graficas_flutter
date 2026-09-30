import 'package:flutter/widgets.dart';

class DefinicionGrafica {
  final String id;
  final String nombre;
  final String categoria; // 'basica' o 'avanzada'
  final String subCategoria;
  final WidgetBuilder constructor;

  DefinicionGrafica({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.subCategoria,
    required this.constructor,
  });
}
