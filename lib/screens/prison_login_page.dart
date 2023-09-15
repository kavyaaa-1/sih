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
        title: Text('Login'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: prisonIdController,
              decoration: InputDecoration(labelText: 'Prison ID'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: pinController,
              decoration: InputDecoration(labelText: 'PIN'),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, // Background color
              ),
              child: Text('Login'),
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
