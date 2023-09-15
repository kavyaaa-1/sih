import 'package:flutter/material.dart';
import 'package:sih_project/screens/lawyer_homepg.dart';
import 'package:sih_project/screens/select_user_type.dart';
import 'package:sih_project/utils/routes.dart'; // Import the file where SelectUserTypePage is defined

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Define your initial route
      routes: {
        //'/': (context) => MyHomePage(title: 'Your App Title'), // Your existing home page
        //'/': (context) => SelectUserTypePage(),
        '/': (context) => LawyerHomePage(),
      },
    );
  }
}

// Your existing MyHomePage and _MyHomePageState classes.
