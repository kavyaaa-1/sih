import 'package:flutter/material.dart';
import 'judge_homepg.dart';

class JudgeLogin extends StatefulWidget {
  @override
  _JudgeLoginState createState() => _JudgeLoginState();
}

class _JudgeLoginState extends State<JudgeLogin> {
  final TextEditingController judgeIdController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  String errorMessage = '';

  final Map<String, String> userData = {
    'jd123': '123456', // Format: {Prison ID: PIN}
    'jd656': '456789',
  };

  void _login() {
    final judgeId = judgeIdController.text;
    final pin = pinController.text;

    if (pin.length != 6) {
      setState(() {
        errorMessage = 'PIN must be 6 digits';
      });
      return;
    }

    if (userData.containsKey(judgeId) && userData[judgeId] == pin) {
      // User authenticated, you can navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JudgeHomePage(),
        ),
      );
      print('Login successful');
    } else {
      setState(() {
        errorMessage = 'Invalid judge ID or PIN';
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
              controller: judgeIdController,
              decoration: InputDecoration(labelText: 'Judge ID'),
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