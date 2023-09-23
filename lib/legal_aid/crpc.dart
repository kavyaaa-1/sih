import 'package:flutter/material.dart';

class CRPC extends StatefulWidget {
  @override
  _CRPCState createState() => _CRPCState();
}

class _CRPCState extends State<CRPC> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code of Criminal Procedure (CrPC)'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search by Section Number',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            ..._buildSectionTiles(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSectionTiles() {
    List<Widget> sectionTiles = [];
    for (var section in sections) {
      if (_searchText.isEmpty ||
          section['id']!.toLowerCase().contains(_searchText.toLowerCase())) {
        sectionTiles.add(
          CustomTile(
            title: section['title'],
            description: section['description'],
          ),
        );
      }
    }
    return sectionTiles;
  }
}

class CustomTile extends StatelessWidget {
  final String? title;
  final String? description;

  CustomTile({this.title, this.description});

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
                  title ?? 'Title not available',
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
                description ?? 'Description not available',
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

List<Map<String, String>> sections = [
  {
    "id": "1",
    "title": "Section 1 of CrPC",
    "description":
        "This is the introductory section that defines the title and extent of the Code of Criminal Procedure (CrPC).",
  },
  {
    "id": "2",
    "title": "Section 2 of CrPC",
    "description":
        "Every person shall be liable to punishment under this Code and not otherwise for every act or omission contrary to the provisions thereof, of which he shall be guilty within India.",
  },
  {
    "id": "3",
    "title": "Section 3 of CrPC",
    "description":
        "The provisions of this Code apply to any offense committed by any citizen of India abroad.",
  },
  {
    "id": "4",
    "title": "Section 4 of CrPC",
    "description":
        "This section deals with the definition of the term 'offense' under the CrPC.",
  },
  {
    "id": "5",
    "title": "Section 5 of CrPC",
    "description":
        "This section specifies that certain special laws and local laws are exempted from the applicability of the CrPC.",
  },
  {
    "id": "6",
    "title": "Section 6 of CrPC",
    "description":
        "In this section, 'public servant' is defined for the purpose of the CrPC.",
  },
  {
    "id": "7",
    "title": "Section 7 of CrPC",
    "description":
        "This section defines the term 'Judge' as it applies to the CrPC.",
  },
  {
    "id": "8",
    "title": "Section 8 of CrPC",
    "description":
        "In this section, 'Court of Justice' is defined for the purpose of the CrPC.",
  },
  {
    "id": "9",
    "title": "Section 9 of CrPC",
    "description":
        "This section defines the term 'offense' as it applies to the CrPC.",
  },
  {
    "id": "10",
    "title": "Section 10 of CrPC",
    "description":
        "This section specifies that the words 'inquiry' and 'trial' include every inquiry, trial, and other proceedings.",
  },
  {
    "id": "11",
    "title": "Section 11 of CrPC",
    "description":
        "In this section, 'person' is defined to include any company or association or body of persons, whether incorporated or not.",
  },
  // Add more sections as needed
];
