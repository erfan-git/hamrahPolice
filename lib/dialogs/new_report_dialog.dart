import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class NewReportDialog extends StatefulWidget {
  @override
  _NewReportDialogState createState() => _NewReportDialogState();
}

class _NewReportDialogState extends State<NewReportDialog> {
  String _subject;
  var imageOfReport;
  File _image;
  final _formkey = GlobalKey<FormState>();
  List<CameraDescription> _cameras;

  Position _location = Position(latitude: 0.0, longitude: 0.0);
  CameraController _cameraController;

  onSaveUsername(String value) {
    _subject = value;
  }

  void _displayCurrentLocation() async {
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(location.latitude);

    setState(() {
      _location = location;
    });
  }

  @override
  void initState() {
    _displayCurrentLocation();
    super.initState();
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(
                          Icons.photo_library,
                          color: Colors.blue[900],
                        ),
                        title: new Text(
                          'گالری',
                          style: TextStyle(
                              fontFamily: 'IranSans', color: Colors.blue[900]),
                        ),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(
                        Icons.photo_camera,
                        color: Colors.blue[900],
                      ),
                      title: new Text(
                        'دوربین',
                        style: TextStyle(
                            fontFamily: 'IranSans', color: Colors.blue[900]),
                      ),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Center(
          child: Text(
            'گزارش جدید',
            style: TextStyle(
              color: Colors.blue[900],
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'IranSans',
            ),
          ),
        ),
        content: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    padding: EdgeInsets.only(left: 24.0),
                    child: TextFormField(
                      onSaved: onSaveUsername,
                      validator: (String value) {
                        if (value.length == 0) {
                          return "عنوان گزارش هنوز وارد نشده است";
                        }
                      },
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[700]),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue[700], width: 2),
                        ),
                        icon: Icon(
                          Icons.subject,
                          color: Colors.blue[700],
                        ),
                        border: InputBorder.none,
                        hintText: 'عنوان گزارش',
                        hintStyle: const TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontFamily: 'IranSans'),
                        contentPadding: EdgeInsets.only(
                            top: 8, right: 0, bottom: 8, left: 5),
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 4,
                        color: Colors.blue[700],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 250,
                                  height: 250,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 90,
                                    color: Colors.blue[900],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed('/');
                      _displayCurrentLocation();
                      _showPicker(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 160,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.blue[700],
                      ),
                      child: Text(
                        'افزودن عکس',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'IranSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (_formkey.currentState.validate()) {
                _formkey.currentState.save();
                // sendDataToServer();
              }
            },
            child: Text(
              'لغو',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontFamily: 'IranSans',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_formkey.currentState.validate()) {
                _formkey.currentState.save();
                _displayCurrentLocation();
                // sendDataToServer();
              }
            },
            child: Text(
              'ارسال',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontFamily: 'IranSans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
