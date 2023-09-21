import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MeaningPage extends StatefulWidget {
  final String searchTerm;

  MeaningPage(this.searchTerm);

  @override
  _MeaningPageState createState() => _MeaningPageState();
}

class _MeaningPageState extends State<MeaningPage> {
  String meaning = "Loading..."; // Default message while data is fetched

  @override
  void initState() {
    super.initState();
    _fetchMeaning(widget.searchTerm);
  }

  void _fetchMeaning(String searchTerm) async {
    try {
      final data = await fetchData(searchTerm);
      print(data);
      setState(() {
        // Parse the meaning from the API data
        if (data is Map && data.containsKey("meanings")) {
          final meanings = data["meanings"] as List<dynamic>;
          if (meanings.isNotEmpty) {
            final firstMeaning = meanings[0];
            final definitions = firstMeaning["definitions"] as List<dynamic>;
            if (definitions.isNotEmpty) {
              final firstDefinition = definitions[0];
              meaning = firstDefinition["definition"] ?? "No definition found.";
            } else {
              meaning = "No definition found.";
            }
          } else {
            meaning = "No definition found.";
          }
        } else {
          meaning = "No definition found.";
        }
      });
    } catch (e) {
      // Handle any errors or exceptions here
      print('Error: $e');
      setState(() {
        meaning = "Failed to fetch meaning.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40,),
            Text(
              widget.searchTerm,
              style: TextStyle(
                fontSize:50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "DEFINITION",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              meaning,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchData(String word) async {
  final response = await http.get(Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    final data = json.decode(response.body);
    if (data is List) {
      return data.first; // Use the first entry if multiple entries are returned
    }
    return data;
  } else {
    // If the server did not return a 200 OK response, throw an exception
    throw Exception('Failed to load data');
  }
}
