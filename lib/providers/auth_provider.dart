import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';

class AuthProvider extends ChangeNotifier {
  String pickerError = '';
  bool isPicAvail = false;
  File newImage;
  double shopLatitude;
  double shopLongitude;
  String shopAddress;
  String placeName;
  String countryName;
  String locality;
  String featureName;
  String adminArea;
  String postalCode;
  String email;
  String password;
  String error = '';

  //Register buyer using email
  Future<UserCredential> registerVendor(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        this.error = 'The password provided is too weak.';
        notifyListeners();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        this.error = 'The account already exists for that email.';
        notifyListeners();
        print('The account already exists for that email.');
      }
    } catch (e) {
      this.error = e.toString();
      notifyListeners();
      print(e);
    }
    return userCredential;
  }

  //Login buyer using email
  Future<UserCredential> loginVendor(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCredential;
    try {
      userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigator.pushReplacementNamed(context, HomeScreen.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        this.error = 'No user found for that email.';
        notifyListeners();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        this.error = 'Wrong password provided .';
        notifyListeners();
        print('Wrong password .');
        print(error);
      }
    }
    // } catch (e) {
    //   this.error = e.toString();
    //   notifyListeners();
    //   print(e);
    // }
    return userCredential;
  }

  //Save buyer data to DB
  Future<void> saveBuyerDataToDB({
    String fName,
    String lName,
    String age,
    String email,
    String gender,
    String password,
  }) async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference _buyers =
    FirebaseFirestore.instance.collection('Buyers').doc(user.uid);
    _buyers.set({
      'uid': user.uid,
      'age': age,
      'fName': fName,
      'lName': lName,
      'email': this.email,
      'password': password,
      'gender': gender,
      'userLatitude': '',
      'userLongitude': '',
    });
    //     final addVendor = await FirebaseFirestore.instance
    //         .collection('Vendors')
    //         .doc(FirebaseAuth.instance.currentUser.uid)
    //         .set({
    //       'shopName': shopName,
    //       'mobileNo': mobileNo,
    //       'email': email,
    //       'location': '${this.shopLatitude},${this.shopLongitude},',
    //       'address': shopAddress,
    //       'shopOpen': 'true',
    //       'rating': '0.00',
    //       'totalRating': '0',
    //       'city': this.locality,
    //       'imageURL': url,
    //     })
    //         .then((value) => print('Added Successfully!'))
    //         .catchError((onError) {
    //       print('Not Successfully');
    //     });
    //   } catch (e) {
    //     print(e);
    //   }
    //
    //   return null;
    // }
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    // final file = image.toFile();
    newImage = image as File;
    print(newImage);
    print(image);
    return newImage;
  }

  Future getCurrentAddress() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    this.shopLatitude = _locationData.latitude;
    this.shopLongitude = _locationData.longitude;
    notifyListeners();
    // From coordinates
    final coordinates =
    new Coordinates(_locationData.latitude, _locationData.longitude);
    var _addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var shopAddress = _addresses.first;
    this.shopAddress = shopAddress.addressLine;
    this.placeName = shopAddress.featureName;
    this.countryName = shopAddress.countryName;
    this.locality = shopAddress.locality;
    this.postalCode = shopAddress.postalCode;
    this.featureName = shopAddress.featureName;
    this.adminArea = shopAddress.adminArea;
    notifyListeners();
    return shopAddress;
  }

  Future<void> saveShopDetailsToDB({String url,
    String shopName,
    String mobileNo,
    String email,
    String shopAddress}) async {
    // DocumentReference _vendors = FirebaseFirestore.instance.collection('vendors').add(data);
    try {
      final addVendor = await FirebaseFirestore.instance
          .collection('Vendors')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        'shopName': shopName,
        'mobileNo': mobileNo,
        'email': FirebaseAuth.instance.currentUser.email,
        'shopLatitude': this.shopLatitude,
        'shopLongitude': this.shopLongitude,
        'address': shopAddress,
        'shopOpen': 'true',
        'rating': '0.00',
        'totalRating': '0',
        'city': this.locality,
        'imageURL': url,
        'accVerified': true,
      })
          .then((value) => print('Added Successfully!'))
          .catchError((onError) {
        print('Not Successfully');
      });
    } catch (e) {
      print(e);
    }

    return null;
  }

}

