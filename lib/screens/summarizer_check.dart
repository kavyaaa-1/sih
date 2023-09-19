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
          title: Text('Text Summarizer'),
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
  String summary = "";

  // Function to send the text and get the summary
  Future<void> summarizeText() async {
    String inputText = textController.text;
    var response = await http.post(
      Uri.parse('http://127.0.0.1:5000/summarize'),
      body: jsonEncode(<String, String>{
        'text': inputText,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        summary = jsonDecode(response.body)['summary'];
      });
    } else {
      print('Error: ${response.reasonPhrase}');
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
              labelText: 'Enter the text to be summarized:',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await summarizeText();
          },
          child: Text('Generate Summary'),
        ),
        if (summary != '')
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Generated Summary:\n$summary",
              style: TextStyle(fontSize: 16),
            ),
          ),
      ],
    );
  }
}