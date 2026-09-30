import '../data/chart_data.dart';
import 'basic_chart_factory.dart';
import 'advanced_chart_factory.dart';

class FabricaGraficas {
  static final List<DefinicionGrafica> graficasBasicas = 
      FabricaGraficasBasicas.generarGraficasBasicas();

  static final List<DefinicionGrafica> graficasAvanzadas = 
      FabricaGraficasAvanzadas.generarGraficasAvanzadas();
}
