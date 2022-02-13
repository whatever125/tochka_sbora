import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:metrica_plugin/metrica_plugin.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';

class MapTab extends StatefulWidget {
  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final _database = FirebaseDatabase(
    app: Firebase.apps.first,
    databaseURL:
        'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference();

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(55.354968, 86.087314);

  @override
  void initState() {
    super.initState();
    MetricaPlugin.reportEvent('Пользователь открыл карту');
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  List<Marker> _markers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _database.child('shops/').onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _markers = _reformatData(
              List<dynamic>.from((snapshot.data as Event).snapshot.value));
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: Set<Marker>.of(_markers),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(LightColor.accent),
            ),
          );
        }
      },
    );
  }

  List<Marker> _reformatData(_data) {
    List<Marker> _lis = <Marker>[];
    for (var dic in _data) {
      _lis.add(
        Marker(
          markerId: MarkerId(dic['address']),
          position: LatLng(dic['lat'], dic['lon']),
          infoWindow: InfoWindow(
            title: dic['address'],
            snippet: dic['workingHours'],
          ),
        ),
      );
    }
    return _lis;
  }
}
