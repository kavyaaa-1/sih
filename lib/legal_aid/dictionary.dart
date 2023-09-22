import 'package:flutter/material.dart';

import 'meaning.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  void _navigateToMeaningPage(String searchTerm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeaningPage(searchTerm),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20), // Add a SizedBox to create spacing below the app bar
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, // Align the heading text to the left
              children: <Widget>[
                Text(
                  'Legal Dictionary',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    // : TextAlign.left, // Align the text to the left
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Enter a legal term',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search,
                      size: 30,),
                      onPressed: () {
                        String searchTerm = _searchController.text;
                        if (searchTerm.isNotEmpty) {
                          _navigateToMeaningPage(searchTerm);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
