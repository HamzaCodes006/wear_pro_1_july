import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreServices {
  getTopPickedStore() {
    return FirebaseFirestore.instance.collection('Vendors').where(
        'accVerified', isEqualTo: true).snapshots();
  }
}