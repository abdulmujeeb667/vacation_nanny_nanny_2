import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:vaccation_nanny/map_functions.dart';
import 'package:vaccation_nanny/fire_store_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  static const id = "mapscreen";
  final requestData;
  MapScreen({@required this.requestData});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Firestore _fireStore = Firestore.instance;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  LatLng homeLocalData = LatLng(33.5634786, 73.1273941);
  LatLng familyLocalData;
  double initialLat;
  double initialLong;
  PolylinePoints polylinePoints = PolylinePoints();
  List<PointLatLng> result;
  List<LatLng> resultLatLng = [];
  Marker marker;
  Polyline polyline;
  Marker familyMarker;
  Polyline familyPolyline;
  Circle circle;
  GoogleMapController _controller;
  bool ready = false;
  Uint8List nannyImageData;
  Uint8List familyImageData;
  // static final CameraPosition initialLocation = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

//getting nanny location inside init
  @override
  void initState() {
    super.initState();
    beginOperation();
  }

//function to get nanny locaation from firestore document
  beginOperation() async {
    // familyLatLng = await FireStoreDatabase()
    //     .fetchFamilyCordinates(requestID: widget.requestData.documentID);
    // print(familyLatLng);
    // familyMarker = Marker(
    //   markerId: MarkerId("family"),
    //   position: familyLatLng,
    //   // rotation: newLocalData.heading,
    //   draggable: false,
    //   zIndex: 2,
    //   flat: true,
    //   anchor: Offset(0.5, 0.5),
    //   icon: BitmapDescriptor.fromBytes(await MapFunctions()
    //       .getMarker(context: context, markerName: "family")),
    // );

    // setState(() {
    //   familyMarker = familyMarker;
    // });
    getCurrentLocation();
  }
//marker maker

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("accuracy"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void updateSecondaryMarkerAndCircle(
      LatLng familyLatLng, double familyHeading) async {
    familyMarker = Marker(
      markerId: MarkerId("family"),
      position: familyLatLng,
      rotation: familyHeading,
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: Offset(0.5, 0.5),
      icon: BitmapDescriptor.fromBytes(familyImageData),
    );
  }

  Future getCurrentLocation() async {
    try {
      nannyImageData =
          await MapFunctions().getMarker(context: context, markerName: "nanny");
      familyImageData = await MapFunctions()
          .getMarker(context: context, markerName: "family");
      var location = await _locationTracker.getLocation();
      initialLat = location.latitude;
      initialLong = location.longitude;

      updateMarkerAndCircle(location, nannyImageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) async {
        if (_controller != null) {
          homeLocalData = LatLng(newLocalData.latitude, newLocalData.longitude);
          updateMarkerAndCircle(newLocalData, nannyImageData);
        }
        print('document of interest ${widget.requestData.documentID}');
        try {
          await _fireStore
              .collection('requests')
              .document(widget.requestData.documentID)
              .collection('liveLocation')
              .document('c0FANelqlsFtLHEvCy3J')
              .updateData({
            'nannyLatitude': newLocalData.latitude,
            'nannyLongitude': newLocalData.longitude,
            'nannyHeading': newLocalData.heading
          });
        } catch (e) {
          print('ladies and gentle men we got it $e');
          await _fireStore
              .collection('requests')
              .document(widget.requestData.documentID)
              .collection('liveLocation')
              .document('c0FANelqlsFtLHEvCy3J')
              .setData({
            'nannyLatitude': newLocalData.latitude,
            'nannyLongitude': newLocalData.longitude,
            'nannyHeading': newLocalData.heading
          });
        }
      });

      var firstTimeTracker = 0;

      await for (var snapShots in _fireStore
          .collection('requests')
          .document(widget.requestData.documentID)
          .collection('liveLocation')
          .snapshots()) {
        for (var snapShot in snapShots.documentChanges) {
          print('what i received from firestore ${snapShot.document.data}');
          print(
              'what i received from firestore ${snapShot.document['familyLatitude'] ?? widget.requestData['status']['family']['latitude']}');
          print(
              'what i received from firestore ${snapShot.document['familyLongitude'] ?? widget.requestData['status']['family']['longitude']}');
          print(
              'what i received from firestore ${snapShot.document['familyHeading' ?? 'notpresent']}');
          var familyLatLng = LatLng(
              snapShot.document['familyLatitude'] ??
                  widget.requestData['status']['family']['latitude'],
              snapShot.document['familyLongitude'] ??
                  widget.requestData['status']['family']['longitude']);
          var familyHeading = snapShot.document['familyHeading'] ?? 0;
          familyLocalData = familyLatLng;
          updateSecondaryMarkerAndCircle(
              familyLatLng, familyHeading.toDouble());
          result = await polylinePoints.getRouteBetweenCoordinates(
              'AIzaSyAzSRF_lF7YziQTh5GQ6KbrCcnjuo4n99Q',
              33.5694903,
              73.1273627,
              33.5634734,
              73.1298453);
          // for (var singleResult in result) {
          //   // print("single latitude ${singleResult.latitude}");
          //   resultLatLng
          //       .add(LatLng(singleResult.latitude, singleResult.longitude));
          // }
          // print('result is $resultLatLng');
          try {
            var url =
                'https://maps.googleapis.com/maps/api/directions/json?origin=${snapShot.document['nannyLatitude']},${snapShot.document['nannyLongitude']}&destination=${familyLatLng.latitude},${familyLatLng.longitude}&mode=driving&key=AIzaSyAzSRF_lF7YziQTh5GQ6KbrCcnjuo4n99Q';
            print('url is $url');
            var response = await http.get(url);
// print('Response status: ${response.statusCode}');
            if (response.statusCode == 200) {
              String data = response.body;
              var decodedData = jsonDecode(data);
              print(decodedData['routes'][0]['legs'][0]['steps'][0]);
              List steps = decodedData['routes'][0]['legs'][0]['steps'];
              resultLatLng = [];
              for (int step = 0; step < steps.length; step++) {
                // resultLatLng.add(LatLng(steps[step]['end_location']['lat'],
                //     steps[step]['end_location']['lng']));
                resultLatLng.add(LatLng(steps[step]['start_location']['lat'],
                    steps[step]['start_location']['lng']));
              }
            }
          } catch (e) {
            print(e);
          }

          if (firstTimeTracker == 0) {
            setState(() {
              ready = true;
            });

            // if (_controller != null) {
            //   _controller.animateCamera(CameraUpdate.newCameraPosition(
            //       new CameraPosition(
            //           bearing: 192.8334901395799,
            //           target: LatLng(location.latitude, location.longitude),
            //           tilt: 0,
            //           zoom: 18.00)));
            // }
            firstTimeTracker = 1;
          }
        }
      }
      // _nannyLocationSubscription =
      //     _locationTracker.onLocationChanged.listen((newLocalData) {
      //   if (_controller != null) {
      //     _controller.animateCamera(CameraUpdate.newCameraPosition(
      //         new CameraPosition(
      //             bearing: 192.8334901395799,
      //             target: LatLng(newLocalData.latitude, newLocalData.longitude),
      //             tilt: 0,
      //             zoom: 18.00)));
      //     updateMarkerAndCircle(newLocalData, familyImageData);
      //   }
      // });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  Widget makeGoogleMap() {
    return !ready
        ? Center(child: Text('loading..'))
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(initialLat, initialLong),
              zoom: 14.4746,
            ),
            markers: Set.of((familyMarker != null && marker != null)
                ? [familyMarker, marker]
                : []),
            circles: Set.of((circle != null) ? [circle] : []),
            polylines: Set.of((familyMarker != null && marker != null)
                ? [
                    Polyline(
                        polylineId: PolylineId("polyline"),
                        points: resultLatLng,
                        // points: [
                        //   LatLng(33.563562, 73.1274364),
                        //   LatLng(33.563585, 73.1275335),
                        //   LatLng(33.5635906, 73.14986569999999),
                        //   LatLng(33.5634697, 73.14984849999999),
                        // ],
                        color: Color(0XFFfd992a),
                        width: 5,
                        jointType: JointType.round)
                  ]
                : []),
            // polygons: Set.of([
            //   Polygon(
            //       polygonId: PolygonId('polygon'),
            //       points: [homeLocalData, familyLocalData],
            //       geodesic: true)
            // ]),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          );
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          makeGoogleMap(),
        ],
      ),
    );
  }
}
