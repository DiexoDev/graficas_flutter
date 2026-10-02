import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import '../data/chart_data.dart';
import 'dart:math';

class FabricaCommunityAvanzada {
  static final Random _aleatorio = Random(85);

  static List<DefinicionGrafica> generarGraficasAvanzadas() {
    List<DefinicionGrafica> graficas = [];

    // --- 5 BARRAS APILADAS ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'c_adv_apiladas_$i',
        nombre: 'Barras Apiladas $i',
        libreria: 'community_charts_flutter',
        categoria: 'avanzada',
        subCategoria: 'Barras Apiladas',
        constructor: (context) {
          final datos1 = List.generate(5, (j) => _DatoBarras(j.toString(), _aleatorio.nextInt(50)));
          final datos2 = List.generate(5, (j) => _DatoBarras(j.toString(), _aleatorio.nextInt(50)));
          return charts.BarChart(
            [
              charts.Series<_DatoBarras, String>(id: 'Capa1', data: datos1, domainFn: (d, _) => d.dominio, measureFn: (d, _) => d.valor, colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue)),
              charts.Series<_DatoBarras, String>(id: 'Capa2', data: datos2, domainFn: (d, _) => d.dominio, measureFn: (d, _) => d.valor, colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.cyan)),
            ],
            animate: true,
            barGroupingType: charts.BarGroupingType.stacked,
          );
        },
      ));
    }

    // --- 5 LÍNEA MULTI-SERIE ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'c_adv_multilinea_$i',
        nombre: 'Múltiples Líneas $i',
        libreria: 'community_charts_flutter',
        categoria: 'avanzada',
        subCategoria: 'Multi-Línea',
        constructor: (context) {
          List<charts.Series<_DatoLinea, int>> series = List.generate(3, (s) {
            final colores = [Colors.red, Colors.indigo, Colors.teal];
            return charts.Series<_DatoLinea, int>(
              id: 'Serie $s',
              data: List.generate(10, (j) => _DatoLinea(j, _aleatorio.nextDouble() * 100)),
              domainFn: (d, _) => d.x,
              measureFn: (d, _) => d.y,
              colorFn: (_, __) => charts.ColorUtil.fromDartColor(colores[s]),
            );
          });
          return charts.LineChart(series, animate: true);
        },
      ));
    }

    // --- 5 COMBINADAS BARRA + LÍNEA ---
    for (int i = 1; i <= 5; i++) {
      graficas.add(DefinicionGrafica(
        id: 'c_adv_combo_$i',
        nombre: 'Combo Barra-Línea $i',
        libreria: 'community_charts_flutter',
        categoria: 'avanzada',
        subCategoria: 'Combo',
        constructor: (context) {
          final datosBar = List.generate(6, (j) => _DatoCombinado(j.toString(), _aleatorio.nextInt(100), _aleatorio.nextDouble() * 100));
          return charts.BarChart(
            [
              charts.Series<_DatoCombinado, String>(id: 'Barras', data: datosBar, domainFn: (d, _) => d.dominio, measureFn: (d, _) => d.valBar, colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.indigo.withOpacity(0.6))),
              charts.Series<_DatoCombinado, String>(id: 'Línea', data: datosBar, domainFn: (d, _) => d.dominio, measureFn: (d, _) => d.valLine, colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red))
                ..setAttribute(charts.rendererIdKey, 'customLine'),
            ],
            animate: true,
            customSeriesRenderers: [
              charts.LineRendererConfig(customRendererId: 'customLine', includePoints: true),
            ],
          );
        },
      ));
    }

    // --- 10 PASTEL COMPLEJOS (Donut) ---
    for (int i = 1; i <= 10; i++) {
      graficas.add(DefinicionGrafica(
        id: 'c_adv_dona_$i',
        nombre: 'Dona Compleja $i',
        libreria: 'community_charts_flutter',
        categoria: 'avanzada',
        subCategoria: 'Dona/Circular',
        constructor: (context) {
          final datos = List.generate(5, (j) => _DatoBarras('Seg ${j+1}', _aleatorio.nextInt(100)));
          return charts.PieChart<String>(
            [charts.Series<_DatoBarras, String>(id: 'dona', data: datos, domainFn: (d, _) => d.dominio, measureFn: (d, _) => d.valor)],
            animate: true,
            defaultRenderer: charts.ArcRendererConfig(arcWidth: 70),
          );
        },
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

class _DatoCombinado {
  final String dominio;
  final int valBar;
  final double valLine;
  _DatoCombinado(this.dominio, this.valBar, this.valLine);
}
