import 'package:flutter/material.dart';
import 'package:wear_pro/modules/product_des.dart';
import 'package:wear_pro/widgets/widgets.dart';

import '../constants.dart';

class ApprovalListScreen extends StatefulWidget {
  static const String id = 'ApprovalScreen';
  @override
  _ApprovalListScreenState createState() => _ApprovalListScreenState();
}

class _ApprovalListScreenState extends State<ApprovalListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Approval',
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
      body: SingleChildScrollView(
        child: Column(
            children: List.generate(
          myProducts.length,
          (index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'ProductDisplayScreen');
              },
              child: ShopProduct(
                title: myProducts[index].title,
                des: myProducts[index].description,
                price: 'Rs. ${myProducts[index].price}',
                imagePath: myProducts[index].images,
              ),
            );
          },
        )),
      ),
    );
  }
}
