
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:my_tutor1/model/config.dart';

import 'package:flutter/material.dart';


import 'package:fluttertoast/fluttertoast.dart';


import 'package:ndialog/ndialog.dart';
import 'loginscreen.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //bool _isChecked = false;
  bool _passwordVisible = true;
  //String eula = "";
var _image;
  late double screenHeight, screenWidth, resWidth;
  String pathAsset = 'assets/images/2.jpg';
  
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
 final focus4 = FocusNode();
  final focus5 = FocusNode();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
   final TextEditingController _addressEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
    
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
         
            child: Column(
              children: [upperHalf(context), lowerHalf(context)],
            ),
          ),
        ),
      
    );
  }

  Widget upperHalf(BuildContext context) {
    return
   
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
         child: GestureDetector(
                    onTap: () => {_takePictureDialog()},
                      child: SizedBox(
                          height: screenHeight / 2.5,
                          width: screenWidth,
                          child: _image == null
                              ? Image.asset(pathAsset)
                              : Image.file( _image,
                                  fit: BoxFit.cover,
                                ))),
        );
        
    
    
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
      width: resWidth,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 20, 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Register New Account",
                      style: TextStyle(
                        fontSize: resWidth * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val) => val!.isEmpty || (val.length < 3)
                            ? "name must be longer than 3"
                            : null,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focus);
                        },
                        controller: _nameEditingController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(),
                            icon: Icon(Icons.person),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val) => val!.isEmpty ||
                                !val.contains("@") ||
                                !val.contains(".")
                            ? "enter a valid email"
                            : null,
                        focusNode: focus,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focus1);
                        },
                        controller: _emailditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(),
                            labelText: 'Email',
                            icon: Icon(Icons.email),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),

                    TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val) => val!.isEmpty ?
                              "enter a valid handphone number"
                            : null,
                        focusNode: focus1,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focus2);
                        },
                        controller: _phoneEditingController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(),
                            labelText: 'Handphone No.',
                            icon: Icon(Icons.phone),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),



                TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val) => val!.isEmpty ?
                              "enter a valid address"
                            : null,
                        focusNode: focus2,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focus3);
                        },
                        controller: _addressEditingController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(),
                            labelText: 'Address.',
                            icon: Icon(Icons.home),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),






                    TextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (val) => validatePassword(val.toString()),
                      focusNode: focus3,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus4);
                      },
                      controller: _passEditingController,
                      decoration: InputDecoration(
                          labelStyle: const TextStyle(),
                          labelText: 'Password',
                          icon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          )),
                      obscureText: _passwordVisible,
                    ),
                    TextFormField(
                      style: const TextStyle(),
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        validatePassword(val.toString());
                        if (val != _passEditingController.text) {
                          return "password do not match";
                        } else {
                          return null;
                        }
                      },
                      focusNode: focus4,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus5);
                      },
                      controller: _pass2EditingController,
                      decoration: InputDecoration(
                          labelText: 'Re-enter Password',
                          labelStyle: const TextStyle(),
                          icon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          )),
                      obscureText: _passwordVisible,
                    ),

              

                    const SizedBox(
                      height: 15,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(screenWidth / 3, 50)),
                          child: const Text('Register'),
                          onPressed: _registerAccountDialog,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Already Register? ",
                  style: TextStyle(
                    fontSize: 16.0,
                  )),
              GestureDetector(
                onTap: () => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const LoginScreen()))
                },
                child: const Text(
                  "Login here",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: null,
            child: const Text(
              "Back to Home",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _registerAccountDialog() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please complete the registration form first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _registerUserAccount();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String? validatePassword(String value) {
    // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }


  void _registerUserAccount() {
    FocusScope.of(context).requestFocus(FocusNode());
    String _name = _nameEditingController.text;
    String _email = _emailditingController.text;
    String _phone = _phoneEditingController.text;
    String _pass = _passEditingController.text;
    String _address = _addressEditingController.text;
   String base64Image = base64Encode(_image!.readAsBytesSync());

//print (base64Image);

    FocusScope.of(context).unfocus();
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Registration in progress.."),
        title: const Text("Registering..."));
    progressDialog.show();


    http.post(Uri.parse(MyConfig.server + "/my_tutor1/xx/php/register_user.php"),
        body: {
          "name": _name,
          "email": _email,
           "phone": _phone,
          "password": _pass,
          "address": _address,
          "image": base64Image,
          
        }).then((response) {

      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Registration Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen()));
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Registration Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        return;
      }
    });
  }
   _takePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          _galleryPicker(),
                        },
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                TextButton.icon(
                    onPressed: () =>
                        {Navigator.of(context).pop(), _cameraPicker()},
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera")),
              ],
            ));
      },
    );
  }

  _galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

 
  
}