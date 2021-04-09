import 'package:colomer_dental/src/models/clinicasModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:map_launcher/map_launcher.dart' as map;
import 'package:url_launcher/url_launcher.dart';

class TarjetasClinicas {
  Widget tarjetasClinicas(Clinicas _clinica) {
    print(_clinica.nombre);
    print(_clinica.direccion);
    print(_clinica.tel);

    final telefono = "tel:+34" + _clinica.tel;
    final container = Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 3,
              offset: Offset(0, 0))
        ], color: Colors.white),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        alignment: Alignment.topLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            _clinica.nombre,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
            child: Text(_clinica.direccion),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () async {
              final coord = map.Coords(double.tryParse(_clinica.latitud),
                  double.tryParse(_clinica.longitud));
              final availableMaps = await map.MapLauncher.installedMaps;
              print(
                  availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

              await availableMaps.first.showMarker(
                coords: coord,
                title: _clinica.nombre,
              );
              if (await map.MapLauncher.isMapAvailable(map.MapType.google)) {
                await map.MapLauncher.showMarker(
                  mapType: map.MapType.google,
                  coords: coord,
                  title: _clinica.nombre,
                  description: _clinica.direccion,
                );
              } else if (await map.MapLauncher.isMapAvailable(
                  map.MapType.apple)) {
                await map.MapLauncher.showMarker(
                  mapType: map.MapType.apple,
                  coords: coord,
                  title: _clinica.nombre,
                  description: _clinica.direccion,
                );
              }
            },
            child: Text(
              'Cómo llegar',
              style: TextStyle(color: Colors.blue[800]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              if (await canLaunch(telefono)) {
                await launch(telefono);
              } else {
                throw 'Could not launch $telefono';
              }
            },
            child: Text(
              _clinica.tel,
              style: TextStyle(color: Colors.blue[800]),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 300,
            width: double.infinity,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(double.tryParse(_clinica.latitud),
                    double.tryParse(_clinica.longitud)),
                zoom: 16.0,
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tiles.mapbox.com/v4/"
                      "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1Ijoic2VyZ2lvc2FudDAyIiwiYSI6ImNrZWNwcXp4NzBsNWIyenBndmZ6MndsaGcifQ.-Ra3lPSZH2VOmUCCPe-IjA',
                    'id': 'mapbox.streets',
                  },
                ),
                MarkerLayerOptions(markers: [
                  Marker(
                      point: LatLng(double.tryParse(_clinica.latitud),
                          double.tryParse(_clinica.longitud)),
                      builder: (context) {
                        return Icon(Icons.location_on,
                            color: Colors.red, size: 35);
                      })
                ]),
              ],
            ),
          ),
        ]));
    return container;
  }
}
