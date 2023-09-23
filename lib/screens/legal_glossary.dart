import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LegalDictionaryPage(),
    );
  }
}

class LegalDictionaryPage extends StatefulWidget {
  @override
  _LegalDictionaryPageState createState() => _LegalDictionaryPageState();
}

class _LegalDictionaryPageState extends State<LegalDictionaryPage> {
  PageController _pageController = PageController();
  TextEditingController _searchController = TextEditingController();
  String meaning = "Loading...";
  String searchTerm = '';
  int _currentPage = 0;
  bool hasSearched = false;

  void _fetchMeaning(String searchTerm) async {
    try {
      final data = await fetchData(searchTerm);
      print(data);
      setState(() {
        hasSearched = true;
        // Parse the meaning from the API data
        if (data.containsKey("meanings")) {
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
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.deepPurpleAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Legal Dictionary',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: Color.fromARGB(255, 244, 243, 247),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                ),
                child: Container(
                  color: Colors.white10,
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: _searchController,
                            decoration: InputDecoration(
                                hintText: 'Search Term',
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      searchTerm = _searchController.text;
                                      if (searchTerm.isNotEmpty) {
                                        _fetchMeaning(searchTerm);
                                      }
                                    },
                                    icon: Icon(Icons.search))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 345,
                              height: 100,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(185, 221, 212, 238),
                                border: Border.all(
                                  color: Colors.deepPurple,
                                  width: 3,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Explore Legal Jargon: Find Definitions Effortlessly.",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 51, 51, 51),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 345,
                              height: 100,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(185, 221, 212, 238),
                                border: Border.all(
                                  color: Colors.deepPurple,
                                  width: 3,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Legal Lingo Unveiled: Your Quick Reference Guide.",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 51, 51, 51),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildPageIndicator(),
                      const SizedBox(height: 20),
                      const Text(
                        "SUGGESTED WORDS",
                        style: TextStyle(
                          color: Color.fromARGB(255, 68, 88, 98),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          wordContainer("attorney", 75),
                          wordContainer("affidavit", 70),
                          wordContainer("indictment", 80),
                          wordContainer("parole", 54),
                        ],
                      ),
                      Row(
                        children: [
                          wordContainer("bailiff", 50),
                          wordContainer("sentencing", 80),
                          wordContainer("alibi", 50),
                          wordContainer("tort", 40),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        // Wrap the meaning container with Visibility widget
                        visible:
                            hasSearched, // Show only if a search has been performed
                        child: Container(
                          padding: const EdgeInsets.all(19.0),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                searchTerm,
                                style: const TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "DEFINITION",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                meaning,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget wordContainer(String word, double w) {
    return Container(
      margin: EdgeInsets.all(5),
      width: w,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 219, 217, 217),
      ),
      child: Center(
        child: Text(
          "$word",
          style: TextStyle(
            color: Color.fromARGB(255, 68, 88, 98),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(2, (int index) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == index ? Colors.deepPurpleAccent : Colors.grey,
          ),
        );
      }),
    );
  }
}

Future<Map<String, dynamic>> fetchData(String word) async {
  final response = await http
      .get(Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data is List) {
      return data.first;
    }
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}
