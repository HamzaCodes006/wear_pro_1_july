import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/seller_screens/add_product_screen.dart';
import 'package:wear_pro/widgets/rounded_button.dart';
import 'package:wear_pro/widgets/widgets.dart';

class ProductApprovalScreen extends StatefulWidget {
  static const String id = 'ProductApprovalScreen';

  @override
  _ProductApprovalScreenState createState() => _ProductApprovalScreenState();
}

class _ProductApprovalScreenState extends State<ProductApprovalScreen> {
  final published=FirebaseFirestore.instance
      .collection('Vendors')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('products').where('productPublished',isEqualTo: false)
      .snapshots();
  final approval=FirebaseFirestore.instance
      .collection('Vendors')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('products').where('productPublished',isEqualTo: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Product Details',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              ),
            ),
            backgroundColor: kOrange,
            elevation: 5,
          ),
          body: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RoundedButton(
                    buttonName: 'Add Product',
                    onPress: () =>
                        Navigator.pushNamed(context, AddProductScreen.id),
                  ),
                ),
                TabBar(
                  indicatorColor: kOrange,
                  unselectedLabelStyle: kBodyTextGrey.copyWith(fontSize: 14),
                  // automaticIndicatorColorAdjustment: true,
                  // indicatorWeight: 2.0,
                  labelColor: kOrange,
                  unselectedLabelColor: kOrange.withOpacity(0.7),
                  enableFeedback: true,

                  labelStyle: kBodyTextBlack.copyWith(fontSize: 14),
                  tabs: [
                    Tab(
                      text: 'Published',
                    ),
                    Tab(
                      text: 'Pending For Approval',
                    ),
                  ],
                ),
                Expanded(
                  child: Card(
                    child: TabBarView(children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: published,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return CircularProgressIndicator();
                          final List productTitle = snapshot.data.docs.map((e) {
                            return e['productName'];
                          }).toList();
                          final List productDes = snapshot.data.docs.map((e) {
                            return e['productDescription'];

                          }).toList();
                          final List productPrice = snapshot.data.docs.map((e) {
                            return e['productPrice'];
                          }).toList();
                          final List productURL = snapshot.data.docs.map((e) {
                            return e['productURL'];
                          }).toList();
                          return SingleChildScrollView(
                            child: Column(
                                children: List.generate(
                              snapshot.data.docs.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, 'ProductDisplayScreen');
                                  },
                                  child: ShopProduct(
                                    title: productTitle[index],
                                    des: productDes[index],
                                    price: 'Rs. ${productPrice[index]}',
                                    imagePath: productURL[index],
                                  ),
                                );
                              },
                            )),
                          );
                        }
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: approval,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return CircularProgressIndicator();
                          final List productTitle = snapshot.data.docs.map((e) {
                            return e['productName'];
                          }).toList();
                          final List productDes = snapshot.data.docs.map((e) {
                            return e['productDescription'];

                          }).toList();
                          final List productPrice = snapshot.data.docs.map((e) {
                            return e['productPrice'];
                          }).toList();
                          final List productURL = snapshot.data.docs.map((e) {
                            return e['productURL'];
                          }).toList();
                          return SingleChildScrollView(
                            child: Column(
                                children: List.generate(
                              snapshot.data.docs.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, 'ProductDisplayScreen');
                                  },
                                  child: ShopProduct(
                                    title: productTitle[index],
                                    des: productDes[index],
                                    price: 'Rs. ${productPrice[index]}',
                                    imagePath: productURL[index],
                                  ),
                                );
                              },
                            )),
                          );
                        }
                      ),
                    ]),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
