import 'package:flutter/material.dart';

import 'prison_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrisonLogin(),
    );
  }
}

class PrisonLogin extends StatefulWidget {
  @override
  _PrisonLoginState createState() => _PrisonLoginState();
}

class _PrisonLoginState extends State<PrisonLogin> {
  final TextEditingController prisonIdController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  String errorMessage = '';

  final Map<String, String> userData = {
    'prison123': '123456', // Format: {Prison ID: PIN}
    'prison656': '456789',
  };

  void _login() {
    final prisonId = prisonIdController.text;
    final pin = pinController.text;

    if (pin.length != 6) {
      setState(() {
        errorMessage = 'PIN must be 6 digits';
      });
      return;
    }

    if (userData.containsKey(prisonId) && userData[prisonId] == pin) {
      // User authenticated, you can navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrisonDashboard(),
        ),
      );
      print('Login successful');
    } else {
      setState(() {
        errorMessage = 'Invalid prison ID or PIN';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/police_7210669.png', // Replace with your image path
              width: 125.0, // Adjust the image width as needed
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Prison Login',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: prisonIdController,
              decoration: InputDecoration(labelText: 'Prison ID'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: pinController,
              decoration: InputDecoration(labelText: 'PIN'),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent, // Background color
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
