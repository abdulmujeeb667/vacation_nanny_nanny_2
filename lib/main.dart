import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vaccation_nanny/screens/active_work_screen.dart';
import 'package:vaccation_nanny/screens/calendar_screen.dart';
import 'package:vaccation_nanny/screens/correction_redirect_screen.dart';
import 'package:vaccation_nanny/screens/family_details_screen.dart';
import 'package:vaccation_nanny/screens/licensing_video_screen.dart';
import 'package:vaccation_nanny/screens/requests_screen.dart';
import 'package:vaccation_nanny/screens/login_screen.dart';
import 'package:vaccation_nanny/screens/password_reset_screen.dart';
import 'package:vaccation_nanny/screens/splash_screen.dart';
import 'package:vaccation_nanny/screens/update_profile_screen.dart';
import 'package:vaccation_nanny/screens/welcome_screen.dart';
import 'package:vaccation_nanny/screens/register_screen.dart';
import 'package:vaccation_nanny/screens/dashboard_screen.dart';

void main() => runApp(VacationNanny());

class VacationNanny extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0XFFF6C0D0),
        sliderTheme: SliderThemeData(
          activeTrackColor: Color(0XFFfd992a),
          inactiveTrackColor: Color(0X99fd992a),
          thumbColor: Color(0XFFfd992a),
          overlayColor: Color(0X33fd992a),
          valueIndicatorColor: Color(0XFFfd992a),
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        CorrectionRedirectScreen.id: (context) => CorrectionRedirectScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        DashboardScreen.id: (context) => DashboardScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PasswordResetScreen.id: (context) => PasswordResetScreen(),
        ActiveWorkScreen.id: (context) => ActiveWorkScreen(),
        CalendarScreen.id: (context) => CalendarScreen(),
        UpdateProfileScreen.id: (context) => UpdateProfileScreen(),
        RequestsScreen.id: (context) => RequestsScreen(),
        // FamilyDetailsScreen.id: (context) => FamilyDetailsScreen()
        VideoApp.id: (context) => VideoApp(),
      },
    );
  }
}
//TODO: firebase setup for ios
//TODO: geolocator setup check for ios
