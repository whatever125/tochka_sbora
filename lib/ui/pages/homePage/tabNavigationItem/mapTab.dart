import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTab extends StatefulWidget {
  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(55.354968, 86.087314);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  //TODO загрузка маркеров с сервера
  List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('Кузнецкий 33'),
      position: LatLng(55.355787, 86.064506),
      infoWindow: InfoWindow(
        title: 'Кузнецкий 33',
        snippet: 'Круглосуточно',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
      markers: Set<Marker>.of(_markers),
    );
  }
}
