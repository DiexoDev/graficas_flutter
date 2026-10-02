import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import '../data/chart_data.dart';
import 'dart:math';

class FabricaGraphicBasica {
  static final Random _aleatorio = Random(70);

  static List<DefinicionGrafica> generarGraficasBasicas() {
    List<DefinicionGrafica> graficas = [];

    // Conjunto de datos reutilizable
    final datosSimples = List.generate(
      8,
      (i) => {'x': i.toString(), 'y': _aleatorio.nextDouble() * 100},
    );

    // --- 10 GRÁFICAS DE LÍNEAS ---
    for (int i = 1; i <= 10; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_linea_$i',
        nombre: 'Gráfica de Líneas $i',
        libreria: 'graphic',
        categoria: 'basica',
        subCategoria: 'Líneas',
        constructor: (context) => _construirGraficaLinea(datosSimples, opacidad: (i * 0.1).clamp(0.3, 1.0)),
      ));
    }

    // --- 10 GRÁFICAS DE ÁREA ---
    for (int i = 1; i <= 10; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_area_$i',
        nombre: 'Gráfica de Área $i',
        libreria: 'graphic',
        categoria: 'basica',
        subCategoria: 'Área',
        constructor: (context) => _construirGraficaArea(datosSimples),
      ));
    }

    // --- 10 GRÁFICAS DE BARRAS ---
    for (int i = 1; i <= 10; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_barras_$i',
        nombre: 'Gráfica de Barras $i',
        libreria: 'graphic',
        categoria: 'basica',
        subCategoria: 'Barras',
        constructor: (context) => _construirGraficaBarras(datosSimples, esHorizontal: i % 2 == 0),
      ));
    }

    // --- 5 GRÁFICAS DE PUNTOS ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_puntos_$i',
        nombre: 'Gráfica de Puntos $i',
        libreria: 'graphic',
        categoria: 'basica',
        subCategoria: 'Puntos',
        constructor: (context) => _construirGraficaPuntos(),
      ));
    }

    // --- 5 GRÁFICAS DE INTERVALO ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_intervalo_$i',
        nombre: 'Gráfica de Intervalo $i',
        libreria: 'graphic',
        categoria: 'basica',
        subCategoria: 'Intervalo',
        constructor: (context) => _construirGraficaIntervalo(),
      ));
    }

    return graficas;
  }

  static Widget _construirGraficaLinea(List<Map<String, dynamic>> datos, {required double opacidad}) {
    return Chart(
      data: datos,
      variables: {
        'x': Variable(accessor: (Map<String, dynamic> d) => d['x'] as String),
        'y': Variable(accessor: (Map<String, dynamic> d) => d['y'] as num),
      },
      marks: [LineMark(
        color: ColorEncode(value: Colors.deepPurple.withOpacity(opacidad)),
      )],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
    );
  }

  static Widget _construirGraficaArea(List<Map<String, dynamic>> datos) {
    return Chart(
      data: datos,
      variables: {
        'x': Variable(accessor: (Map<String, dynamic> d) => d['x'] as String),
        'y': Variable(accessor: (Map<String, dynamic> d) => d['y'] as num),
      },
      marks: [AreaMark(
        color: ColorEncode(value: Colors.cyan.withOpacity(0.5)),
      ), LineMark(
        color: ColorEncode(value: Colors.cyan),
      )],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    );
  }

  static Widget _construirGraficaBarras(List<Map<String, dynamic>> datos, {required bool esHorizontal}) {
    return Chart(
      data: datos,
      variables: {
        'x': Variable(accessor: (Map<String, dynamic> d) => d['x'] as String),
        'y': Variable(accessor: (Map<String, dynamic> d) => d['y'] as num),
      },
      marks: [IntervalMark(
        color: ColorEncode(value: Colors.indigo),
      )],
      coord: esHorizontal ? RectCoord(transposed: true) : RectCoord(),
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    );
  }

  static Widget _construirGraficaPuntos() {
    final datos = List.generate(25, (i) => {
      'x': _aleatorio.nextDouble() * 100.0,
      'y': _aleatorio.nextDouble() * 100.0,
    });
    return Chart(
      data: datos,
      variables: {
        'x': Variable(accessor: (Map<String, dynamic> d) => d['x'] as num),
        'y': Variable(accessor: (Map<String, dynamic> d) => d['y'] as num),
      },
      marks: [PointMark(
        color: ColorEncode(value: Colors.teal),
        size: SizeEncode(value: 5),
      )],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    );
  }

  static Widget _construirGraficaIntervalo() {
    final datos = List.generate(8, (i) => {
      'x': i.toString(),
      'min': _aleatorio.nextDouble() * 40,
      'max': 50.0 + _aleatorio.nextDouble() * 50,
    });
    return Chart(
      data: datos,
      variables: {
        'x': Variable(accessor: (Map<String, dynamic> d) => d['x'] as String),
        'min': Variable(accessor: (Map<String, dynamic> d) => d['min'] as num),
        'max': Variable(accessor: (Map<String, dynamic> d) => d['max'] as num),
      },
      marks: [IntervalMark(
        position: Varset('x') * (Varset('min') + Varset('max')),
        color: ColorEncode(value: Colors.orange),
      )],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    );
  }
}
