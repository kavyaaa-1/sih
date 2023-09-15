import 'package:flutter/material.dart';

import 'lawyer_homepg.dart';
class LawyerLogin extends StatefulWidget {
  @override
  _LawyerLoginState createState() => _LawyerLoginState();
}

class _LawyerLoginState extends State<LawyerLogin> {
  final TextEditingController lawyerIdController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  String errorMessage = '';

  final Map<String, String> userData = {
    'lw123': '123456', // Format: {Prison ID: PIN}
    'lw656': '456789',
  };

  void _login() {
    final lawyerId = lawyerIdController.text;
    final pin = pinController.text;

    if (pin.length != 6) {
      setState(() {
        errorMessage = 'PIN must be 6 digits';
      });
      return;
    }

    if (userData.containsKey(lawyerId) && userData[lawyerId] == pin) {
      // User authenticated, you can navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LawyerHomePage(),
        ),
      );
      print('Login successful');
    } else {
      setState(() {
        errorMessage = 'Invalid lawyer ID or PIN';
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
              controller: lawyerIdController,
              decoration: InputDecoration(labelText: 'Lawyer ID'),
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