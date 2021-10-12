import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    if (await canLaunch(scan.valor)) {
      await launch(
        scan.valor,
        forceSafariVC: false,
        forceWebView: false,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      print('Could not launch ${scan.valor}');
    }
  }

  if (scan.tipo == 'geo') {
    print('geo');
  }
}

Future<void> launchInWebViewWithJavaScript(
    BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor,
          forceSafariVC: true, forceWebView: true, enableJavaScript: true
          // headers: <String, String>{'my_header_key': 'my_header_value'},
          );
    } else {
      print('Could not launch ${scan.valor}');
    }
  }

  if (scan.tipo == 'geo') {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
