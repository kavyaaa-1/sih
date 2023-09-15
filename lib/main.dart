import 'package:flutter/material.dart';
import 'package:sih_project/screens/select_user_type.dart';

import 'dbHelper/mongodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
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
        '/': (context) => SelectUserTypePage(),
      },
    );
  }
}

// Your existing MyHomePage and _MyHomePageState classes.
