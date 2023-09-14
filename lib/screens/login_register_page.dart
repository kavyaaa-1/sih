import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatelessWidget {
  final String selectedUserType;

  LoginRegisterPage(this.selectedUserType);

  @override
  Widget build(BuildContext context) {
    // Implement your login/register UI based on the selectedUserType
    // For example, you can conditionally display different forms or widgets
    // based on whether the user is a Family, Prison Authority, Lawyer, or Judge.
    return Scaffold(
      appBar: AppBar(
        title: Text("Login/Register"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "User Type: $selectedUserType",
              style: TextStyle(fontSize: 24),
            ),
            // Implement login/register UI components here based on selectedUserType
          ],
        ),
      ),
    );
  }
}
