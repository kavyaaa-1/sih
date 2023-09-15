import 'package:flutter/material.dart';
import 'package:sih_project/dbHelper/mongodb.dart';

import '../dbHelper/family_data_model.dart';
import 'family_homepg.dart';
import 'family_login_page.dart';

// Define a list of valid Case IDs
final List<String> validCaseIDs = ['123456', '789012', '345678'];

class FamilySignPage extends StatefulWidget {
  @override
  _FamilySignPageState createState() => _FamilySignPageState();
}

class _FamilySignPageState extends State<FamilySignPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _caseIdController = TextEditingController();
  bool isLoginButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(_updateLoginButtonState);
    _passwordController.addListener(_updateLoginButtonState);
    _caseIdController.addListener(_updateLoginButtonState);
  }

  void _updateLoginButtonState() {
    setState(() {
      // Enable the login button if phone number is 10 digits and other fields are not empty
      isLoginButtonEnabled = _isTenDigitNumber(_phoneNumberController.text) &&
          _isSixDigitNumber(_caseIdController.text) &&
          _passwordController.text.isNotEmpty;
    });
  }

  bool _isTenDigitNumber(String text) {
    if (text.isEmpty) {
      return false;
    }
    return int.tryParse(text) != null && text.length == 10;
  }

  bool _isSixDigitNumber(String text) {
    if (text.isEmpty) {
      return false;
    }
    return int.tryParse(text) != null && text.length == 6;
  }

  // Function to check if the entered Case ID is valid
  bool _isValidCaseID(String caseID) {
    return validCaseIDs.contains(caseID);
  }

  // Function to insert data into MongoDB
  void _insertData(String phoneNumber, String password, String caseID) async {
    // Check if the Case ID is valid
    if (_isValidCaseID(caseID)) {
      final Family family = Family(
        phone: phoneNumber,
        pswd: password,
        caseId: caseID,
      );

      // Insert data into the MongoDB collection
      await MongoDatabase.familyCollection.insert(family.toJson());

      // Close the MongoDB connection
      await MongoDatabase.db.close();

      // Show a success message or navigate to a success page
      print('Data inserted successfully.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registered Successfully'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.deepPurple,
      ));
    } else {
      // Show an error message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Case ID'),
            content: Text('The entered Case ID is not valid.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 19),
              _buildTextField(
                  _phoneNumberController, 'Phone Number', TextInputType.phone),
              SizedBox(height: 10),
              _buildTextField(
                  _passwordController, 'Password', TextInputType.text,
                  isPassword: true),
              SizedBox(height: 10),
              _buildTextField(
                  _caseIdController, '6 digit Case ID', TextInputType.number),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoginButtonEnabled ? _handleLogin : null,
                style: ElevatedButton.styleFrom(
                  primary: isLoginButtonEnabled
                      ? Colors.deepPurple
                      : Colors.purpleAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(200, 60),
                ),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  // Navigate to the Sign In page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FamilyLogInPage(),
                    ),
                  );
                },
                child: Text(
                  "Already registered? Log In",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    final String phoneNumber = _phoneNumberController.text;
    final String password = _passwordController.text;
    final String caseID = _caseIdController.text;

    // Insert data into MongoDB and handle validation
    _insertData(phoneNumber, password, caseID);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FamilyHomePage(),
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
    _caseIdController.dispose();
    super.dispose();
  }
}
