import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'prison_dashboard.dart'; // Import your prison dashboard page
import '../dbHelper/mongodb.dart'; // Import your MongoDB configuration
import '../dbHelper/constant.dart';


class PrisonLogin extends StatefulWidget {
  @override
  _PrisonLoginState createState() => _PrisonLoginState();
}

class _PrisonLoginState extends State<PrisonLogin> {
  final TextEditingController prisonIdController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  String errorMessage = '';

  // Define your MongoDB collection name
  final String userCollection = POLICE_COLLECTION;

  Future<bool> _verifyCredentials(String prisonId, String pin) async {
    final collection = MongoDatabase.db.collection(userCollection);

    final query = mongo_dart.where.eq('pid', prisonId).eq('ppin', pin);

    final users = await collection.find(query).toList();

    await MongoDatabase.db.close();

    return users.isNotEmpty;
  }

  void _login() async {
    final prisonId = prisonIdController.text;
    final pin = pinController.text;

    // if (pin.length != 6) {
    //   setState(() {
    //     errorMessage = 'PIN must be 6 digits';
    //   });
    //   return;
    // }

    final isValidCredentials = await _verifyCredentials(prisonId, pin);

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
                  MaterialPageRoute(builder: (context) => PrisonDashboard()),
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
          content: const Text('Invalid prison ID or PIN'),
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
