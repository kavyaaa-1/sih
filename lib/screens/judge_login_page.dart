import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:sih_project/dbHelper/mongodb.dart';
import '../dbHelper/constant.dart';
import 'judge_homepg.dart';

class JudgeLogin extends StatefulWidget {
  @override
  _JudgeLoginState createState() => _JudgeLoginState();
}

class _JudgeLoginState extends State<JudgeLogin> {
  final TextEditingController judgeIdController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  String errorMessage = '';

  final String userCollection = JUDGE_COLLECTION;

  Future<bool> _verifyCredentials(String judgeId, String pin) async {
    final collection = MongoDatabase.db.collection(userCollection);

    final query = mongo_dart.where.eq('jid', judgeId).eq('jpin', pin);

    final users = await collection.find(query).toList();

    return users.isNotEmpty;
  }

  void _login() async {
    final jid = judgeIdController.text;
    final jpin = pinController.text;

    final isValidCredentials = await _verifyCredentials(jid, jpin);

    if (isValidCredentials) {
      // Successful login
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Login'),
          content: const Text('Login successful'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                // Navigate to the main dashboard or another page as needed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JudgeHomePage()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Invalid credentials
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Login'),
          content: const Text('Invalid credentials'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Judge Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/law_3122321.png', // Replace with your image path
              width: 125.0, // Adjust the image width as needed
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Judge Login',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: judgeIdController,
              decoration: InputDecoration(labelText: 'Judge ID'),
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
