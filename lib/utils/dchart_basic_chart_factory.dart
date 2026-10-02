import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import '../data/chart_data.dart';
import 'dart:math';

/// 40 gráficas básicas usando la librería d_chart.
class FabricaDChartBasica {
  static final Random _aleatorio = Random(60);

  static List<DefinicionGrafica> generarGraficasBasicas() {
    List<DefinicionGrafica> graficas = [];

    // Colores de apoyo
    final colores = [
      DChartColor.fromHex('#7B2FBE'),
      DChartColor.fromHex('#2FB4BE'),
      DChartColor.fromHex('#BE2F7B'),
      DChartColor.fromHex('#BE7B2F'),
      DChartColor.fromHex('#2FBE7B'),
      DChartColor.fromHex('#5B8FF9'),
      DChartColor.fromHex('#E8684A'),
      DChartColor.fromHex('#F6BD16'),
      DChartColor.fromHex('#5AD8A6'),
      DChartColor.fromHex('#9270CA'),
    ];

    // --- 10 GRÁFICAS DE BARRAS ---
    for (int i = 1; i <= 10; i++) {
      final color = colores[i - 1];
      graficas.add(DefinicionGrafica(
        id: 'dc_barras_$i',
        nombre: 'Gráfica de Barras $i',
        libreria: 'd_chart',
        categoria: 'basica',
        subCategoria: 'Barras',
        constructor: (context) => DChartBarO(
          data: [
            OrdinalGroup(
              id: '1',
              data: List.generate(6, (j) => OrdinalData(
                domain: 'D${j+1}',
                measure: _aleatorio.nextDouble() * 100,
                color: color,
              )),
            ),
          ],
          animate: true,
          animationDuration: const Duration(milliseconds: 700),
          barLabelDecorator: i % 3 == 0 ? BarLabelDecorator() : null,
        ),
      ));
    }

    // --- 10 GRÁFICAS DE LÍNEAS ---
    for (int i = 1; i <= 10; i++) {
      final color = colores[i - 1];
      graficas.add(DefinicionGrafica(
        id: 'dc_lineas_$i',
        nombre: 'Gráfica de Líneas $i',
        libreria: 'd_chart',
        categoria: 'basica',
        subCategoria: 'Líneas',
        constructor: (context) => DChartLineO(
          data: [
            OrdinalGroup(
              id: '1',
              data: List.generate(8, (j) => OrdinalData(
                domain: 'P${j+1}',
                measure: _aleatorio.nextDouble() * 100,
                color: color,
              )),
            ),
          ],
          animate: true,
          fillAreaColor: i % 2 == 0 ? (group, data, index) => color.copyWith(alpha: 0.2) : null,
        ),
      ));
    }

    // --- 10 GRÁFICAS DE PASTEL ---
    for (int i = 1; i <= 10; i++) {
      graficas.add(DefinicionGrafica(
        id: 'dc_pastel_$i',
        nombre: 'Gráfica de Pastel $i',
        libreria: 'd_chart',
        categoria: 'basica',
        subCategoria: 'Pastel',
        constructor: (context) => DChartPieO(
          data: List.generate(5, (j) => OrdinalData(
            domain: 'Seg ${j+1}',
            measure: 10 + _aleatorio.nextDouble() * 30,
            color: colores[j % colores.length],
          )),
          animate: true,
          donutWidth: i > 5 ? 50 : 0,
          labelAccessor: i % 3 == 0 ? (data) => data.domain : null,
        ),
      ));
    }

    // --- 5 GRÁFICAS DE BARRAS GRUPALES ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'dc_grupales_$i',
        nombre: 'Barras Grupales $i',
        libreria: 'd_chart',
        categoria: 'basica',
        subCategoria: 'Barras Grupales',
        constructor: (context) => DChartBarO(
          data: [
            OrdinalGroup(
              id: 'A',
              data: List.generate(4, (j) => OrdinalData(
                domain: 'G${j+1}',
                measure: _aleatorio.nextDouble() * 80,
                color: DChartColor.fromHex('#5B8FF9'),
              )),
            ),
            OrdinalGroup(
              id: 'B',
              data: List.generate(4, (j) => OrdinalData(
                domain: 'G${j+1}',
                measure: _aleatorio.nextDouble() * 80,
                color: DChartColor.fromHex('#5AD8A6'),
              )),
            ),
          ],
          animate: true,
          groupType: OrdinalGroupType.grouped,
        ),
      ));
    }

    // --- 5 GRÁFICAS DE BARRAS APILADAS ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'dc_apiladas_$i',
        nombre: 'Barras Apiladas $i',
        libreria: 'd_chart',
        categoria: 'basica',
        subCategoria: 'Barras Apiladas',
        constructor: (context) => DChartBarO(
          data: [
            OrdinalGroup(
              id: 'Capa 1',
              data: List.generate(5, (j) => OrdinalData(
                domain: 'M${j+1}',
                measure: _aleatorio.nextDouble() * 50,
                color: DChartColor.fromHex('#7B2FBE'),
              )),
            ),
            OrdinalGroup(
              id: 'Capa 2',
              data: List.generate(5, (j) => OrdinalData(
                domain: 'M${j+1}',
                measure: _aleatorio.nextDouble() * 50,
                color: DChartColor.fromHex('#E8684A'),
              )),
            ),
          ],
          animate: true,
          groupType: OrdinalGroupType.stacked,
        ),
      ));
    }

    return graficas;
  }
}
