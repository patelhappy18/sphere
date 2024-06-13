import 'package:flutter/material.dart';
import 'package:myvoiceapp/View/authentication/otp.dart';
import 'package:myvoiceapp/View/authentication/phone.dart';
import 'package:myvoiceapp/View/dashboard/dashboard.dart';
import 'package:myvoiceapp/View/splash/splash_screen.dart';

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
        'otp': (context) => OTP(verificationId: ''),
        'dashboard': (context) => DashboardScreen()
      },
    );
  }
}
