import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/widgets.dart';
import 'package:badges/badges.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class ProductScreen extends StatefulWidget {
  static const String id = 'ProductScreen';
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey.shade300;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: TextField(
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
              hintText: "Search...",
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_sharp),
          color: kOrange,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 35.0,
              height: 35.0,
              child: Center(child: Text("H")),
              decoration: BoxDecoration(
                color: kOrange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Our Products",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
                  Navigator.pushNamed(context, 'ProductDisplayScreen');
                },
                child: ProductContainer(
                  imagePath: 'assets/images/men1.jpg',
                  productTitle: 'Grey Track Suit',
                  productPrice: 'Rs 800/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'ProductDisplayScreen');
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women15.jpg',
                  productTitle: 'Black Jacket',
                  productPrice: 'Rs 900/-',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'CartScreen');
                },
                child: ProductContainer(
                  imagePath: 'assets/images/women20.jpg',
                  productTitle: 'Black T-Shirt',
                  productPrice: 'Rs 10001/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/men4.jpeg',
                  productTitle: 'Grey Jacket',
                  productPrice: 'Rs 1100/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/men5.jpeg',
                  productTitle: 'Blue Shirt',
                  productPrice: 'Rs 1200/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/men6.jpeg',
                  productTitle: 'Grey Hud',
                  productPrice: 'Rs 1300/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/women17.jpg',
                  productTitle: 'White Hud',
                  productPrice: 'Rs 1400/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/men8.jpeg',
                  productTitle: 'Classy Hud',
                  productPrice: 'Rs 1500/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/men9.jpeg',
                  productTitle: 'Grey Suit with Black Shirt',
                  productPrice: 'Rs 1600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/men10.jpeg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/women1.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/women2.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/women3.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/women4.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/kid1.jpeg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/kid2.jpeg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/women5.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/women6.jpg',
                  productTitle: 'Black Shirt with Jacket',
                  productPrice: 'Rs 2600/-',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ProductContainer(
                  imagePath: 'assets/images/women7.jpg',
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
            child: Icon(Icons.shopping_cart_outlined,color: Colors.white,),
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