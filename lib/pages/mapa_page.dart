import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scanner/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapaType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition placeCoords =
        CameraPosition(target: scan.getLatLng(), zoom: 18, tilt: 50);

    // Markers
    Set<Marker> markers = new Set<Marker>();
    markers.add(
        Marker(markerId: MarkerId('geo-location'), position: scan.getLatLng()));
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller
                    .animateCamera(CameraUpdate.newCameraPosition(placeCoords));
              },
              icon: Icon(Icons.my_location))
        ],
      ),
      body: GoogleMap(
        mapType: mapaType,
        markers: markers,
        initialCameraPosition: placeCoords,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          setState(() {
            (mapaType == MapType.normal)
                ? mapaType = MapType.satellite
                : mapaType = MapType.normal;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
