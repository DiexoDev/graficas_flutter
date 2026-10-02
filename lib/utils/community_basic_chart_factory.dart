import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import '../data/chart_data.dart';
import 'dart:math';

class FabricaCommunityBasica {
  static final Random _aleatorio = Random(80);

  static List<DefinicionGrafica> generarGraficasBasicas() {
    List<DefinicionGrafica> graficas = [];

    // Datos de series reutilizables
    List<charts.Series<_DatoBarras, String>> serieBasica({Color color = Colors.blue}) {
      final datos = List.generate(6, (i) => _DatoBarras(i.toString(), _aleatorio.nextInt(100)));
      return [
        charts.Series<_DatoBarras, String>(
          id: 'datos',
          data: datos,
          domainFn: (d, _) => d.dominio,
          measureFn: (d, _) => d.valor,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(color),
        )
      ];
    }

    List<charts.Series<_DatoLinea, int>> serieLinea({Color color = Colors.deepPurple}) {
      final datos = List.generate(10, (i) => _DatoLinea(i, _aleatorio.nextInt(100).toDouble()));
      return [
        charts.Series<_DatoLinea, int>(
          id: 'linea',
          data: datos,
          domainFn: (d, _) => d.x,
          measureFn: (d, _) => d.y,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(color),
        )
      ];
    }

    // --- 10 GRÁFICAS DE LÍNEAS ---
    final coloresLinea = [Colors.purple, Colors.teal, Colors.red, Colors.indigo, Colors.amber, Colors.blue, Colors.green, Colors.orange, Colors.cyan, Colors.pink];
    for (int i = 1; i <= 10; i++) {
      final color = coloresLinea[i - 1];
      graficas.add(DefinicionGrafica(
        id: 'c_linea_$i',
        nombre: 'Gráfica de Líneas $i',
        libreria: 'community_charts_flutter',
        categoria: 'basica',
        subCategoria: 'Líneas',
        constructor: (context) => charts.LineChart(
          serieLinea(color: color),
          animate: true,
          defaultRenderer: charts.LineRendererConfig(includePoints: i % 2 == 0),
        ),
      ));
    }

    // --- 10 GRÁFICAS DE BARRAS ---
    final coloresBarras = [Colors.indigo, Colors.teal, Colors.red, Colors.amber, Colors.cyan, Colors.purple, Colors.blue, Colors.green, Colors.orange, Colors.pink];
    for (int i = 1; i <= 10; i++) {
      final color = coloresBarras[i - 1];
      graficas.add(DefinicionGrafica(
        id: 'c_barras_$i',
        nombre: 'Gráfica de Barras $i',
        libreria: 'community_charts_flutter',
        categoria: 'basica',
        subCategoria: 'Barras',
        constructor: (context) => charts.BarChart(
          serieBasica(color: color),
          animate: true,
          vertical: i % 2 == 0,
        ),
      ));
    }

    // --- 10 GRÁFICAS DE BARRAS GRUPALES ---
    for (int i = 1; i <= 10; i++) {
      graficas.add(DefinicionGrafica(
        id: 'c_barras_grupales_$i',
        nombre: 'Barras Grupales $i',
        libreria: 'community_charts_flutter',
        categoria: 'basica',
        subCategoria: 'Barras Grupales',
        constructor: (context) {
          final datos1 = List.generate(4, (j) => _DatoBarras(j.toString(), _aleatorio.nextInt(80)));
          final datos2 = List.generate(4, (j) => _DatoBarras(j.toString(), _aleatorio.nextInt(80)));
          return charts.BarChart(
            [
              charts.Series<_DatoBarras, String>(id: 'SerieA', data: datos1, domainFn: (d, _) => d.dominio, measureFn: (d, _) => d.valor, colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue)),
              charts.Series<_DatoBarras, String>(id: 'SerieB', data: datos2, domainFn: (d, _) => d.dominio, measureFn: (d, _) => d.valor, colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red)),
            ],
            animate: true,
            barGroupingType: charts.BarGroupingType.grouped,
          );
        },
      ));
    }

    // --- 5 PIE CHARTS ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'c_pie_$i',
        nombre: 'Gráfica de Pastel $i',
        libreria: 'community_charts_flutter',
        categoria: 'basica',
        subCategoria: 'Pastel',
        constructor: (context) {
          final datos = List.generate(4, (j) => _DatoBarras('Seg ${j+1}', _aleatorio.nextInt(100)));
          return charts.PieChart<String>(
            [charts.Series<_DatoBarras, String>(id: 'pastel', data: datos, domainFn: (d, _) => d.dominio, measureFn: (d, _) => d.valor)],
            animate: true,
          );
        },
      ));
    }

    // --- 5 ÁREA CHARTS ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'c_area_$i',
        nombre: 'Gráfica de Área $i',
        libreria: 'community_charts_flutter',
        categoria: 'basica',
        subCategoria: 'Área',
        constructor: (context) => charts.LineChart(
          serieLinea(color: Colors.cyan),
          animate: true,
          defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: false),
        ),
      ));
    }

    return graficas;
  }
}

class _DatoBarras {
  final String dominio;
  final int valor;
  _DatoBarras(this.dominio, this.valor);
}

class _DatoLinea {
  final int x;
  final double y;
  _DatoLinea(this.x, this.y);
}
