import 'package:flutter/material.dart';
import 'package:sih_project/screens/family_signin_page.dart';
import 'package:sih_project/screens/lawyer_homepg.dart';

import 'login_register_page.dart';
import 'prison_login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectUserTypePage(),
    );
  }
}

class SelectUserTypePage extends StatefulWidget {
  @override
  _SelectUserTypePageState createState() => _SelectUserTypePageState();
}

class _SelectUserTypePageState extends State<SelectUserTypePage> {
  String selectedUserType = ""; // Variable to store the selected user type

  void onUserTypeSelected(String userType) {
    setState(() {
      selectedUserType = userType;
    });
  }

  void navigateToSelectedPage() {
    if (selectedUserType.isNotEmpty) {
      // Navigate to the corresponding page based on selectedUserType
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (selectedUserType == "Family") {
              return FamilySignPage();
            } else if (selectedUserType == "Prison Authority") {
              return PrisonLogin();
            } else if (selectedUserType == "Lawyer") {
              return LawyerHomePage();
            } else if (selectedUserType == "Judge") {
              return LoginRegisterPage(selectedUserType);
            } else {
              return Container(); // Handle other cases as needed
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1), // Add space at the top
              child: Text(
                "Select User Type",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16),
              child: UserTypeGrid(
                onUserTypeSelected: onUserTypeSelected,
                selectedUserType: selectedUserType,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.deepPurple,
              ),
              child: ElevatedButton(
                onPressed: navigateToSelectedPage,
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserTypeGrid extends StatelessWidget {
  final Function(String) onUserTypeSelected;
  final String selectedUserType;

  UserTypeGrid(
      {required this.onUserTypeSelected, required this.selectedUserType});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        UserTypeTile(
          key: ValueKey<String>("Family"),
          icon: Icons.family_restroom,
          text: "Family",
          onUserTypeSelected: onUserTypeSelected,
          isSelected: selectedUserType == "Family",
        ),
        UserTypeTile(
          key: ValueKey<String>("Prison Authority"),
          icon: Icons.business,
          text: "Prison Authority",
          onUserTypeSelected: onUserTypeSelected,
          isSelected: selectedUserType == "Prison Authority",
        ),
        UserTypeTile(
          key: ValueKey<String>("Lawyer"),
          icon: Icons.person,
          text: "Lawyer",
          onUserTypeSelected: onUserTypeSelected,
          isSelected: selectedUserType == "Lawyer",
        ),
        UserTypeTile(
          key: ValueKey<String>("Judge"),
          icon: Icons.gavel,
          text: "Judge",
          onUserTypeSelected: onUserTypeSelected,
          isSelected: selectedUserType == "Judge",
        ),
      ],
    );
  }
}

class UserTypeTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function(String) onUserTypeSelected;
  final bool isSelected;

  UserTypeTile({
    required Key key,
    required this.icon,
    required this.text,
    required this.onUserTypeSelected,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          onUserTypeSelected(text);
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 36,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 8),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
