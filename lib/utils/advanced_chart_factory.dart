import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/chart_data.dart';
import 'dart:math';

class FabricaGraficasAvanzadas {
  static final Random _aleatorio = Random(99);

  static List<DefinicionGrafica> generarGraficasAvanzadas() {
    List<DefinicionGrafica> graficas = [];

    // --- 5 COMBINACIONES: Barra + Línea ---
    for (int i = 1; i <= 5; i++) {
        graficas.add(DefinicionGrafica(
            id: 'combo_avanzado_$i',
            nombre: 'Avanzada Combo Barra-Línea $i',
            categoria: 'avanzada',
            subCategoria: 'Combo Barra-Línea',
            constructor: (context) => _construirGraficaDeGotaBarra(
                colorDeLinea: _obtenerColorAleatorio(),
                colorDeBarra: _obtenerColorAleatorio(),
                indiceDeCurva: i,
            ),
        ));
    }

    // --- 5 COMBINACIONES: Dispersión + Línea ---
    for (int i = 1; i <= 5; i++) {
        graficas.add(DefinicionGrafica(
            id: 'combo_disp_linea_$i',
            nombre: 'Avanzada Combo Dispersión-Línea $i',
            categoria: 'avanzada',
            subCategoria: 'Combo Dispersión-Línea',
            constructor: (context) => _construirGraficaDispersionYLinea(
                colorDeLinea: _obtenerColorAleatorio(),
                colorDeDispersion: _obtenerColorAleatorio(),
            ),
        ));
    }

    // --- 5 LÍNEAS AVANZADAS (Gradientes, Áreas) ---
    for (int i = 1; i <= 5; i++) {
        graficas.add(DefinicionGrafica(
            id: 'linea_grad_avanzada_$i',
            nombre: 'Línea de Área Gradiente $i',
            categoria: 'avanzada',
            subCategoria: 'Líneas Avanzadas',
            constructor: (context) => _construirGraficaLineaAvanzada(
                colores: [_obtenerColorAleatorio(), _obtenerColorAleatorio()],
                mostrarMultiplesLineas: i % 2 == 0,
            ),
        ));
    }

    // --- 5 PASTELES AVANZADOS (Interactivos / Explanados visualmente) ---
    for (int i = 1; i <= 5; i++) {
        graficas.add(DefinicionGrafica(
            id: 'pastel_avanzado_$i',
            nombre: 'Pastel Complejo $i',
            categoria: 'avanzada',
            subCategoria: 'Pastel Avanzado',
            constructor: (context) => _construirGraficaPastelAvanzado(
                indiceExplosion: i % 4,
            ),
        ));
    }

    // --- 5 BARRAS AVANZADAS (Múltiples barras agrupadas) ---
    for (int i = 1; i <= 5; i++) {
        graficas.add(DefinicionGrafica(
            id: 'barra_multi_avanzada_$i',
            nombre: 'Barras Agrupadas/Apiladas $i',
            categoria: 'avanzada',
            subCategoria: 'Barras Avanzadas',
            constructor: (context) => _construirGraficaBarraAvanzada(
                grupos: i + 3,
            ),
        ));
    }

    return graficas;
  }

  static Color _obtenerColorAleatorio() {
    return Color.fromARGB(
      255,
      100 + _aleatorio.nextInt(155),
      100 + _aleatorio.nextInt(155),
      100 + _aleatorio.nextInt(155),
    );
  }

  static Widget _construirGraficaDeGotaBarra({required Color colorDeLinea, required Color colorDeBarra, required int indiceDeCurva}) {
    // Usamos un Stack (Pila) para superponer perfectamente un LineChart y un BarChart
    // El tamaño mínimo y máximo de los ejes X e Y debe ser explícitamente idéntico.
    return Stack(
        children: [
            BarChart(
                BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 10,
                    minY: 0,
                    barGroups: List.generate(6, (i) => BarChartGroupData(
                        x: i,
                        barRods: [
                            BarChartRodData(toY: 2 + _aleatorio.nextDouble() * 6, color: colorDeBarra.withAlpha(100), width: 20)
                        ]
                    )),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                )
            ),
            LineChart(
                LineChartData(
                    minX: -0.5,
                    maxX: 5.5,
                    minY: 0,
                    maxY: 10,
                    lineBarsData: [
                        LineChartBarData(
                            spots: List.generate(6, (i) => FlSpot(i.toDouble(), 4 + _aleatorio.nextDouble() * 5)),
                            isCurved: indiceDeCurva % 2 == 0,
                            color: colorDeLinea,
                            barWidth: 4,
                            dotData: FlDotData(show: true),
                        )
                    ],
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                )
            ),
        ],
    );
  }

  static Widget _construirGraficaDispersionYLinea({required Color colorDeLinea, required Color colorDeDispersion}) {
      return Stack(
          children: [
              LineChart(
                  LineChartData(
                      minX: 0, maxX: 10, minY: 0, maxY: 10,
                      lineBarsData: [
                          LineChartBarData(
                              spots: [FlSpot(0, 0), FlSpot(5, 5), FlSpot(10, 8)],
                              isCurved: false,
                              color: colorDeLinea,
                              barWidth: 2,
                              dashArray: [5, 5]
                          )
                      ],
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                  )
              ),
              ScatterChart(
                  ScatterChartData(
                      minX: 0, maxX: 10, minY: 0, maxY: 10,
                      scatterSpots: List.generate(15, (i) => ScatterSpot(
                          _aleatorio.nextDouble() * 10,
                          _aleatorio.nextDouble() * 10,
                          dotPainter: FlDotCirclePainter(radius: 5+_aleatorio.nextDouble()*5, color: colorDeDispersion)
                      )),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                  )
              ),
          ]
      );
  }

  static Widget _construirGraficaLineaAvanzada({required List<Color> colores, required bool mostrarMultiplesLineas}) {
    List<LineChartBarData> lineas = [];
    
    lineas.add(LineChartBarData(
        spots: List.generate(10, (i) => FlSpot(i.toDouble(), 2+_aleatorio.nextDouble()*6)),
        isCurved: true,
        gradient: LinearGradient(colors: colores),
        barWidth: 5,
        belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: colores.map((c) => c.withAlpha(80)).toList(), begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    ));

    if (mostrarMultiplesLineas) {
        lineas.add(LineChartBarData(
            spots: List.generate(10, (i) => FlSpot(i.toDouble(), _aleatorio.nextDouble()*4)),
            isCurved: true,
            color: _obtenerColorAleatorio(),
            barWidth: 3,
        ));
    }

    return LineChart(
        LineChartData(
            lineBarsData: lineas,
            titlesData: FlTitlesData(show: false),
        )
    );
  }

  static Widget _construirGraficaPastelAvanzado({required int indiceExplosion}) {
      return PieChart(
          PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: List.generate(4, (i) {
                  bool estaExplotado = i == indiceExplosion;
                  return PieChartSectionData(
                      color: _obtenerColorAleatorio(),
                      value: 15 + _aleatorio.nextDouble()*20,
                      title: '${15+i}%',
                      radius: estaExplotado ? 60 : 50,
                      titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(color: Colors.black, blurRadius: 2)]),
                  );
              })
          )
      );
  }

  static Widget _construirGraficaBarraAvanzada({required int grupos}) {
      return BarChart(
          BarChartData(
              alignment: BarChartAlignment.spaceEvenly,
              barGroups: List.generate(grupos, (i) {
                  return BarChartGroupData(
                      x: i,
                      barRods: [
                          BarChartRodData(toY: 1 + _aleatorio.nextDouble()*8, color: _obtenerColorAleatorio(), width: 10),
                          BarChartRodData(toY: 1 + _aleatorio.nextDouble()*8, color: _obtenerColorAleatorio(), width: 10),
                          BarChartRodData(toY: 1 + _aleatorio.nextDouble()*8, color: _obtenerColorAleatorio(), width: 10),
                      ]
                  );
              }),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
          )
      );
  }
}
