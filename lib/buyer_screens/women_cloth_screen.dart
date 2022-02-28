import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/widgets.dart';
import 'package:badges/badges.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class WomenClothScreen extends StatefulWidget {
  static const String id = 'WomenClothScreen';

  @override
  _WomenClothScreenState createState() => _WomenClothScreenState();
}

class _WomenClothScreenState extends State<WomenClothScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey.shade300;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Women Product',
          style: kBodyTextBlack.copyWith(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_sharp),
          color: kOrange,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'ProfileScreen');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: kOrange,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    FontAwesomeIcons.user,
                    color: kOrange,
                    size: 20.0,
                  ),
                  // backgroundImage: AssetImage('assets/images/image_2.jpeg',),
                  foregroundImage: AssetImage('assets/images/image_8.jpeg'),
                  radius: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          GridView.count(
            padding: EdgeInsets.only(top: 15.0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 1,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women20.jpg',
                  productTitle: 'Grey Track Suit',
                  productPrice: 'Rs 800/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women19.jpg',
                  productTitle: 'Black Jacket',
                  productPrice: 'Rs 900/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women18.jpg',
                  productTitle: 'Black T-Shirt',
                  productPrice: 'Rs 10001/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women17.jpg',
                  productTitle: 'Grey Jacket',
                  productPrice: 'Rs 1100/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women16.jpg',
                  productTitle: 'Blue Shirt',
                  productPrice: 'Rs 1200/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women15.jpg',
                  productTitle: 'Grey Hud',
                  productPrice: 'Rs 1300/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women20.jpg',
                  productTitle: 'White Hud',
                  productPrice: 'Rs 1400/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women14.jpg',
                  productTitle: 'Classy Hud',
                  productPrice: 'Rs 1500/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women8.jpg',
                  productTitle: 'Grey Suit with Black Shirt',
                  productPrice: 'Rs 1600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women9.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women9.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women10.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women11.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women12.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women13.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women7.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women5.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women6.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women4.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women3.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women1.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.id);
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women2.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          child: Badge(
            badgeContent: Text('4',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            position: BadgePosition.topStart(start: 25, top: -20),
            showBadge: true,
            toAnimate: true,
            animationType: BadgeAnimationType.scale,
            borderSide: BorderSide(color: Colors.white),
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, CartScreen.id);
                },
                child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            )),
          ),
        ),
        backgroundColor: kOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    );
  }
}
