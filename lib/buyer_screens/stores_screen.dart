import 'package:flutter/material.dart';
import 'package:wear_pro/widgets/widgets.dart';
import '../constants.dart';

class StoresScreen extends StatefulWidget {
  static const String id = 'StoresScreen';
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  int label = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   title: Text(
        //     'All Stores',
        //     style: kBodyTextGrey.copyWith(color: kOrange),
        //   ),
        //   centerTitle: true,
        //   // title: Container(
        //   //   decoration: BoxDecoration(
        //   //     color: Colors.orange.shade50,
        //   //     borderRadius: BorderRadius.circular(15.0),
        //   //   ),
        //   //   child: TextField(
        //   //     style: TextStyle(fontSize: 20.0),
        //   //     decoration: InputDecoration(
        //   //       hintText: "Search...",
        //   //       border: InputBorder.none,
        //   //       hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
        //   //       prefixIcon: Icon(Icons.search),
        //   //     ),
        //   //   ),
        //   // ),
        //   elevation: 0,
        //   leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Icon(Icons.arrow_back_ios_sharp),
        //     color: kOrange,
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: CircleAvatar(
        //         radius: 18.0,
        //         backgroundColor: kOrange,
        //         child: CircleAvatar(
        //           backgroundColor: Colors.white,
        //           child: Icon(
        //             FontAwesomeIcons.user,
        //             color: kOrange,
        //             size: 18.0,
        //           ),
        //           // backgroundImage: AssetImage('assets/images/image_2.jpeg',),
        //           foregroundImage: AssetImage('assets/images/image_8.jpeg'),
        //           radius: 18.0,
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        body: ListView(
      scrollDirection: Axis.vertical,
      addAutomaticKeepAlives: true,
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            color: kOrange,
                            size: 20,
                          ),
                        ),
                      ),
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
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          'Pace And Ease Online Store',
                          style: kHeadTextBlack.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                                fontSize: 14, fontWeight: FontWeight.bold),
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
              style: kHeadTextBlack.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'ProductDisplayScreen');
          },
          child: ShopProduct(
            title: 'Black Shirt',
            des: 'Men black shirt with black pant',
            price: 'Rs. 1200.00',
            imagePath: 'assets/images/image_4.jpeg',
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'ProductDisplayScreen');
          },
          child: ShopProduct(
            title: 'Black Shirt',
            des: 'Men black shirt with black pant',
            price: 'Rs. 1200.00',
            imagePath: 'assets/images/image_6.jpeg',
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'ProductDisplayScreen');
          },
          child: ShopProduct(
            title: 'Black Shirt',
            des: 'Men black shirt with black pant',
            price: 'Rs. 1200.00',
            imagePath: 'assets/images/image_7.jpeg',
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'ProductDisplayScreen');
          },
          child: ShopProduct(
            title: 'Black Shirt',
            des: 'Men black shirt with black pant',
            price: 'Rs. 1200.00',
            imagePath: 'assets/images/image_8.jpeg',
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'ProductDisplayScreen');
          },
          child: ShopProduct(
            title: 'Kids Shirt',
            des: 'Men black shirt with black pant',
            price: 'Rs. 1100.00',
            imagePath: 'assets/images/image_9.jpeg',
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'ProductDisplayScreen');
          },
          child: ShopProduct(
            title: 'Kids Shirt',
            des: 'Men black shirt with black pant',
            price: 'Rs. 900.00',
            imagePath: 'assets/images/image_10.jpeg',
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'ProductDisplayScreen');
          },
          child: ShopProduct(
            title: 'Kids Shirt',
            des: 'Men black shirt with black pant',
            price: 'Rs. 200.00',
            imagePath: 'assets/images/image_11.jpeg',
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'ProductDisplayScreen');
          },
          child: ShopProduct(
            title: 'Kids Shirt',
            des: 'Men black shirt with black pant',
            price: 'Rs. 1000.00',
            imagePath: 'assets/images/image_12.jpeg',
          ),
        ),
      ],
    ));
  }
}
