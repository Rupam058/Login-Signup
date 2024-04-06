import 'package:flutter/material.dart';
import 'package:login_signup/dashboard.dart';
import 'package:login_signup/helper.dart';
import 'package:login_signup/main.dart';
import 'package:login_signup/routes/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAccessToken();
  }
  // Logic for checking loggin auth

  Future<void> checkAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken') ?? '';
    String refreshToken = prefs.getString('refreshToken') ?? '';

    if (accessToken == '' || refreshToken == '') {
      prefs.clear();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RegistrationPage()),
          (Route<dynamic> route) => false,
        );
      }
    }

    final response = await apiFetch('/auth/splashscreen/', accessToken, null);

    if (response['status'] != null && response['status'] == 'success') {
      scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(response['message']),
      ));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashBoard()),
        (Route<dynamic> route) => false,
      );
      return;
    } else if (response['status'] != null && response['status'] == 'error') {
      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
      final accessTokenResponse =
          await apiFetch('/auth/tokens/', refreshToken, null);
      prefs.clear();
      if (accessTokenResponse['status'] != null &&
          accessTokenResponse['status'] == 'success') {
        await addToSharedPrefs(
          accessTokenResponse['Authorization'][0],
          refreshToken,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashBoard()),
          (Route<dynamic> route) => false,
        );
        return;
      } else {
        prefs.clear();
        if (mounted) {
          scaffoldMessengerKey.currentState!.showSnackBar(
              SnackBar(content: Text(accessTokenResponse['message'])));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => RegistrationPage()),
            (Route<dynamic> route) => false,
          );
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
