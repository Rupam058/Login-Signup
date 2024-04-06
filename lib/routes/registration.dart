import 'package:flutter/material.dart';
import 'package:login_signup/routes/login.dart';
import 'package:login_signup/routes/signup.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyLoginPage(),
                        ),
                      )
                    },
                child: const Text("Login")),
            ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MySignupPage(),
                        ),
                      )
                    },
                child: const Text("Signup"))
          ],
        ),
      ),
    );
    ;
  }
}
