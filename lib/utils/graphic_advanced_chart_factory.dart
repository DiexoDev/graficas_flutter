import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import '../data/chart_data.dart';
import 'dart:math';

class FabricaGraphicAvanzada {
  static final Random _aleatorio = Random(77);

  static List<DefinicionGrafica> generarGraficasAvanzadas() {
    List<DefinicionGrafica> graficas = [];

    // --- 5 COMBINACIONES: Barra + Línea ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_adv_combo_$i',
        nombre: 'Avanzada Combo Línea-Barra $i',
        libreria: 'graphic',
        categoria: 'avanzada',
        subCategoria: 'Combo Barra-Línea',
        constructor: (context) => _construirComboBarraLinea(),
      ));
    }

    // --- 5 GRÁFICAS CON COLORES POR GRUPO ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_adv_grupo_$i',
        nombre: 'Avanzada por Grupos $i',
        libreria: 'graphic',
        categoria: 'avanzada',
        subCategoria: 'Grupos de Color',
        constructor: (context) => _construirGraficaGrupos(),
      ));
    }

    // --- 5 GRÁFICAS POLARES (PIE en Graphic) ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_adv_polar_$i',
        nombre: 'Avanzada Polar $i',
        libreria: 'graphic',
        categoria: 'avanzada',
        subCategoria: 'Polares',
        constructor: (context) => _construirGraficaPolar(),
      ));
    }

    // --- 5 ÁREAS APILADAS ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_adv_area_apilada_$i',
        nombre: 'Área Apilada $i',
        libreria: 'graphic',
        categoria: 'avanzada',
        subCategoria: 'Áreas Apiladas',
        constructor: (context) => _construirAreaApilada(),
      ));
    }

    // --- 5 PUNTOS DIMENSIONALES ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'g_adv_burbuja_$i',
        nombre: 'Burbuja/Punto Dimensional $i',
        libreria: 'graphic',
        categoria: 'avanzada',
        subCategoria: 'Burbujas',
        constructor: (context) => _construirGraficaBurbuja(),
      ));
    }

    return graficas;
  }

  static Widget _construirComboBarraLinea() {
    final datos = List.generate(7, (i) => {'x': i.toString(), 'y': _aleatorio.nextDouble() * 100});
    return Chart(
      data: datos,
      variables: {
        'x': Variable(accessor: (Map<String, dynamic> d) => d['x'] as String),
        'y': Variable(accessor: (Map<String, dynamic> d) => d['y'] as num),
      },
      marks: [
        IntervalMark(color: ColorEncode(value: Colors.blue.withOpacity(0.5))),
        LineMark(color: ColorEncode(value: Colors.red)),
        PointMark(color: ColorEncode(value: Colors.red)),
      ],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    );
  }

  static Widget _construirGraficaGrupos() {
    final grupos = ['A', 'B', 'C'];
    final datos = List.generate(9, (i) => {
      'x': i.toString(),
      'y': _aleatorio.nextDouble() * 100,
      'grupo': grupos[i % 3],
    });
    return Chart(
      data: datos,
      variables: {
        'x': Variable(accessor: (Map<String, dynamic> d) => d['x'] as String),
        'y': Variable(accessor: (Map<String, dynamic> d) => d['y'] as num),
        'grupo': Variable(accessor: (Map<String, dynamic> d) => d['grupo'] as String),
      },
      marks: [IntervalMark(
        color: ColorEncode(variable: 'grupo', values: [Colors.red, Colors.blue, Colors.green]),
      )],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    );
  }

  static Widget _construirGraficaPolar() {
    final datos = List.generate(5, (i) => {'tipo': 'Seg $i', 'valor': _aleatorio.nextDouble() * 100});
    return Chart(
      data: datos,
      variables: {
        'tipo': Variable(accessor: (Map<String, dynamic> d) => d['tipo'] as String),
        'valor': Variable(accessor: (Map<String, dynamic> d) => d['valor'] as num),
      },
      marks: [IntervalMark(
        color: ColorEncode(variable: 'tipo', values: [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple]),
      )],
      coord: PolarCoord(),
    );
  }

  static Widget _construirAreaApilada() {
    final datos = <Map<String, dynamic>>[];
    for (int i = 0; i < 8; i++) {
      datos.add({'x': i.toString(), 'y': _aleatorio.nextDouble() * 50, 'serie': 'A'});
      datos.add({'x': i.toString(), 'y': _aleatorio.nextDouble() * 50, 'serie': 'B'});
    }
    return Chart(
      data: datos,
      variables: {
        'x': Variable(accessor: (Map<String, dynamic> d) => d['x'] as String),
        'y': Variable(accessor: (Map<String, dynamic> d) => d['y'] as num),
        'serie': Variable(accessor: (Map<String, dynamic> d) => d['serie'] as String),
      },
      marks: [AreaMark(
        position: Varset('x') * Varset('y') / Varset('serie'),
        color: ColorEncode(variable: 'serie', values: [Colors.cyan.withOpacity(0.5), Colors.indigo.withOpacity(0.5)]),
      )],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    );
  }

  static Widget _construirGraficaBurbuja() {
    final datos = List.generate(15, (i) => {
      'x': _aleatorio.nextDouble() * 100.0,
      'y': _aleatorio.nextDouble() * 100.0,
      'tam': _aleatorio.nextDouble() * 20 + 5,
    });
    return Chart(
      data: datos,
      variables: {
        'x': Variable(accessor: (Map<String, dynamic> d) => d['x'] as num),
        'y': Variable(accessor: (Map<String, dynamic> d) => d['y'] as num),
        'tam': Variable(accessor: (Map<String, dynamic> d) => d['tam'] as num),
      },
      marks: [PointMark(
        size: SizeEncode(variable: 'tam', values: [4, 20]),
        color: ColorEncode(value: Colors.teal.withOpacity(0.7)),
      )],
      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
    );
  }
}
