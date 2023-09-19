import 'package:flutter/material.dart';
import 'package:sih_project/dbHelper/constant.dart';
import 'package:sih_project/dbHelper/mongodb.dart';
import 'package:sih_project/screens/family_homepg.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;

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

  List data = [];

  // Function to verify user credentials
  Future<bool> _verifyCredentials(String phoneNumber, String password) async {
    // Query for admin with matching phone_no and password
    final query =
        mongo_dart.where.eq('phone', phoneNumber).eq('pswd', password);

    final admins = await MongoDatabase.familyCollection.find(query).toList();

    if (admins.isEmpty) return false;

    String caseID = admins[0]["case_ID"];

    final query2 = mongo_dart.where.eq('case_Id', caseID);

    data = await MongoDatabase.db
        .collection(CASE_COLLECTION)
        .find(query2)
        .toList();

    return data.isNotEmpty;
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
                  MaterialPageRoute(
                      builder: (context) => FamilyHomePage(
                            data: data,
                          )),
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
          'Family Login',
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        // Wrap the content in SingleChildScrollView
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50), // Add a SizedBox for spacing at the top
                Image.asset(
                  'images/family.png',
                  width: 130,
                ),
                SizedBox(height: 20), // Add spacing between the image and text
                const Text(
                  'Enter Details',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: isLoginButtonEnabled ? _performLogin : null,
                  style: ElevatedButton.styleFrom(
                    primary:
                        isLoginButtonEnabled ? Colors.deepPurpleAccent : Colors.grey,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(200, 60),
                  ),
                  child: const Text(
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
