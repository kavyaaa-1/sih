import 'package:flutter/material.dart';

class FamilySignInPage extends StatefulWidget {
  @override
  _FamilySignInPageState createState() => _FamilySignInPageState();
}

class _FamilySignInPageState extends State<FamilySignInPage> {
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
      // Enable the login button if phone number is 10 digits and other fields are not empty
      isLoginButtonEnabled = _isTenDigitNumber(_phoneNumberController.text) &&
          _passwordController.text.isNotEmpty;
    });
  }

  bool _isTenDigitNumber(String text) {
    if (text == null || text.isEmpty) {
      return false;
    }
    return int.tryParse(text) != null && text.length == 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Sign In',
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(
                  _phoneNumberController, 'Phone Number', TextInputType.phone),
              SizedBox(height: 10),
              _buildTextField(
                  _passwordController, 'Password', TextInputType.text,
                  isPassword: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoginButtonEnabled ? () {} : null,
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
                  "Sign In",
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
