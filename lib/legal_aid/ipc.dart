import 'dart:convert';
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
        primaryColor: Color(0xff8336f4), // Light purple as the primary color
        scaffoldBackgroundColor: Colors.white,
      ),
      home: JsonSearchApp(),
    );
  }
}

class JsonSearchApp extends StatefulWidget {
  @override
  _JsonSearchAppState createState() => _JsonSearchAppState();
}

class _JsonSearchAppState extends State<JsonSearchApp> {
  final jsonLString = '''
    [
      {
        "id": "Section 2 in The Indian Penal Code",
        "text": ["Every person shall be liable to punishment under this Code and not otherwise for every act or omission contrary to the provisions thereof, of which he shall be guilty within India."]
      },
      {
        "id": "Section 3 in The Indian Penal Code",
        "text": ["Any person liable, by any Indian law to be tried for an offence committed beyond India shall be dealt with according to the provisions of this Code for any act committed beyond India in the same manner as if such act had been committed within India."]
      }
    ]
  ''';

  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    data = jsonDecode(jsonLString);
  }

  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  void search(String query) {
    setState(() {
      searchResults = data.where((item) {
        String id = item['id'].toString().toLowerCase();
        return id.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('IPC Sections'), backgroundColor: Color(0xff8336f4)),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                search(query);
              },
              decoration: InputDecoration(
                  labelText: 'Search by Section ID',
                  hintText: 'Enter a section ID',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Card(
                    margin: EdgeInsets.all(16), // Add margin
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6), // Add rounded borders
                      side: BorderSide(
                          color: Color(0xff8336f4),
                          width: 1.5), // Increase border width
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0,
                                top:
                                    8.0), // Add space between title and description
                            child: Text(
                              searchResults[index]['id'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff8336f4)),
                            ),
                          ),
                          Divider(
                            color: Color(0xff8336f4),
                            thickness: 1.0, // Increase line thickness
                          ),
                          Text(
                            searchResults[index]['text'][0],
                          ),
                          SizedBox(
                              height:
                                  8), // Add space between description and line
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
