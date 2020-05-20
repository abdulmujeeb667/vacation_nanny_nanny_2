import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MapFunctions {
  Future<Uint8List> getMarker(
      {@required BuildContext context, @required String markerName}) async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("images/${markerName}_icon.png");
    return byteData.buffer.asUint8List();
  }
}
