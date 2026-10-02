import 'package:flutter/material.dart';
import '../data/chart_data.dart';
import '../utils/chart_factory.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  DefinicionGrafica? _graficaSeleccionada;

  @override
  void initState() {
    super.initState();
    // Seleccionar la primera gráfica básica por defecto
    if (FabricaGraficas.graficasBasicas.isNotEmpty) {
      _graficaSeleccionada = FabricaGraficas.graficasBasicas.first;
    }
  }

  void _alSeleccionarGrafica(DefinicionGrafica grafica) {
    setState(() {
      _graficaSeleccionada = grafica;
    });
    Navigator.of(context).pop(); // Cerrar el menú lateral (Drawer)
  }

  Widget _construirDirectorioDeLibreria(String nombreLibreria, List<DefinicionGrafica> todasLasGraficas) {
    final graficasDeLibreria = todasLasGraficas.where((g) => g.libreria == nombreLibreria).toList();
    if (graficasDeLibreria.isEmpty) return const SizedBox.shrink();

    final basicas = graficasDeLibreria.where((g) => g.categoria == 'basica').toList();
    final avanzadas = graficasDeLibreria.where((g) => g.categoria == 'avanzada').toList();

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Text(nombreLibreria, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        children: [
          if (basicas.isNotEmpty) _construirListaPorCategoria('Básicas (${basicas.length})', basicas),
          if (avanzadas.isNotEmpty) _construirListaPorCategoria('Avanzadas (${avanzadas.length})', avanzadas),
        ],
      ),
    );
  }

  Widget _construirListaPorCategoria(String titulo, List<DefinicionGrafica> graficas) {
    final agrupadas = <String, List<DefinicionGrafica>>{};
    for (var chart in graficas) {
      agrupadas.putIfAbsent(chart.subCategoria, () => []).add(chart);
    }

    return ExpansionTile(
      initiallyExpanded: false,
      title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: agrupadas.entries.map((entrada) {
        return ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 16.0),
          title: Text(entrada.key),
          children: entrada.value.map((grafica) {
            return ListTile(
              contentPadding: const EdgeInsets.only(left: 48.0),
              title: Text(grafica.nombre),
              selected: _graficaSeleccionada == grafica,
              onTap: () => _alSeleccionarGrafica(grafica),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todas = [
      ...FabricaGraficas.graficasBasicas,
      ...FabricaGraficas.graficasAvanzadas,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_graficaSeleccionada?.nombre ?? 'App de Gráficas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: const Text(
                'Gráficas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _construirDirectorioDeLibreria('fl_chart', todas),
            _construirDirectorioDeLibreria('d_chart', todas),
            _construirDirectorioDeLibreria('graphic', todas),
            _construirDirectorioDeLibreria('community_charts_flutter', todas),
          ],
        ),
      ),
      body: Center(
        child: _graficaSeleccionada != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: _graficaSeleccionada!.constructor(context),
                ),
              )
            : const Text('Por favor, selecciona una gráfica del menú.'),
      ),
    );
  }
}
