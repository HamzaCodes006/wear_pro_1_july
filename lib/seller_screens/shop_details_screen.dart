import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/auth_provider.dart';
import 'package:wear_pro/widgets/widgets.dart';

class ShopDetailsScreen extends StatefulWidget {
  static const String id = 'ShopDetailsScreen';

  @override
  _ShopDetailsScreenState createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  var _emailController = TextEditingController();
  var _addressController = TextEditingController();
  var _cityController = TextEditingController();
  var _countryController = TextEditingController();
  var _shopNameController = TextEditingController();
  String shopName;
  String mobileNo;
  String email;
  String shopLocation;
  bool isLoading = false;

  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(filePath) async {
    File file = File(filePath);

    try {
      await _storage
          .ref('uploads/shopPosters/${_shopNameController.text}')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
    String downloadURL = await _storage
        .ref('uploads/shopPosters/${_shopNameController.text}')
        .getDownloadURL();
    return downloadURL;

    // Within your widgets:
    // Image.network(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    Size size = MediaQuery
        .of(context)
        .size;
    return isLoading ? CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Theme
          .of(context)
          .primaryColor),):SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.28,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: _image == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.user,
                        color: Colors.white,
                        size: size.width * 0.1,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add Shop Image',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              _authData.getImage().then((image) {
                                setState(() {
                                  _image = image;
                                });
                                if (image != null) {
                                  _authData.isPicAvail = true;
                                }
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.edit,
                              color: Colors.blue,
                              size: size.width * 0.06,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                      : Image.file(
                    _image,
                    fit: BoxFit.cover,

                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 25.0),
                      child: TextFormField(
                        controller: _shopNameController,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Shop Name';
                          }
                          setState(() {
                            shopName = value;
                          });
                          return null;
                        },
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hoverColor: kOrange,
                          // helperText: 'Add Text',
                          hintStyle: TextStyle(fontSize: 18.0),
                          prefixIcon: Icon(
                            Icons.add_business,
                          ),
                          labelText: 'Business Name',
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            // gapPadding: 12.0,
                            borderSide: BorderSide(
                              width: 2,
                              color: kOrange,
                            ),
                          ),
                          focusColor: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 25.0),
                      child: TextFormField(
                        // maxLines: 18,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Mobile Number';
                          }
                          setState(() {
                            mobileNo = value;
                          });
                          return null;
                        },
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hoverColor: kOrange,
                          // helperText: 'Add Text',
                          hintStyle: TextStyle(fontSize: 18.0),
                          // prefixText: '+92',
                          prefixIcon: Icon(
                            Icons.phone_android,
                          ),
                          labelText: 'Mobile Number',
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            // gapPadding: 12.0,
                            borderSide: BorderSide(
                              width: 2,
                              color: kOrange,
                            ),
                          ),
                          focusColor: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 25.0),
                      child: TextFormField(
                        controller: _emailController,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          final bool _isValid =
                          EmailValidator.validate(_emailController.text);
                          if (!_isValid) {
                            return 'Invalid Email Format';
                          }
                          setState(() {
                            email = value;
                          });
                          return null;
                        },
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hoverColor: kOrange,
                          // helperText: 'Add Text',
                          hintStyle: TextStyle(fontSize: 18.0),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          labelText: 'Email',
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            // gapPadding: 12.0,
                            borderSide: BorderSide(
                              width: 2,
                              color: kOrange,
                            ),
                          ),
                          focusColor: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 25.0),
                      child: TextFormField(
                        controller: _addressController,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please press Navigator Button.';
                          }
                          if (_authData.shopLatitude == null) {
                            return 'Please Enter Address.';
                          }
                          shopLocation = value;
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hoverColor: kOrange,
                          // helperText: 'Add Text',
                          hintStyle: TextStyle(fontSize: 18.0),
                          prefixIcon: Icon(
                            Icons.contact_mail_outlined,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.location_searching),
                            onPressed: () {
                              _addressController.text =
                              'Locating...\nPlease wait...';
                              _authData.getCurrentAddress().then((address) {
                                if (address != null) {
                                  setState(() {
                                    _addressController.text =
                                    '${_authData.placeName}\n${_authData
                                        .shopAddress}';
                                    _cityController.text =
                                    '${_authData.locality}';
                                    _countryController.text =
                                    '${_authData.countryName}';
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Couldn\'t find location... Try again')),
                                  );
                                }
                              });
                            },
                          ),
                          labelText: 'Business Location',
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            // gapPadding: 12.0,
                            borderSide: BorderSide(
                              width: 2,
                              color: kOrange,
                            ),
                          ),
                          focusColor: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.left,
                        maxLines: 5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 25.0),
                      child: TextFormField(
                        controller: _cityController,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter City Name';
                          }
                          return null;
                        },
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hoverColor: kOrange,
                          // helperText: 'Add Text',
                          hintStyle: TextStyle(fontSize: 18.0),
                          prefixIcon: Icon(
                            Icons.add_location_outlined,
                          ),
                          labelText: 'City',
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            // gapPadding: 12.0,
                            borderSide: BorderSide(
                              width: 2,
                              color: kOrange,
                            ),
                          ),
                          focusColor: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 25.0),
                      child: TextFormField(
                        controller: _countryController,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Country Name';
                          }
                          return null;
                        },
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hoverColor: kOrange,
                          // helperText: 'Add Text',
                          hintStyle: TextStyle(fontSize: 18.0),
                          prefixIcon: Icon(
                            Icons.add_location_outlined,
                          ),
                          labelText: 'Country',
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            // gapPadding: 12.0,
                            borderSide: BorderSide(
                              width: 2,
                              color: kOrange,
                            ),
                          ),
                          focusColor: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    RoundedButton(
                      buttonName: 'Create',
                      onPress: () {
                        if (_authData.isPicAvail == true) {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            uploadFile(_authData.newImage.path).then((url) {
                              //save vendor details to firebase
                              _authData.saveShopDetailsToDB(url: url,
                                email: email,
                                shopName: shopName,
                                mobileNo: mobileNo,
                                shopAddress: shopLocation,);
                            }).then((value) {
                              setState(() {
                                _formKey.currentState.reset();
                                isLoading=false;
                              });
                            });
                            Navigator.pushReplacementNamed(
                                context, 'ShopScreen');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                    Text('Failed to upload shop poster!')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Shop Poster need to be added.')),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// child: TextFieldInput(
//   icon: FontAwesomeIcons.user,
//   hint: 'Business Name',
//   inputType: TextInputType.name,
//   inputAction: TextInputAction.next,
// ),
