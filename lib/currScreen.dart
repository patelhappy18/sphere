import 'package:flutter/material.dart';
import 'package:myvoiceapp/View/authentication/fullname.dart';
import 'package:myvoiceapp/View/authentication/otp.dart';
import 'package:myvoiceapp/View/authentication/phone.dart';
import 'package:myvoiceapp/View/authentication/welcome.dart';
import 'package:myvoiceapp/View/calling/callPage.dart';
import 'package:myvoiceapp/View/calling/landingPage.dart';
import 'package:myvoiceapp/View/dashboard/dashboard.dart';
import 'package:myvoiceapp/View/dashboard/message.dart';
import 'package:myvoiceapp/View/dashboard/notification.dart';
import 'package:myvoiceapp/View/dashboard/profile.dart';
import 'package:myvoiceapp/View/dashboard/setting.dart';
import 'package:myvoiceapp/View/dashboard/specific.dart';
import 'package:myvoiceapp/View/splash/splash_screen.dart';
import 'package:myvoiceapp/View/dashboard/createchannel.dart';
import 'package:myvoiceapp/View/dashboard/joinchannel.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({super.key});

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  String activeScreen = 'splash-screen';

  void otp() {
    setState(() {
      activeScreen = 'otp-screen';
    });
  }

  void showPhoneScreen() {
    setState(() {
      activeScreen = 'phonenumber-screen';
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      showPhoneScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    if (activeScreen == 'splash-screen') {
      screen = SplashScreen(otp);
    } else if (activeScreen == 'phonenumber-screen') {
      screen = Phone(otp);
    } else if (activeScreen == 'otp-screen') {
      screen = OTP(
        verificationId: '',
        phoneNumber: '',
      );
    } else if (activeScreen == 'fullname') {
      screen = FullNameScreen(
        phoneNumber: '',
      );
    } else if (activeScreen == 'welcome') {
      screen = WelcomeScreen(
        phoneNumber: '',
      );
    } else {
      screen = SplashScreen(otp); // Fallback to SplashScreen
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 57, 37, 91)),
        useMaterial3: true,
      ),
      home: screen,
      initialRoute: 'initialscreen',
      routes: {
        'initialscreen': (context) => SplashScreen(otp),
        'phone': (context) => Phone(otp),
        'otp': (context) => OTP(
              verificationId: '',
              phoneNumber: '',
            ),
        'dashboard': (context) => Dashboard(),
        'notification': (context) => NotificationsPage(),
        'profile': (context) => UserProfileScreen(),
        'messages': (context) => MessagingScreen(),
        'welcomeScreen': (context) => WelcomeScreen(
              phoneNumber: '',
            ),
        'fullnameScreen': (context) => FullNameScreen(
              phoneNumber: '',
            ),
        'callLandingPage': (context) => LandingPage(),
        'createchannel': (context) => CreateChannel(),
        'joinchannel': (context) => JoinChannelScreen(),
        'specific': (context) => SpecificChannelScreen(),
        'setting': (context) => SettingsPage(),
      },
    );
  }
}
