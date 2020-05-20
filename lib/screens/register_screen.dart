import 'package:flutter/material.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccation_nanny/fire_store_database.dart';
import 'package:vaccation_nanny/screens/dashboard_screen.dart';
import 'package:vaccation_nanny/ui_modules/rounded_rectangle_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'regisrerscreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String firstName;
  String lastName;
  String email;
  String password;
  String password2;
  String address;
  String phone;
  double weightCapacity = 0;
  bool travelCapacity = true;
  bool specialCapacity = true;
  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  dynamic _profileimage;
  dynamic _idImage;
  dynamic profileimageUrl;
  dynamic idImageUrl;

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
      body: Builder(
        builder: (context) => ModalProgressHUD(
          inAsyncCall: spinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'images/nannysideregisterscreenheader4.png')),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.redAccent,
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
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
                              : Image.asset(
                                  "images/userclipart2.png",
                                  fit: BoxFit.fill,
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
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter your email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter your password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        obscureText: true,
                        onChanged: (value) {
                          password2 = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Confirm your password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextField(
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
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          address = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter Your address',
                        ),
                      ),
                    ),
                    HeadingAndCustomWidgetBox(
                      heading: "Capacity to lift weight:",
                      passedCustomWidget: Slider(
                        value: weightCapacity,
                        min: 0,
                        max: 200,
                        divisions: 201,
                        label: weightCapacity.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            weightCapacity = value;
                          });
                        },
                      ),
                      passedCustomText:
                          weightCapacity.toInt().toString() + " lbs",
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: travelCapacity,
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
                            value: specialCapacity,
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
                                          : AssetImage('images/idclipart.png')),
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
                        title: 'Register',
                        color: Color(0XFFfd992a),
                        onPressed: () async {
                          if (firstName == null ||
                              lastName == null ||
                              firstName.length == 0 ||
                              lastName.length == 0) {
                            showASnackBar(context,
                                'Please provide your first and last name');
                          } else if (_profileimage == null) {
                            showASnackBar(
                                context, 'Please provide a profile picture');
                          } else if (email == null || email.length == 0) {
                            showASnackBar(
                                context, 'Please enter an email address');
                          } else if (email.indexOf('@') == -1 ||
                              email.indexOf('.') == -1) {
                            showASnackBar(
                                context, 'Please enter a valid email address');
                          } else if (password == null || password.length < 6) {
                            showASnackBar(context,
                                'Please enter a password of atleast 6 characters');
                          } else if (password2 != password) {
                            showASnackBar(context, 'Passwords don\'t match');
                          } else if (address == null || address.length == 0) {
                            showASnackBar(
                                context, 'Please provide your address');
                          } else if (phone == null || phone.length == 0) {
                            showASnackBar(
                                context, 'Please provide your contact number');
                          } else if (_idImage == null) {
                            showASnackBar(
                                context, 'Please provide an ID picture');
                          } else {
                            try {
                              setState(() {
                                spinner = true;
                              });
                              final newuser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              if (newuser != null) {
                                profileimageUrl =
                                    await uploadPic(_profileimage);
                                idImageUrl = await uploadPic(_idImage);

                                await FireStoreDatabase(uid: newuser.user.uid)
                                    .updateUserData(
                                        firstName: firstName,
                                        lastName: lastName,
                                        email: email,
                                        address: address,
                                        phone: phone,
                                        weightCapacity: weightCapacity.toInt(),
                                        travelCapacity: travelCapacity,
                                        specialCapacity: specialCapacity,
                                        profileImageUrl: profileimageUrl,
                                        idImageUrl: idImageUrl);
                                Navigator.pushReplacementNamed(
                                    context, DashboardScreen.id);
                              }
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
