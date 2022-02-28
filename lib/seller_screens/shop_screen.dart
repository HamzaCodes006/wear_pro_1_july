import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/modules/product_des.dart';
import 'package:wear_pro/seller_screens/product_approval_screen.dart';
import 'package:wear_pro/widgets/widgets.dart';
import '../constants.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class ShopScreen extends StatefulWidget {
  static const String id = 'ShopScreen';

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int currentIndex = 0;
  int label = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Vendors')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('products')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return SafeArea(
          child: Scaffold(
            drawer: Drawer(
              child: Material(
                color: kOrange,
                child: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/image_8.jpeg'),
                                ),
                              ),
                            ),
                            Text(
                              'Hamza Khan',
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser.email,
                              style: kBodyText.copyWith(fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      BuildMenuItem(
                        icon: Icons.account_circle_outlined,
                        text: 'Profile',
                      ),
                      BuildMenuItem(
                        icon: Icons.shopping_cart_outlined,
                        text: 'Cart',
                      ),
                      BuildMenuItem(
                        icon: FontAwesomeIcons.shoppingBag,
                        text: 'Order',
                      ),
                      BuildMenuItem(
                        icon: Icons.error,
                        text: 'About',
                      ),
                      SizedBox(height: 35),
                      Divider(color: Colors.white, thickness: 1.4),
                      SizedBox(
                        height: 35.0,
                      ),
                      BuildMenuItem(
                        icon: Icons.help,
                        text: 'Help',
                      ),
                      BuildMenuItem(
                        icon: Icons.logout,
                        text: 'Log Out',
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: kOrange,
                      size: 20,
                    ),
                  ),
                ),
              ),
              actions: [
                //Todo new widget
                // FlatButton.icon(onPressed: (){},  icon: Icon(Icons.add,color: kOrange,), label: Text('Add/Remove Products',style: kBodyText,))
              ],
            ),
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 5,
                                color: Colors.grey)
                          ],
                          image: DecorationImage(
                              image: AssetImage('assets/images/store4.jpeg'),
                              fit: BoxFit.cover),
                          // borderRadius: BorderRadius.circular(0)
                        ),
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.35),
                          // borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 65,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: label == 0
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "CLOSE",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  shape: BoxShape.circle),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "OPEN",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Pace And Ease Online Store',
                                    style: kHeadTextBlack.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 60.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '3.7 (110)',
                                      style: kBodyText.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.8),
                    thickness: 0.7,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      child: Text(
                        'All Products',
                        style: kHeadTextBlack.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  //TODO LIST.generate...

                  Column(
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
                  //TODO LIST.generate...
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, ProductApprovalScreen.id);
              },
              child: Container(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              backgroundColor: kOrange,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              onTap: (index) => {
                setState(
                  () => currentIndex = index,
                ),
              },
              activeColor: Colors.black87,
              inactiveColor: Colors.white,
              icons: [
                Icons.home,
                Icons.search,
                Icons.favorite,
                Icons.account_circle_outlined,
              ],
              iconSize: 28.0,
              activeIndex: currentIndex,
              backgroundColor: kOrange,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.smoothEdge,
            ),
          ),
        );
      },
    );
  }
}
