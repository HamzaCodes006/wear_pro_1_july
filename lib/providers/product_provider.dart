import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductProvider extends ChangeNotifier {
  bool isPicAvail = false;
  File newImage;
  String pickError;

  final ImagePicker _picker = ImagePicker();

  Future<File> getProductImage() async {

    final XFile image = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    if (image != null) {
      newImage = File(image.path);
      notifyListeners();
      print(newImage);
    }
    else {
      this.pickError = 'no image selected!';
      print('no image selected!');
      notifyListeners();
    }
    // final file = image.toFile();
    return newImage;
  }



  alertDialog({context, title, content}) {
    return showCupertinoDialog(
        context: context, builder: (BuildContext contxt) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [CupertinoDialogAction(child: Text('OK'), onPressed: () {
          Navigator.pop(context);
        },)
        ],
      );
    });
  }

  Future<void> saveProductDetailsToFB({String productURL,
    String pName,
    String pDescription,
    String pPrice,
    String pCategory,}) async {
    var timeStamp = Timestamp
        .now()
        .millisecondsSinceEpoch;
    try {
      final addProduct = await FirebaseFirestore.instance
          .collection('Vendors')
          .doc(FirebaseAuth.instance.currentUser.uid).collection('products')
          .add({
        'productURL': productURL,
        'productName': pName,
        'productDescription': pDescription,
        'productPrice': pPrice,
        'productCategory': pCategory,
        'productRating': '0.00',
        'productVerified': true,
        'productPublished': false,
        'productTime': timeStamp,
      })
          .then((value) => print('Product Added Successfully!!'))
          .catchError((onError) {
        print('Product Not added Successfully!!');
      });
    } catch (e) {
      print(e);
    }
    return null;
  }
}


