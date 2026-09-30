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

  Widget _construirListaPorCategoria(String titulo, List<DefinicionGrafica> graficas) {
    final agrupadas = <String, List<DefinicionGrafica>>{};
    for (var grafica in graficas) {
      agrupadas.putIfAbsent(grafica.subCategoria, () => []).add(grafica);
    }

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: agrupadas.entries.map((entrada) {
          return ExpansionTile(
            title: Text(entrada.key),
            children: entrada.value.map((grafica) {
              return ListTile(
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: Text(grafica.nombre),
                selected: _graficaSeleccionada == grafica,
                onTap: () => _alSeleccionarGrafica(grafica),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_graficaSeleccionada?.nombre ?? 'App de Gráficas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Gráficas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _construirListaPorCategoria('Básicas (40)', FabricaGraficas.graficasBasicas),
            _construirListaPorCategoria('Avanzadas (25)', FabricaGraficas.graficasAvanzadas),
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
