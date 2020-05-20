import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
// import 'package:http/http.dart' as http;
// import 'package:geopoint/geopoint.dart';
// import 'package:geopoint_location/geopoint_location.dart';
import 'dart:convert';

class MyLocationClass {
  var longitude;
  var latitude;
  var locationName;

  Future<void> getCurrentLocation() async {
    try {
      print('waiting for position');
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('done waiting');
      latitude = position.latitude;
      longitude = position.longitude;
      print('position called$latitude and $longitude');
      List<Placemark> placemark =
          await Geolocator().placemarkFromCoordinates(latitude, longitude);
      print(
          'placemark: ${placemark[0].locality}, ${placemark[0].administrativeArea}, ${placemark[0].country}');
      locationName =
          '${placemark[0].locality}, ${placemark[0].administrativeArea}, ${placemark[0].country}';

      //   // http.Response response = await http.get(
      //   //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAzSRF_lF7YziQTh5GQ6KbrCcnjuo4n99Q');
      //   // if (response.statusCode == 200) {
      //   //   String data = response.body;
      //   //   cityData = jsonDecode(data);
      //   // } else {
      //   //   print('Error: ');
      //   //   print(response.statusCode);
      //   // }
    } catch (e) {
      print(e);
      print('error called');
      print(e);
    }
  }
}
