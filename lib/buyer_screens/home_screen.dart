import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/buyer_screens/homeMadeClothScreen.dart';
import 'package:wear_pro/buyer_screens/kids_cloth_screen.dart';
import 'package:wear_pro/buyer_screens/men_cloth_screen.dart';
import 'package:wear_pro/buyer_screens/women_cloth_screen.dart';
import 'package:wear_pro/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/widgets/widgets.dart';
import '../constants.dart';
import 'package:badges/badges.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  // StoreServices _storeServices = StoreServices();
  List imageURL = []; //fetching store posters
  List storeName = []; //fetching store name
  List storeLatitude = []; //fetching store lat
  List storeLongitude = []; //fetching store long
  double userLatitude;
  double userLongitude;
  bool permit = false;

  // final locationData = Provider.of<LocationProvider>(context, listen: false);

  Future<void> getCurrentUserLocation() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        if (position != null) {
          setState(() {
            this.userLatitude = position.latitude;
            this.userLongitude = position.longitude;
            this.permit = true;
            FirebaseFirestore.instance
                .collection('Buyers')
                .doc(user.uid)
                .update({
              'userLatitude': userLatitude,
              'userLongitude': userLongitude,
            }).then((value) => print('Location Updated!'));
          });

          //update location in fire store...
        } else {
          print('Permission not granted');
          LocationPermission permission = await Geolocator.requestPermission();
        }

        loggedInUser = user;
        print(loggedInUser.email);
        // print(loggedInUser.phoneNumber);
      } else {
        //navigate to login screen or welcome screen
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserLocation();
    // GetAddressFromLatLong();
  }

  //
  String getDistance(shopLatitude, shopLongitude) {
    var distance = Geolocator.distanceBetween(
        userLatitude, userLongitude, shopLatitude, shopLongitude);
    var distanceInKm=distance/1000;
    return distanceInKm.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size size = MediaQuery.of(context).size;
    // final locationData = Provider.of<LocationProvider>(context, listen: false);

    final ref = FirebaseStorage.instance.ref().child('testimage');
// no need of the file extension, the name will do fine.
    var url = ref.getDownloadURL();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Vendors').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        snapshot.data.docs.forEach((element) {
          // print(element.get('imageURL'));
          imageURL.add(element.get('imageURL'));
          storeName.add(element.get('shopName'));
          // storeLatitude.add(element.get('shopLatitude'));
        });

        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        if (!snapshot.hasData) return CircularProgressIndicator();
        List shopsDistance = [];
        snapshot.data.docs.forEach((ele)  {
          // print('thisss${snapshot.data.docs[i].get('shopLatitude')}');
          // print(snapshot.data.docs[i].get('shopLongitude'));
          var distance = Geolocator.distanceBetween(
              userLatitude,
              userLongitude,
              ele.get('shopLatitude'),
              ele.get('shopLongitude'));
          var distanceInKm=distance/1000;
          shopsDistance.add(distanceInKm.toStringAsFixed(2));
          // print(snapshot.data.docs[i].get('shopLatitude'));
        });
        // shopsDistance.sort();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: kOrange),
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
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.id);
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
                                image: AssetImage('assets/images/image_8.jpeg'),
                              ),
                            ),
                          ),
                          Text(
                            '$userLatitude',
                            style:
                                kBodyText.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$userLongitude',
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
                      onPressed: () {
                        Navigator.pushNamed(context, ProfileScreen.id);
                      },
                    ),
                    BuildMenuItem(
                      icon: Icons.shopping_cart_outlined,
                      text: 'Cart',
                      onPressed: () =>
                          Navigator.pushNamed(context, CartScreen.id),
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
                        _auth.signOut();
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              SizedBox(
                height: size.height * 0.015,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: size.height * 0.3,
                  autoPlay: true,
                ),
                items: [
                  SliderImage(
                    imagePath: 'assets/images/adds_2.png',
                  ),
                  SliderImage(
                    imagePath: 'assets/images/adds_1.png',
                  ),
                  SliderImage(
                    imagePath: 'assets/images/adds_2.png',
                  ),
                  SliderImage(
                    imagePath: 'assets/images/add_4.jpg',
                  ),
                  SliderImage(
                    imagePath: 'assets/images/adds_2.png',
                  ),
                  SliderImage(
                    imagePath: 'assets/images/adds_1.png',
                  ),
                  SliderImage(
                    imagePath: 'assets/images/add_4.jpg',
                  ),
                  SliderImage(
                    imagePath: 'assets/images/adds_2.png',
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              SizedBox(
                height: size.height * 0.02,
                // child: Column(
                //   children: [
                //     Text('${locationData.longitude}'),
                //     Text('${locationData.latitude}'),
                //   ],
                // ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: kBodyTextBlack.copyWith(
                          fontSize: 20.0, color: kOrange),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProductScreen.id);
                      },
                      child: Row(
                        children: [
                          Text("View All",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MenClothScreen.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Container(
                              width: 160.0,
                              height: 180.0,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/men2.jpg'),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  Positioned(
                                    bottom: 1,
                                    child: Container(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Men',
                                          style: kBodyText.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                      height: 35.0,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.black45.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, WomenClothScreen.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: 160.0,
                          height: 180.0,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/women17.jpg'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Positioned(
                                bottom: 1,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Women',
                                      style: kBodyText.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  height: 35.0,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.black45.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, KidsClothScreen.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: 160.0,
                          height: 180.0,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/kid1.jpeg'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Positioned(
                                bottom: 1,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Kids',
                                      style: kBodyText.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  height: 35.0,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.black45.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, HomemadeClothScreen.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: 160.0,
                          height: 180.0,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/GharKkapry1.jpeg'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Positioned(
                                bottom: 1,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Home Made Cloth',
                                      style: kBodyText.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  height: 35.0,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.black45.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended For You",
                      style: kBodyTextBlack.copyWith(
                          fontSize: 20.0, color: kOrange),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'ProductScreen');
                      },
                      child: Row(
                        children: [
                          Text("View All",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'StoresScreen');
                      },
                      child: ListContainer(
                        imagePath: 'assets/images/image_6.jpeg',
                        title: 'Grey Shirt',
                      ),
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_7.jpeg',
                      title: 'Black Shirt',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_8.jpeg',
                      title: 'Grey Pant with Black Shirt',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_6.jpeg',
                      title: 'Grey Huddy',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_1.jpeg',
                      title: 'Men',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/girl.jpeg',
                      title: 'Women',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_3.jpeg',
                      title: 'Kids',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_4.jpeg',
                      title: 'Ghar k Kapry',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_6.jpeg',
                      title: 'Grey Shirt',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_7.jpeg',
                      title: 'Black Shirt',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_8.jpeg',
                      title: 'Grey Pant with Black Shirt',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_6.jpeg',
                      title: 'Grey Huddy',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_1.jpeg',
                      title: 'Men',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/girl.jpeg',
                      title: 'Women',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/image_3.jpeg',
                      title: 'Kids',
                    ),
                    ListContainer(
                      imagePath: 'assets/images/cloth.jpeg',
                      title: 'Ghar k Kapry',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Arrival",
                      style: kBodyTextBlack.copyWith(
                          fontSize: 20.0, color: kOrange),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'ProductScreen');
                      },
                      child: Row(
                        children: [
                          Text("View All",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(imageURL.length, (index) {
                    return ListContainer(
                        imagePath: imageURL[index], title: storeName[index]);
                  }),
                  // child: ListContainer(
                  //   imagePath:imageURL,
                  //   title: 'Women',
                  // ),
                ),
              ),
              // SizedBox(
              //   height: 30.0,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Text(
              //         "Attock City",
              //         style: kBodyTextBlack,
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Icon(
              //         FontAwesomeIcons.mapMarkerAlt,
              //         size: 20,
              //         color: kOrange,
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.8),
                indent: 10,
                endIndent: 10,
                height: 1,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "All stores",
                  style: kBodyTextBlack,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: List.generate(
                    snapshot.data.docs.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, StoresScreen.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: size.height * 0.3,
                            width: double.infinity,
                            // color: Colors.red,
                            child: Stack(
                              children: [
                                // Image.network(snapshot.data['imageURL']),
                                Container(
                                  height: 200,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      // image: Image.network(document['imageURL']),
                                      image: DecorationImage(
                                          image: NetworkImage(imageURL[index]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.black87.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            width: 65,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: index % 2 == 1
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "CLOSE",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .redAccent,
                                                                shape: BoxShape
                                                                    .circle),
                                                      )
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "OPEN",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                shape: BoxShape
                                                                    .circle),
                                                      )
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.start,
                                      //     children: [
                                      //       Text(
                                      //         "Attock City",
                                      //         style: kBodyText,
                                      //       ),
                                      //       SizedBox(
                                      //         width: 10,
                                      //       ),
                                      //       Icon(
                                      //         FontAwesomeIcons.mapMarkerAlt,
                                      //         size: 20,
                                      //         color: kOrange,
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Row(
                                          children: [
                                            Icon(FontAwesomeIcons.store,
                                                size: 18, color: Colors.white),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                storeName[index],
                                                style: kHeadTextBlack.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              '${shopsDistance[index]}Km',
                                              // '${getDistance(snapshot.data.docs[index].get('shopLatitude'), snapshot.data.docs[index].get('shopLongitude'))}Km',
                                              style: kBodyText.copyWith(
                                                  fontSize: 14, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // child:
                // Column(
                //   children: List.generate(
                //     myProducts.length,
                //     (index) {
                //       return GestureDetector(
                //         onTap: () {
                //           Navigator.pushNamed(context, 'StoresScreen');
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Container(
                //             height: size.height * 0.28,
                //             width: double.infinity,
                //             // color: Colors.red,
                //             child: Stack(
                //               children: [
                //                 // Image.network(snapshot.data['imageURL']),
                //                 Container(
                //                   height: 200,
                //                   width: size.width,
                //                   decoration: BoxDecoration(
                //                       // image: Image.network(document['imageURL']),
                //                       // image: DecorationImage(
                //                       //     image: ,
                //                       //     fit: BoxFit.cover),
                //                       borderRadius: BorderRadius.circular(10)),
                //                 ),
                //                 Container(
                //                   height: 200,
                //                   width: double.infinity,
                //                   decoration: BoxDecoration(
                //                       color: Colors.black87.withOpacity(0.35),
                //                       borderRadius: BorderRadius.circular(10)),
                //                   child: Column(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Padding(
                //                         padding: const EdgeInsets.all(18.0),
                //                         child: Align(
                //                           alignment: Alignment.topRight,
                //                           child: Container(
                //                             width: 65,
                //                             height: 25,
                //                             decoration: BoxDecoration(
                //                                 color: Colors.white,
                //                                 borderRadius:
                //                                     BorderRadius.circular(5)),
                //                             child: index % 2 == 1
                //                                 ? Row(
                //                                     mainAxisAlignment:
                //                                         MainAxisAlignment
                //                                             .spaceEvenly,
                //                                     children: [
                //                                       Text(
                //                                         "CLOSE",
                //                                         style: TextStyle(
                //                                             fontSize: 10,
                //                                             color: Colors.black87,
                //                                             fontWeight:
                //                                                 FontWeight.bold),
                //                                       ),
                //                                       Container(
                //                                         width: 8,
                //                                         height: 8,
                //                                         decoration: BoxDecoration(
                //                                             color: Colors.redAccent,
                //                                             shape: BoxShape.circle),
                //                                       )
                //                                     ],
                //                                   )
                //                                 : Row(
                //                                     mainAxisAlignment:
                //                                         MainAxisAlignment
                //                                             .spaceEvenly,
                //                                     children: [
                //                                       Text(
                //                                         "OPEN",
                //                                         style: TextStyle(
                //                                             fontSize: 10,
                //                                             color: Colors.black87,
                //                                             fontWeight:
                //                                                 FontWeight.bold),
                //                                       ),
                //                                       Container(
                //                                         width: 8,
                //                                         height: 8,
                //                                         decoration: BoxDecoration(
                //                                             color: Colors.green,
                //                                             shape: BoxShape.circle),
                //                                       )
                //                                     ],
                //                                   ),
                //                           ),
                //                         ),
                //                       ),
                //                       // Padding(
                //                       //   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                //                       //   child: Row(
                //                       //     mainAxisAlignment: MainAxisAlignment.start,
                //                       //     children: [
                //                       //       Text(
                //                       //         "Attock City",
                //                       //         style: kBodyText,
                //                       //       ),
                //                       //       SizedBox(
                //                       //         width: 10,
                //                       //       ),
                //                       //       Icon(
                //                       //         FontAwesomeIcons.mapMarkerAlt,
                //                       //         size: 20,
                //                       //         color: kOrange,
                //                       //       )
                //                       //     ],
                //                       //   ),
                //                       // ),
                //                       Padding(
                //                         padding: const EdgeInsets.all(18.0),
                //                         child: Row(
                //                           children: [
                //                             Icon(FontAwesomeIcons.store,
                //                                 size: 20, color: Colors.white),
                //                             SizedBox(
                //                               width: 10,
                //                             ),
                //                             // Text(
                //                             //   'Store${index + 1}',
                //                             //   style: kBodyText.copyWith(
                //                             //       fontSize: 14, color: kOrange),
                //                             // ),
                //                             Expanded(
                //                               child: Text(
                //                                 'abcsd',
                //                                 style: kHeadTextBlack.copyWith(
                //                                     color: Colors.white,
                //                                     fontWeight: FontWeight.bold),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ),
              SizedBox(
                height: 20,
              ),
              // List.generate(itemBuilder: itemBuilder)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, 'CartScreen');
            },
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
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
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
        );
      },
    );
  }
}
