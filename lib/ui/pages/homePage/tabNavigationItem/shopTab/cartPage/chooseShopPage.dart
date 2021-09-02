import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/helper/services/local_storage_service.dart';

class ChooseShopPage extends StatefulWidget {
  const ChooseShopPage({Key? key}) : super(key: key);

  @override
  _ChooseShopPageState createState() => _ChooseShopPageState();
}

class _ChooseShopPageState extends State<ChooseShopPage> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(55.354968, 86.087314);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> _markers = <Marker>[
      Marker(
        markerId: MarkerId('Кузнецкий, 33'),
        position: LatLng(55.355787, 86.064506),
        onTap: () {
          _settingModalBottomSheet(context, 'Кузнецкий, 33', '');
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Выбрать магазин', style: TextStyle(color: LightColor.text)),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: Set<Marker>.of(_markers),
      ),
    );
  }

  void _settingModalBottomSheet(context, address, workingHors) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Music'),
                  onTap: () => {}),
              new ListTile(
                leading: new Icon(Icons.videocam),
                title: new Text('Video'),
                onTap: () => {},
              ),
            ],
          ),
        );
      },
    );
  }
}
