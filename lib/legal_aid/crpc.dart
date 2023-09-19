import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legal Information',
      theme: ThemeData(
        primaryColor: Color(0xff8336f4),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: JsonSearchApp(),
    );
  }
}

class JsonSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CrPC'),
        backgroundColor: Color(0xff8336f4),
      ),
      body: Column(
        children: <Widget>[
          CustomTile(
            title: 'Random Title 1',
            description: 'Random description for Tile 1',
          ),
          CustomTile(
            title: 'Random Title 2',
            description: 'Random description for Tile 2',
          ),
        ],
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final String description;

  CustomTile({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: Color(0xff8336f4),
            width: 1.5,
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  top: 8.0,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8336f4),
                  ),
                ),
              ),
              Divider(
                color: Color(0xff8336f4),
                thickness: 1.0,
              ),
              Text(
                description,
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
