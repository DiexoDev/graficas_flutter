import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import '../data/chart_data.dart';
import 'dart:math';

/// 25 gráficas avanzadas usando la librería d_chart.
class FabricaDChartAvanzada {
  static final Random _aleatorio = Random(65);

  static List<DefinicionGrafica> generarGraficasAvanzadas() {
    List<DefinicionGrafica> graficas = [];

    final colores = [
      DChartColor.fromHex('#7B2FBE'),
      DChartColor.fromHex('#2FB4BE'),
      DChartColor.fromHex('#BE2F7B'),
      DChartColor.fromHex('#BE7B2F'),
      DChartColor.fromHex('#2FBE7B'),
    ];

    // --- 10 LÍNEAS MULTI-SERIE (combinadas) ---
    for (int i = 1; i <= 10; i++) {
      graficas.add(DefinicionGrafica(
        id: 'dc_adv_multilinea_$i',
        nombre: 'Multi-Línea Avanzada $i',
        libreria: 'd_chart',
        categoria: 'avanzada',
        subCategoria: 'Multi-Línea',
        constructor: (context) => DChartLineO(
          data: List.generate(3, (s) => OrdinalGroup(
            id: 'Serie $s',
            data: List.generate(7, (j) => OrdinalData(
              domain: 'P${j+1}',
              measure: _aleatorio.nextDouble() * 100,
              color: colores[s % colores.length],
            )),
          )),
          animate: true,
          fillAreaColor: i % 2 == 0 ? (group, data, index) => colores[int.parse(group.id.split(' ').last)].copyWith(alpha: 0.15) : null,
        ),
      ));
    }

    // --- 10 BARRAS AGRUPADAS AVANZADAS ---
    for (int i = 1; i <= 10; i++) {
      final esApilada = i > 5;
      graficas.add(DefinicionGrafica(
        id: 'dc_adv_barras_$i',
        nombre: esApilada ? 'Barras Apiladas Avanzada $i' : 'Barras Grupales Avanzada $i',
        libreria: 'd_chart',
        categoria: 'avanzada',
        subCategoria: esApilada ? 'Multi-Barra Apilada' : 'Multi-Barra Grupada',
        constructor: (context) => DChartBarO(
          data: List.generate(3, (s) => OrdinalGroup(
            id: 'G$s',
            data: List.generate(5, (j) => OrdinalData(
              domain: 'K${j+1}',
              measure: 10 + _aleatorio.nextDouble() * 70,
              color: colores[s % colores.length],
            )),
          )),
          animate: true,
          groupType: esApilada ? OrdinalGroupType.stacked : OrdinalGroupType.grouped,
          barLabelDecorator: i == 7 ? BarLabelDecorator() : null,
        ),
      ));
    }

    // --- 5 PASTEL AVANZADO (donut con etiquetas) ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'dc_adv_dona_$i',
        nombre: 'Dona Compleja $i',
        libreria: 'd_chart',
        categoria: 'avanzada',
        subCategoria: 'Donas Complejas',
        constructor: (context) => DChartPieO(
          data: List.generate(6, (j) => OrdinalData(
            domain: 'Seg ${j+1}',
            measure: 5 + _aleatorio.nextDouble() * 35,
            color: colores[j % colores.length],
          )),
          animate: true,
          donutWidth: 45 + i * 5.0,
          labelAccessor: (data) => data.domain,
          arcLabelPosition: ArcLabelPosition.outside,
        ),
      ));
    }

    return graficas;
  }
}
