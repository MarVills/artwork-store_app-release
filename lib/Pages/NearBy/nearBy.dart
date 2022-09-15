import 'package:artwork_store/Components/resusableWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'directionsModel.dart';
import 'directionsRepository.dart';
import 'dart:math';

class NearByPage extends StatefulWidget {
  final currentLocation;
  NearByPage({Key? key, required this.currentLocation}) : super(key: key);

  @override
  _NearByPageState createState() => _NearByPageState();
}

class _NearByPageState extends State<NearByPage> {
  late GoogleMapController mapController;
  final setRadiusController = TextEditingController();
  final GlobalKey<FormState> _controllFormKey = GlobalKey<FormState>();
  bool moreControll = false;
  Location _location = Location();
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  List<Marker> _markers = [];
  double locationRadius = 1000.0;
  // LatLng _cl = LatLng(0.5937, 0.9629);
  late LatLng _cl = widget.currentLocation;

  late List<Marker> sellerLocations = [
    Marker(
      markerId: MarkerId("loc5"),
      position: LatLng(8.4769, 124.6616),
      infoWindow: InfoWindow(
        title: "Melinda Reyes, (${distanceInKilomters(LatLng(8.4769, 124.6616))} km)",
        snippet: "Lapasan, Cagayan deOro City",
      ),
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: MarkerId("loc4"),
      position: LatLng(8.4769, 124.6506),
      infoWindow: InfoWindow(
        title: "Reynald Valdimir (${distanceInKilomters(LatLng(8.4769, 124.6506))} km)",
        snippet: "Cogon, Cagayan de Oro City ",
      ),
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: MarkerId("loc2"),
      position: LatLng(8.4968, 124.6394),
      infoWindow: InfoWindow(
        title: "Robert Relley (${distanceInKilomters(LatLng(8.4968, 124.6394))} km)",
        snippet: "Kauswagan, Cagayan de Oro City",
      ),
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: MarkerId("loc1"),
      position: LatLng(8.4886, 124.6220),
      infoWindow: InfoWindow(
        title: "Reynald Hanson (${distanceInKilomters(LatLng(8.4886, 124.6220))} km)",
        snippet: "Patag, Cagayan de Oro City ",
      ),
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: MarkerId("loc3"),
      position: LatLng(8.4676, 124.6221),
      infoWindow: InfoWindow(
        title: "Johanna Medley (${distanceInKilomters(LatLng(8.4676, 124.6221))} km)",
        snippet: "Carmen, Cagayan de Oro City ",
      ),

      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
  ];

  var _initialCameraPosition = (CameraPosition(
    target: LatLng(8.4542, 124.6319),
    zoom: 13.5,
  ));

  late List<Marker> _defaultMarkers = [
    if (_origin != null) _origin!,
    if (_destination != null) _destination!,
  ];

  _getCurrentLocation() async {
    Location location = Location();
    LocationData _currentPosition;
    // LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
    _currentPosition = await location.getLocation();
    var _center = LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
    setState(() {
      _cl = _center;
    });
  }

  _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(_cl.latitude, _cl.longitude)),
        ),
      );
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    // var p = 0.017453292519943295;
    // var a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    // return 12742 * asin(sqrt(a));
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    double returnValue = 12742 * asin(sqrt(a));
    return double.parse(returnValue.toStringAsFixed(2));
  }

  distanceInKilomters(location) {
    var distance = calculateDistance(_cl.latitude, _cl.longitude, location.latitude, location.longitude);
    return distance.toString();
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: MarkerId("origin"),
          infoWindow: InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _destination = null;
        _info = null;
        _markers.add(_origin!);
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: MarkerId("destination"),
          infoWindow: InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
        _markers.add(_destination!);
      });

      final directions = (await DirectionsRepository().getDirections(origin: _origin!.position, destination: pos));
      print("directions: $directions");
      setState(() => _info = directions);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _markers.addAll(sellerLocations);
    _markers.addAll(_defaultMarkers);
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Set<Circle> circles = Set.from(
      [
        Circle(
          circleId: CircleId('currentCircle'),
          center: LatLng(_cl.latitude, _cl.longitude),
          radius: locationRadius,
          fillColor: Colors.blue.shade200.withOpacity(0.5),
          strokeColor: Colors.blue.shade500.withOpacity(0.9),
          strokeWidth: 1,
        ),
      ],
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.green[50],
          titleSpacing: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Nearby",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            if (_origin != null)
              TextButton(
                onPressed: () => mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _origin!.position,
                      zoom: 14.5,
                      tilt: 50.0,
                    ),
                  ),
                ),
                style: TextButton.styleFrom(primary: Colors.green, textStyle: TextStyle(fontWeight: FontWeight.w600)),
                child: Text("ORIGIN"),
              ),
            if (_destination != null)
              TextButton(
                onPressed: () => mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _destination!.position,
                      zoom: 14.5,
                      tilt: 50.0,
                    ),
                  ),
                ),
                style: TextButton.styleFrom(primary: Colors.blue, textStyle: TextStyle(fontWeight: FontWeight.w600)),
                child: Text("DEST"),
              ),
            GestureDetector(
              onTap: () {
                setState(() {
                  moreControll = !moreControll;
                });
              },
              child: moreVertIcon(),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
                mapController.showMarkerInfoWindow(MarkerId("My Current Position"));
              },
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: _initialCameraPosition,
              onCameraMove: null,
              circles: circles,
              markers: Set<Marker>.of(_markers),
              // {
              //   if (_origin != null) _origin!,
              //   if (_destination != null) _destination!,
              //   for (var mark in markers) mark,
              // },
              polylines: {
                if (_info != null)
                  Polyline(
                    polylineId: PolylineId('overview_polyline'),
                    color: Colors.red,
                    width: 5,
                    points: _info!.polylinePoints!.map((e) => LatLng(e.latitude, e.longitude)).toList(),
                  ),
              },
              onLongPress: _addMarker,
            ),
            if (_info != null)
              Positioned(
                top: 40.0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Text(
                    "${_info!.totalDistance}, ${_info!.totalDuration}",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            if (moreControll)
              Positioned(
                top: 5.0,
                child: Container(
                  width: size.width * 0.5,
                  // padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Form(
                    key: _controllFormKey,
                    child: TextFormField(
                      controller: setRadiusController,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Set radius",
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintText: 'Radius',
                      ),
                      onChanged: (value) {
                        try {
                          var val = double.parse(value);
                          setState(() {
                            locationRadius = val;
                          });
                        } catch (e) {
                          print("Error: Invalid radius value: $e");
                        }
                      },
                      validator: (value) {
                        try {
                          double.parse(value!);
                          return null;
                        } catch (e) {
                          print("Error: Invalid radius value: $e");
                          return "Please enter valid radius value.";
                        }
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          onPressed: () {
            mapController.animateCamera(
              _info != null
                  ? CameraUpdate.newLatLngBounds(_info!.bounds!, 100.0)
                  : CameraUpdate.newCameraPosition(
                      CameraPosition(target: LatLng(_cl.latitude, _cl.longitude), zoom: 15),
                    ),
            );
          },
          child: Icon(Icons.center_focus_strong),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
