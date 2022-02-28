import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/admin_screens/admin_home_screen.dart';
import 'package:wear_pro/admin_screens/admin_dashboard_screen.dart';
import 'package:wear_pro/admin_screens/admin_login_screen.dart';
import 'package:wear_pro/admin_screens/admin_success_screen.dart';
import 'package:wear_pro/admin_screens/approval_list_screen.dart';
import 'package:wear_pro/admin_screens/approve_decline_product_screen.dart';
import 'package:wear_pro/buyer_screens/buyer_success_screen.dart';
import 'package:wear_pro/buyer_screens/homeMadeClothScreen.dart';
import 'package:wear_pro/buyer_screens/kids_cloth_screen.dart';
import 'package:wear_pro/buyer_screens/men_cloth_screen.dart';
import 'package:wear_pro/buyer_screens/women_cloth_screen.dart';
import 'package:wear_pro/onboard_screen.dart';
import 'package:wear_pro/providers/auth_provider.dart';
import 'package:wear_pro/providers/location_provider.dart';
import 'package:wear_pro/providers/product_provider.dart';
import 'package:wear_pro/seller_screens/add_product_screen.dart';
import 'package:wear_pro/seller_screens/product_approval_screen.dart';
import 'package:wear_pro/seller_screens/seller_profile.dart';
import 'package:wear_pro/seller_screens/shop_details_screen.dart';
import 'package:wear_pro/seller_screens/shop_screen.dart';
import 'package:wear_pro/seller_screens/success_screen.dart';
import 'package:wear_pro/seller_screens/welcome_screen.dart';
import 'package:wear_pro/splash_screen.dart';
import 'package:wear_pro/test_screen.dart';
import 'buyer_screens/buyer_screens.dart';
import 'package:wear_pro/modules/user_preferences.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'themes.dart';

// void main() => runApp(WearPro());
Future<void> main() async {
  Provider.debugCheckInvalidValueType=null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
      ],
      child: WearPro(),
    ),
  );
  // WearPro());
}

class WearPro extends StatefulWidget {
  // final user = UserPreferences.myUser;

  @override
  State<WearPro> createState() => _WearProState();
}

class _WearProState extends State<WearPro> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ThemeProvider(
      // initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          title: 'Wear Pro',
          themeMode: ThemeMode.system,

          // ThemeData(
          //   textTheme: GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
          // //   primarySwatch: Colors.blue,
          // //   visualDensity: VisualDensity.adaptivePlatformDensity,
          // ),
          initialRoute: ProductApprovalScreen.id,
          routes: {
            LoginScreen.id: (context) => LoginScreen(),
            OnBoardScreen.id: (context) => OnBoardScreen(),
            RegisterScreen.id: (context) => RegisterScreen(),
            ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            ProductScreen.id: (context) => ProductScreen(),
            MenClothScreen.id: (context) => MenClothScreen(),
            WomenClothScreen.id: (context) => WomenClothScreen(),
            KidsClothScreen.id: (context) => KidsClothScreen(),
            HomemadeClothScreen.id: (context) => HomemadeClothScreen(),
            ProductDetailsScreen.id: (context) => ProductDetailsScreen(),
            StoresScreen.id: (context) => StoresScreen(),
            CartScreen.id: (context) => CartScreen(),
            BuyerSuccessScreen.id: (context) => BuyerSuccessScreen(),
            ProfileScreen.id: (context) => ProfileScreen(),
            'EditProfileScreen': (context) => EditProfileScreen(),
            WelcomeScreen.id: (context) => WelcomeScreen(),
            SplashScreen.id: (context) => SplashScreen(),
            ShopDetailsScreen.id: (context) => ShopDetailsScreen(),
            ShopScreen.id: (context) => ShopScreen(),
            ProductApprovalScreen.id: (context) => ProductApprovalScreen(),
            AddProductScreen.id: (context) => AddProductScreen(),
            SuccessScreen.id: (context) => SuccessScreen(),
            SellerProfileScreen.id: (context) => SellerProfileScreen(),
            AdminLoginScreen.id: (context) => AdminLoginScreen(),
            AdminHomeScreen.id: (context) => AdminHomeScreen(),
            AdminDashboardScreen.id: (context) => AdminDashboardScreen(),
            AdminSuccessScreen.id: (context) => AdminSuccessScreen(),
            ApprovalListScreen.id: (context) => ApprovalListScreen(),
            ApproveDeclineProductScreen.id: (context) =>
                ApproveDeclineProductScreen(),

          },
        ),
      ),
    );
  }
}
