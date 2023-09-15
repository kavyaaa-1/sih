//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:sih_project/screens/family_homepg.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:sih_project/screens/case_dashboard.dart';
import 'package:sih_project/dbHelper/mongodb.dart';
import '../dbHelper/constant.dart';


class FamilyLogInPage extends StatefulWidget {
  @override
  _FamilyLogInPageState createState() => _FamilyLogInPageState();
}

class _FamilyLogInPageState extends State<FamilyLogInPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoginButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(_updateLoginButtonState);
    _passwordController.addListener(_updateLoginButtonState);
  }

  void _updateLoginButtonState() {
    setState(() {
      // Enable the login button if phone number is 10 digits and password is not empty
      isLoginButtonEnabled = _isTenDigitNumber(_phoneNumberController.text) &&
          _passwordController.text.isNotEmpty;
    });
  }

  bool _isTenDigitNumber(String text) {
    if (text.isEmpty) {
      return false;
    }
    return int.tryParse(text) != null && text.length == 10;
  }

  // Function to verify user credentials
  Future<bool> _verifyCredentials(String phoneNumber, String password) async {
    // MongoDB connection setup
    final db = await mongo_dart.Db.create(MONGO_CONN_URL); // Replace with your MongoDB URL
    await db.open();

    final collection = await db.collection(USER_COLLECTION);

    // Query for admin with matching phone_no and password
    final query = mongo_dart.where
        .eq('phone', phoneNumber)
        .eq('pswd', password);

    final admins = await collection.find(query).toList();

    // Close the MongoDB connection
    await db.close();

    // Return true if valid credentials, false otherwise
    return admins.isNotEmpty;
  }

  void _performLogin() async {
    final phoneNumber = _phoneNumberController.text;
    final password = _passwordController.text;

    // Verify user credentials
    final isValidCredentials = await _verifyCredentials(phoneNumber, password);

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
                  MaterialPageRoute(builder: (context) => FamilyHomePage()),
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
        title: Text(
          'Log In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter Details', // Added label "Enter Details"
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              _buildTextField(
                _phoneNumberController,
                'Phone Number',
                TextInputType.phone,
              ),
              SizedBox(height: 10),
              _buildTextField(
                _passwordController,
                'Password',
                TextInputType.text,
                isPassword: true,
              ),
              SizedBox(height: 40),
              ElevatedButton(

                onPressed: isLoginButtonEnabled ? _performLogin : null,
                style: ElevatedButton.styleFrom(
                  primary:
                  isLoginButtonEnabled ? Colors.deepPurple : Colors.grey,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(200, 60),
                ),
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      TextInputType keyboardType, {
        bool isPassword = false,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
