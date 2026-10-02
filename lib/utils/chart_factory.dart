import '../data/chart_data.dart';
import 'basic_chart_factory.dart';
import 'advanced_chart_factory.dart';
import 'dchart_basic_chart_factory.dart';
import 'dchart_advanced_chart_factory.dart';
import 'graphic_basic_chart_factory.dart';
import 'graphic_advanced_chart_factory.dart';
import 'community_basic_chart_factory.dart';
import 'community_advanced_chart_factory.dart';

class FabricaGraficas {
  static final List<DefinicionGrafica> graficasBasicas = [
      ...FabricaGraficasBasicas.generarGraficasBasicas(),
      ...FabricaDChartBasica.generarGraficasBasicas(),
      ...FabricaGraphicBasica.generarGraficasBasicas(),
      ...FabricaCommunityBasica.generarGraficasBasicas(),
  ];

  static final List<DefinicionGrafica> graficasAvanzadas = [
      ...FabricaGraficasAvanzadas.generarGraficasAvanzadas(),
      ...FabricaDChartAvanzada.generarGraficasAvanzadas(),
      ...FabricaGraphicAvanzada.generarGraficasAvanzadas(),
      ...FabricaCommunityAvanzada.generarGraficasAvanzadas(),
  ];
}
