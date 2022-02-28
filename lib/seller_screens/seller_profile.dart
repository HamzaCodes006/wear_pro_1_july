import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/modules/user_preferences.dart';
import 'package:wear_pro/themes.dart';
import '../constants.dart';
import 'package:wear_pro/widgets/widgets.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

// import 'package:user_profile_example/model/user.dart';
// import 'package:user_profile_example/utils/user_preferences.dart';
// import 'package:user_profile_example/widget/button_widget.dart';
// import 'package:user_profile_example/widget/numbers_widget.dart';
// import 'package:user_profile_example/widget/profile_widget.dart';

class SellerProfileScreen extends StatefulWidget {
  static const String id = 'SellerProfileScreen';
  @override
  _SellerProfileScreenState createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  bool convert = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
    Size size = MediaQuery
        .of(context)
        .size;
    final user = UserPreferences.myUser;

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) =>
            Scaffold(
              appBar: AppBar(
                title: Text(
                  'Profile',
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
                actions: [
                  ThemeSwitcher(
                    builder: (context) =>
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.moon,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            final theme =
                            isDarkMode ? MyThemes.lightTheme : MyThemes
                                .darkTheme;
                            final switcher = ThemeSwitcher.of(context);
                            switcher.changeTheme(theme: theme);
                          },
                        ),
                  ),
                ],
              ),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade500.withOpacity(
                              0.5),
                          radius: size.width * 0.14,
                          foregroundImage: AssetImage(
                              'assets/images/image_8.jpeg'),
                          child: Icon(
                            FontAwesomeIcons.user,
                            color: Colors.white,
                            size: size.width * 0.1,
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.04,
                        left: size.width * 0.54,
                        child: Container(
                          height: size.height * 0.13,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: kOrange,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.0),
                          ),
                          child: Icon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                            size: size.width * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Column(
                    children: [
                      Text(
                        user.name,
                        style: kBodyTextBlack,
                      ),
                      SizedBox(height: 5),
                      Text(
                        user.email,
                        style: kBodyTextGrey,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'EditProfileScreen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Edit Profile',
                              style: kBodyTextBlack.copyWith(
                                  color: Colors.blue, fontSize: 16),
                            ),
                            SizedBox(width: 5,),
                            Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 22,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  // buildName(user),
                  SizedBox(height: 20),
                  // NumbersWidget(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SwitchListTile(
                        title: Text('Buyer Mode', style: kBodyTextBlack,),
                        subtitle: Text('Turn switch on to go to buyer mode.',
                          style: kBodyTextGrey,),
                        activeColor: kOrange,
                        value: convert, onChanged:(selected){
                      setState(() {
                        convert = !convert;
                        Navigator.pushNamed(context, 'HomeScreen');
                      });
                      // convert = convert;
                    }
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, 'WelcomeScreen');
                  //   },
                  //   child: ProfileListItem(
                  //       name: 'Switch To Seller',
                  //       icon: Icons.shopping_cart_outlined,
                  //       secondIcon: Icons.arrow_forward_ios),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'CartScreen');
                    },
                    child: ProfileListItem(
                        name: 'My Cart',
                        icon: Icons.shopping_cart_outlined,
                        secondIcon: Icons.arrow_forward_ios),
                  ),
                  SizedBox(height: 10),
                  ProfileListItem(
                      name: 'My Orders',
                      icon: Icons.shopping_cart_outlined,
                      secondIcon: Icons.arrow_forward_ios),
                  SizedBox(height: 10),
                  ProfileListItem(
                      name: 'Wish List',
                      icon: Icons.favorite_border,
                      secondIcon: Icons.arrow_forward_ios),
                  SizedBox(height: 10),
                  ProfileListItem(
                      name: 'Help',
                      icon: Icons.shopping_cart_outlined,
                      secondIcon: Icons.arrow_forward_ios),
                  SizedBox(height: 10),
                  ProfileListItem(
                    name: 'Log Out',
                    icon: Icons.logout,
                    secondIcon: Icons.arrow_forward_ios,
                  ),
                  // SwitchListTile(
                  //     title: Text('Become a Seller', style: kBodyTextBlack,),
                  //     subtitle: Text('Turn switch on to go to seller mode.',
                  //       style: kBodyTextGrey,),
                  //     activeColor: kOrange,
                  //     value: convert, onChanged:(selected){
                  //       setState(() {
                  //         convert = !convert;
                  //       });
                  // }
                  // ),
                  SizedBox(height: 10),
                  // Expanded(
                  //   child: ListView(
                  //     children: <Widget>[
                  //       ProfileListItem(
                  //         icon: Icons.account_circle_outlined,
                  //         text: 'Privacy',
                  //       ),
                  //       ProfileListItem(
                  //         icon: Icons.account_circle_outlined,
                  //         text: 'Purchase History',
                  //       ),
                  //       ProfileListItem(
                  //         icon: Icons.account_circle_outlined,
                  //         text: 'Help & Support',
                  //       ),
                  //       ProfileListItem(
                  //         icon: Icons.account_circle_outlined,
                  //         text: 'Settings',
                  //       ),
                  //       ProfileListItem(
                  //         icon: Icons.account_circle_outlined,
                  //         text: 'Invite a Friend',
                  //       ),
                  //       ProfileListItem(
                  //         icon: Icons.account_circle_outlined,
                  //         text: 'Logout',
                  //         hasNavigation: false,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 48),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'About',
                  //         style: kBodyTextBlack,
                  //       ),
                  //       const SizedBox(height: 16),
                  //       Text(
                  //         user.about,
                  //         textAlign: TextAlign.justify,
                  //         style: kBodyTextGrey.copyWith( height: 1.4),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
      ),
    );
  }

// Widget buildName(User user) => Column(
//       children: [
//         Text(
//           user.name,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           user.email,
//           style: TextStyle(color: Colors.grey),
//         )
//       ],
//     );

// Widget buildUpgradeButton() => ButtonWidget(
//       text: 'Upgrade To PRO',
//       onClicked: () {},
//     );
//
//   Widget buildAbout(User user) => Container(
//         padding: EdgeInsets.symmetric(horizontal: 48),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'About',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               user.about,
//               style: TextStyle(fontSize: 16, height: 1.4),
//             ),
//           ],
//         ),
//       );
}
