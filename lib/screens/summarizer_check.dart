import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bail Predictor'),
        ),
        body: SummarizerApp(),
      ),
    );
  }
}

class SummarizerApp extends StatefulWidget {
  @override
  _SummarizerAppState createState() => _SummarizerAppState();
}

class _SummarizerAppState extends State<SummarizerApp> {
  TextEditingController textController = TextEditingController();
  var score;

  // Function to send the text and get the summary
  Future<void> summarizeText() async {
    String inputText = textController.text;
    try {
      var response = await http.post(
        Uri.parse('https://sih-api.azurewebsites.net/predict'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept' : '*/*',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
        body: jsonEncode(<String, String>{
          'user_input': inputText,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('confidence_score')) {
          setState(() {
            score = jsonResponse['confidence_score'];
          });
        } else {
          print('Response does not contain confidence_score.');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: textController,
            maxLines: 10,
            decoration: InputDecoration(
              labelText: 'Enter the text:',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await summarizeText();
            //print(score);
          },
          child: Text('Generate Score'),
        ),
        if (score != null)
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Generated Score:\n$score",
              style: TextStyle(fontSize: 16),
            ),
          ),
      ],
    );
  }
}
