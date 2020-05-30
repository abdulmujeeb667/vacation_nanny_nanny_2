import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:vaccation_nanny/fire_store_database.dart';
import 'package:vaccation_nanny/ui_modules/rounded_rectangle_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccation_nanny/custom_functions.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String id = 'updateprofilescreen';
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String firstName = '';
  String lastName = '';
  String address = '';
  String phone = '';
  double weightCapacity = 0;
  bool travelCapacity = false;
  bool specialCapacity = false;
  String paypal = '';
  String last6SSN = '';
  String locationName = '';
  var latitude;
  var longitude;
  final _auth = FirebaseAuth.instance;
  bool spinner = true;
  dynamic _profileimage;
  dynamic _idImage;
  dynamic profileimageUrl =
      'https://firebasestorage.googleapis.com/v0/b/vacation-nanny.appspot.com/o/loadinganimation.gif?alt=media&token=b8299b5d-8703-47d5-bcfb-5476c3d8b2e8';
  dynamic idImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/vacation-nanny.appspot.com/o/loadinganimation.gif?alt=media&token=b8299b5d-8703-47d5-bcfb-5476c3d8b2e8';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    final loggedInUser = await _auth.currentUser();
    final userData =
        await FireStoreDatabase(uid: loggedInUser.uid).fetchUserData();
    setState(() {
      firstName = userData['firstName'];
      lastName = userData['lastName'];
      address = userData['address'];
      phone = userData['phone'];
      weightCapacity = userData['weightCapacity'].toDouble();
      travelCapacity = userData['travelCapacity'];
      specialCapacity = userData['specialCapacity'];
      paypal = userData['paypal'];
      last6SSN = userData['last6SSN'];
      locationName = userData['locationName'];
      latitude = userData['latitude'];
      longitude = userData['longitude'];
      profileimageUrl = userData['profileImageUrl'];
      idImageUrl = userData['idImageUrl'];
      spinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future getProfileImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _profileimage = image;
        print('Image Path $_profileimage');
      });
    }

    Future getIdImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _idImage = image;
        print('Image Path $_idImage');
      });
    }

    Future<String> uploadPic(sentImage) async {
      String fileName = basename(sentImage.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(sentImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      print('here we go');
      var imageUrl = await firebaseStorageRef.getDownloadURL();
      print(imageUrl);
      print(taskSnapshot.error);
      if (taskSnapshot.error != null) {
        throw "An error occured while uploading image";
      }
      return imageUrl;
    }

    showASnackBar(BuildContext context, String message) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Update profile'),
        backgroundColor: Color(0XFFfd992a),
        automaticallyImplyLeading: false,
      ),
      body: Builder(
        builder: (context) => ModalProgressHUD(
          inAsyncCall: spinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Color(0XFFfd992a),
                      child: ClipOval(
                        child: SizedBox(
                          width: 130.0,
                          height: 130.0,
                          child: (_profileimage != null)
                              ? Image.file(
                                  _profileimage,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  profileimageUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.camera_alt,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Choose Image',
                              style: TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        getProfileImage();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller:
                                  TextEditingController(text: firstName),
                              style: TextStyle(color: Colors.black),
                              onChanged: (value) {
                                firstName = value;
                              },
                              decoration: kInputDecoration.copyWith(
                                hintText: 'First Name',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(text: lastName),
                              style: TextStyle(color: Colors.black),
                              onChanged: (value) {
                                lastName = value;
                              },
                              decoration: kInputDecoration.copyWith(
                                hintText: 'Last Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextField(
                        controller: TextEditingController(text: phone),
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter Your contact number',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextField(
                        controller: TextEditingController(text: address),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          address = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter Your address',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: TextEditingController(text: paypal),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          paypal = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter Your paypal email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(text: last6SSN),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          last6SSN = value;
                          print(last6SSN);
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter last 6 of your SSN',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                text: locationName,
                              ),
                              style: TextStyle(color: Colors.black),
                              onChanged: (value) {},
                              decoration: kInputDecoration.copyWith(
                                hintText: 'Press the icon for location',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.mapMarkerAlt),
                            onPressed: () async {
                              MyLocationClass newCurrentLocation =
                                  MyLocationClass();
                              await newCurrentLocation.getCurrentLocation();
                              latitude = newCurrentLocation.latitude;
                              longitude = newCurrentLocation.longitude;
                              setState(() {
                                locationName = newCurrentLocation.locationName;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    HeadingAndCustomWidgetBox(
                      heading: "Capacity to lift weight:",
                      passedCustomWidget: Slider(
                        value: weightCapacity ?? 0,
                        min: 0,
                        max: 200,
                        divisions: 201,
                        label: (weightCapacity ?? 0.0).toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            weightCapacity = value;
                          });
                        },
                      ),
                      passedCustomText:
                          (weightCapacity ?? 0.0).toInt().toString() + " lbs",
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: travelCapacity ?? false,
                            onChanged: (value) {
                              setState(() {
                                travelCapacity = value;
                              });
                            },
                            activeColor: Color(0XFFfd992a),
                          ),
                          Text('Can travel with family.'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: specialCapacity ?? false,
                            onChanged: (value) {
                              setState(() {
                                specialCapacity = value;
                              });
                            },
                            activeColor: Color(0XFFfd992a),
                          ),
                          Text('Can take care of chilren with special needs.'),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                getIdImage();
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _idImage != null
                                          ? FileImage(_idImage)
                                          : NetworkImage(idImageUrl)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 52, 0, 0),
                              child: Text(
                                  'Upload image of\n driver\'s license, I.D. \nor Passport'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 16),
                      child: RoundedNavigationButton(
                        title: 'Update profile',
                        color: Color(0XFFfd992a),
                        onPressed: () async {
                          if (firstName == null ||
                              lastName == null ||
                              firstName.length == 0 ||
                              lastName.length == 0) {
                            showASnackBar(context,
                                'Please provide your first and last name');
                          } else if (address == null || address.length == 0) {
                            showASnackBar(
                                context, 'Please provide your address');
                          } else {
                            try {
                              setState(() {
                                spinner = true;
                              });
                              if (_profileimage != null) {
                                profileimageUrl =
                                    await uploadPic(_profileimage);
                              }
                              if (_idImage != null) {
                                idImageUrl = await uploadPic(_idImage);
                              }
                              FirebaseUser loggedInUser =
                                  await _auth.currentUser();
                              await FireStoreDatabase(uid: loggedInUser.uid)
                                  .updateUserData(
                                      firstName: firstName,
                                      lastName: lastName,
                                      email: loggedInUser.email,
                                      address: address,
                                      phone: phone,
                                      weightCapacity: weightCapacity.toInt(),
                                      travelCapacity: travelCapacity,
                                      specialCapacity: specialCapacity,
                                      paypal: paypal,
                                      last6SSN: last6SSN,
                                      locationName: locationName,
                                      latitude: latitude,
                                      longitude: longitude,
                                      profileImageUrl: profileimageUrl,
                                      idImageUrl: idImageUrl);
                              Navigator.pop(context);
                              setState(() {
                                spinner = false;
                              });
                            } catch (e) {
                              setState(() {
                                spinner = false;
                              });
                              showASnackBar(context,
                                  e.runtimeType == String ? e : e.message);
                              print(e);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeadingAndCustomWidgetBox extends StatelessWidget {
  final String heading;
  final Widget passedCustomWidget;
  final String passedCustomText;
  const HeadingAndCustomWidgetBox(
      {@required this.heading, this.passedCustomWidget, this.passedCustomText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(heading),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(child: passedCustomWidget),
              Text(passedCustomText),
            ],
          ),
        ],
      ),
    );
  }
}

// credits for the circular flowers <a href="https://www.vecteezy.com/free-vector/pattern">Pattern Vectors by Vecteezy</a>
