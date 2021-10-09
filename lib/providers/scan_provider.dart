import 'package:flutter/cupertino.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/providers/db_provider.dart';

class ScansProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  crearScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = id;
    if (nuevoScan.tipo == tipoSeleccionado) {
      scans.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarScans() async {
    final scans = await DBProvider.db.obtenerScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.obtenerScansPorTipo(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarScans() async {
    await DBProvider.db.borrarScans();
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.borrarScanPorId(id);
    cargarScansPorTipo(tipoSeleccionado);
  }
}
