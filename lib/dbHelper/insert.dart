import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sih_project/dbHelper/constant.dart';

import 'mongodb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create an instance of the Lawyer class

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Insert Information'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              insertLawyer();
            },
            child: Text('Insert'),
          ),
        ),
      ),
    );
  }

  Future<void> insertLawyer() async {
    WidgetsFlutterBinding.ensureInitialized();
    await MongoDatabase.connect();
    final collection = MongoDatabase.db.collection(JUDGE_COLLECTION);
    //final collection = MongoDatabase.db.collection(LAWYER_COLLECTION);
    final data = {
      'name': '',
      'jid': '',
      'jpin': '',
      'assigned': false,
    };

    // final data = {
    //   'name': '',
    //   'lid': '',
    //   'lpin': '',
    //   'assigned': false,
    //   'phone': '7799562012',
    // };
    await collection.insert(data);
  }
}
