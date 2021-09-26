import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: _leerQR,
      child: Icon(Icons.filter_center_focus),
    );
  }

  void _leerQR() async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      openAppSettings();
    }

    if (await Permission.camera.request().isGranted) {
      // Permiso concedido
      print('Permiso concedido');
      String? cameraScanResult = await scanner.scan();
      if (cameraScanResult != null) {
        print(cameraScanResult);
      }
    }
  }
}
