import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sih_project/screens/select_user_type.dart';

import '../dbHelper/mongodb.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    WidgetsFlutterBinding.ensureInitialized();
    await MongoDatabase.connect();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SelectUserTypePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromRGBO(101, 31, 254, 1.0), // Set the background color
      body: Center(
        child: Container(
          width: 300, // Set the width as per your requirements
          height: 300, // Set the height as per your requirements
          child: Image.asset(
              "images/logo.png"), // Replace with your image asset path
        ),
      ),
    );
  }
}
