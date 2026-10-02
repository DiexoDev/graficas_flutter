import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/chart_data.dart';
import 'dart:math';

class FabricaGraficasBasicas {
  static final Random _aleatorio = Random(42);

  static List<DefinicionGrafica> generarGraficasBasicas() {
    List<DefinicionGrafica> graficas = [];

    // --- 10 GRÁFICAS DE LÍNEAS ---
    for (int i = 1; i <= 10; i++) {
      graficas.add(DefinicionGrafica(
        id: 'linea_basica_$i',
        nombre: 'Gráfica de Líneas $i',
        libreria: 'fl_chart',
        categoria: 'basica',
        subCategoria: 'Líneas',
        constructor: (context) => _construirGraficaDeLinea(
          esCurvada: i % 2 == 0,
          esLineaEscalonada: i == 5 || i == 6,
          mostrarPuntos: i % 3 != 0,
          color: _obtenerColorAleatorio(),
        ),
      ));
    }

    // --- 10 GRÁFICAS DE BARRAS ---
    for (int i = 1; i <= 10; i++) {
        graficas.add(DefinicionGrafica(
            id: 'barra_basica_$i',
            nombre: 'Gráfica de Barras $i',
            libreria: 'fl_chart',
            categoria: 'basica',
            subCategoria: 'Barras',
            constructor: (context) => _construirGraficaDeBarra(
                color: _obtenerColorAleatorio(),
                esApilada: i > 5,
                radioDeBorde: i % 2 == 0 ? 0 : 8,
            ),
        ));
    }

    // --- 10 GRÁFICAS DE PASTEL ---
    for (int i = 1; i <= 10; i++) {
        graficas.add(DefinicionGrafica(
            id: 'pastel_basico_$i',
            nombre: 'Gráfica de Pastel $i',
            libreria: 'fl_chart',
            categoria: 'basica',
            subCategoria: 'Pastel',
            constructor: (context) => _construirGraficaDePastel(
                esDona: i > 5,
                espacioEntreSecciones: (i % 3) * 2.0,
            ),
        ));
    }

    // --- 5 GRÁFICAS DE DISPERSIÓN ---
    for (int i = 1; i <= 5; i++) {
        graficas.add(DefinicionGrafica(
            id: 'dispersion_basica_$i',
            nombre: 'Gráfica de Dispersión $i',
            libreria: 'fl_chart',
            categoria: 'basica',
            subCategoria: 'Dispersión',
            constructor: (context) => _construirGraficaDeDispersion(
                color: _obtenerColorAleatorio(),
            ),
        ));
    }

    // --- 5 GRÁFICAS DE RADAR ---
    for (int i = 1; i <= 5; i++) {
        graficas.add(DefinicionGrafica(
            id: 'radar_basico_$i',
            nombre: 'Gráfica de Radar $i',
            libreria: 'fl_chart',
            categoria: 'basica',
            subCategoria: 'Radar',
            constructor: (context) => _construirGraficaDeRadar(
                color: _obtenerColorAleatorio(),
                grosorDeBorde: (i % 3) + 1.0,
            ),
        ));
    }

    return graficas;
  }

  // Generadores
  static Color _obtenerColorAleatorio() {
    return Color.fromARGB(
      255,
      100 + _aleatorio.nextInt(155),
      100 + _aleatorio.nextInt(155),
      100 + _aleatorio.nextInt(155),
    );
  }

  static Widget _construirGraficaDeLinea({required bool esCurvada, required bool esLineaEscalonada, required bool mostrarPuntos, required Color color}) {
    List<FlSpot> puntos = List.generate(8, (indice) => FlSpot(indice.toDouble(), _aleatorio.nextDouble() * 10));
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: puntos,
            isCurved: esCurvada,
            isStepLineChart: esLineaEscalonada,
            color: color,
            barWidth: 4,
            dotData: FlDotData(show: mostrarPuntos),
          ),
        ],
      ),
    );
  }

  static Widget _construirGraficaDeBarra({required Color color, required bool esApilada, required double radioDeBorde}) {
    List<BarChartGroupData> grupos = List.generate(7, (indice) {
      double valor1 = _aleatorio.nextDouble() * 10;
      double valor2 = _aleatorio.nextDouble() * 5;
      return BarChartGroupData(
        x: indice,
        barRods: esApilada 
            ? [
                BarChartRodData(
                  toY: valor1 + valor2,
                  color: color,
                  borderRadius: BorderRadius.circular(radioDeBorde),
                  rodStackItems: [
                    BarChartRodStackItem(0, valor1, color.withAlpha(150)),
                    BarChartRodStackItem(valor1, valor1 + valor2, color),
                  ]
                )
              ]
            : [
                BarChartRodData(
                  toY: valor1,
                  color: color,
                  borderRadius: BorderRadius.circular(radioDeBorde),
                ),
                BarChartRodData(
                  toY: valor2,
                  color: color.withAlpha(150),
                  borderRadius: BorderRadius.circular(radioDeBorde),
                ),
              ],
      );
    });

    return BarChart(
      BarChartData(
        barGroups: grupos,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }

  static Widget _construirGraficaDePastel({required bool esDona, required double espacioEntreSecciones}) {
    List<PieChartSectionData> secciones = List.generate(4, (indice) {
        return PieChartSectionData(
            color: _obtenerColorAleatorio(),
            value: 10 + _aleatorio.nextDouble() * 40,
            title: '${indice + 1}',
            radius: esDona ? 40 : 80,
            titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        );
    });

    return PieChart(
        PieChartData(
            sectionsSpace: espacioEntreSecciones,
            centerSpaceRadius: esDona ? 60 : 0,
            sections: secciones,
            borderData: FlBorderData(show: false),
        ),
    );
  }

  static Widget _construirGraficaDeDispersion({required Color color}) {
    List<ScatterSpot> puntos = List.generate(20, (indice) {
        return ScatterSpot(
            _aleatorio.nextDouble() * 10,
            _aleatorio.nextDouble() * 10,
            dotPainter: FlDotCirclePainter(
                radius: 4 + _aleatorio.nextDouble() * 6,
                color: color.withAlpha((100 + _aleatorio.nextInt(155)).toInt()),
            )
        );
    });

    return ScatterChart(
        ScatterChartData(
            scatterSpots: puntos,
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: true),
        ),
    );
  }

  static Widget _construirGraficaDeRadar({required Color color, required double grosorDeBorde}) {
    return RadarChart(
        RadarChartData(
            dataSets: [
                RadarDataSet(
                    dataEntries: List.generate(5, (_) => RadarEntry(value: 2 + _aleatorio.nextDouble() * 8)),
                    fillColor: color.withAlpha(50),
                    borderColor: color,
                    entryRadius: 3,
                    borderWidth: grosorDeBorde,
                ),
            ],
            tickCount: 5,
            ticksTextStyle: const TextStyle(color: Colors.transparent),
        ),
    );
  }
}
