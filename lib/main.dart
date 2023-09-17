import 'package:flutter/material.dart';
import 'package:sih_project/screens/hearing_details.dart';
import 'package:sih_project/screens/judge_homepg.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      initialRoute: '/', // Define your initial route
      routes: {
        '/': (context) => HearingDetails(),
      },
    );
  }
}
