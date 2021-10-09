import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_provider.dart';

class ScanTiles extends StatelessWidget {
  final String tipo = '';
  const ScanTiles({required tipo});

  @override
  Widget build(BuildContext context) {
    final scansProvider = Provider.of<ScansProvider>(context);
    final scans = scansProvider.scans;
    final IconData iconType = (scansProvider.tipoSeleccionado == 'geo')
        ? Icons.map
        : Icons.network_wifi;
    return Container(
        padding: EdgeInsets.only(bottom: 30),
        child: ListView.builder(
          itemCount: scans.length,
          itemBuilder: (_, i) => ListTile(
            leading: Icon(
              iconType,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(scans[i].valor),
            subtitle: Text('ID: ${scans[i].id}'),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.green,
            ),
            onTap: () {
              print('Seleccionando');
            },
          ),
        ));
  }
}
