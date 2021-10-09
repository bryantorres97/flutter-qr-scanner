import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/providers/db_provider.dart';
import 'package:qr_scanner/providers/scan_provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () {
        _tempData();
        // _leerQR(context);
      },
      child: Icon(Icons.filter_center_focus),
    );
  }

  _tempData() {
    DBProvider.db.nuevoScan(new ScanModel(valor: 'https://www.facebook.com'));
  }

  _leerQR(BuildContext context) async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      openAppSettings();
    }

    if (await Permission.camera.request().isGranted) {
      // Permiso concedido
      print('Permiso concedido');
      String? cameraScanResult = await scanner.scan();
      if (cameraScanResult != null) {
        final scansProvider =
            Provider.of<ScansProvider>(context, listen: false);
        scansProvider.crearScan(cameraScanResult);
      }
    }
  }
}
