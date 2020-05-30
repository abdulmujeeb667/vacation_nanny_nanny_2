import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FireStoreDatabase {
  final String uid;
  FireStoreDatabase({this.uid});
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');
  final CollectionReference requestsCollection =
      Firestore.instance.collection('requests');
  final _firestore = Firestore.instance;

  Future updateUserData({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String address,
    @required String phone,
    @required int weightCapacity,
    @required bool travelCapacity,
    @required bool specialCapacity,
    String paypal,
    String last6SSN,
    String locationName,
    var latitude,
    var longitude,
    @required String profileImageUrl,
    @required String idImageUrl,
  }) async {
    await usersCollection.document(uid).setData({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "address": address,
      "phone": phone,
      "weightCapacity": weightCapacity,
      "travelCapacity": travelCapacity,
      "specialCapacity": specialCapacity,
      "paypal": paypal,
      "last6SSN": last6SSN,
      "locationName": locationName,
      "latitude": latitude,
      "longitude": longitude,
      "profileImageUrl": profileImageUrl,
      "idImageUrl": idImageUrl,
    });
  }

  Future addCalendarData({
    @required String day,
    @required String startingHour,
    @required String endingHour,
    @required bool availability,
  }) async {
    await usersCollection.document(uid).updateData({
      day: availability ? "$startingHour to $endingHour" : null,
    });
  }

  Future fetchUserData() async {
    final users = await _firestore.collection('users').getDocuments();
    for (var user in users.documents) {
      if (user.documentID == uid) {
        return user.data;
      }
    }
  }

  Future<List> fetchRequestsData({@required String locationName}) async {
    final requests = await _firestore.collection('requests').getDocuments();
    List requestsList = [];
    for (var request in requests.documents) {
      if (request.data["locationName"] == locationName) {
        requestsList.add(request);
      }
    }
    return requestsList;
  }

  Future fetchSingleRequestData({@required String requestID}) async {
    final requests = await _firestore.collection('requests').getDocuments();
    for (var request in requests.documents) {
      if (request.documentID == requestID) {
        return request;
      }
    }
  }

  Future<LatLng> fetchFamilyCordinates({@required String requestID}) async {
    var currentDoc = await requestsCollection.document(requestID).get();
    return LatLng(currentDoc['status']['family']['latitude'],
        currentDoc['status']['family']['longitude']);
  }

  Future placeBid({@required var requestID, @required int bidAmount}) async {
    var bidsList;
    final requests = await _firestore.collection('requests').getDocuments();
    for (var request in requests.documents) {
      if (request.documentID == requestID) {
        bidsList = request['bids'];
        bidsList.add({"nanny": await fetchUserData(), "amount": bidAmount});
      }
    }
    await requestsCollection.document(requestID).updateData({
      "bids": bidsList,
    });
  }

  // Future<bool> bidPresenceCheck({@required requestID}) async {
  //   final requests = await _firestore.collection('requests').getDocuments();
  //   for (var request in requests.documents) {
  //     if (request.documentID == requestID) {
  //       for (var listItem in request['bids']) {
  //         if (listItem['nanny'] == uid) {
  //           return true;
  //         }
  //       }
  //     }
  //   }
  //   return false;
  // }
}
