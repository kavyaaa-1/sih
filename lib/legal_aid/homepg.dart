import 'package:flutter/material.dart';
// import 'page2.dart';
// import 'page3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adjust the margin as needed
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Space evenly between tiles
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // Stretch tiles to fill the screen width
          children: <Widget>[
            Expanded(
              child: TileWidget(
                  color: Color(0xff8336f4), text: 'Indian Penal Code'),
            ),
            SizedBox(height: 16), // Add spacing here
            Expanded(
              child: TileWidget(color: Color(0xff8336f4), text: 'CrPC'),
            ),
            SizedBox(height: 16), // Add spacing here
            Expanded(
              child: TileWidget(color: Color(0xff8336f4), text: 'Evidence Act'),
            ),
          ],
        ),
      ),
    );
  }
}

class TileWidget extends StatelessWidget {
  final Color color;
  final String text;

  TileWidget({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
