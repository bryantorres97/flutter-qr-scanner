import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/direcciones_page.dart';
import 'package:qr_scanner/pages/mapas_page.dart';
import 'package:qr_scanner/providers/db_provider.dart';
import 'package:qr_scanner/providers/scan_provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';
import 'package:qr_scanner/widgets/custom_navigator_bar.dart';
import 'package:qr_scanner/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scansProvider = Provider.of<ScansProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                eliminarRegistros(context, scansProvider);
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  eliminarRegistros(BuildContext context, ScansProvider scansProvider) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Eliminar registros'),
              content: Text('¿Está seguro de eliminar los registros?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancelar'),
                    child: Text('Cancelar')),
                TextButton(
                    onPressed: () {
                      scansProvider.borrarScans();
                      Navigator.pop(context, 'Eliminar');
                    },
                    child: Text('Eliminar'))
              ],
            ));
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    DBProvider.db.database;
    // var nuevoScan = new ScanModel(valor: 'https://www.twitter.com');
    // nuevoScan.id = 2;
    // DBProvider.db.actualizarScanPorId(nuevoScan).then((value) => print(value));
    // DBProvider.db.nuevoScan(new ScanModel(valor: 'https://www.youtube.com'));
    // DBProvider.db.obtenerScans().then((scans) {
    //   for (var scan in scans) {
    //     print(scan.toMap());
    //   }
    // });
    final scansProvider = Provider.of<ScansProvider>(context, listen: false);
    switch (currentIndex) {
      case 0:
        scansProvider.cargarScansPorTipo('geo');
        return MapasPage();

      case 1:
        scansProvider.cargarScansPorTipo('http');
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }
}
