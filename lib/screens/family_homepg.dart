import 'package:flutter/material.dart';
import 'package:sih_project/screens/chatbot_screen.dart';

class FamilyHomePage extends StatefulWidget {
  @override
  _FamilyHomePageState createState() => _FamilyHomePageState();
}

class _FamilyHomePageState extends State<FamilyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatBotScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case Details"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        SizedBox(
          height: 40,
        ),
        Container(
          height: 130, // Adjust the height as desired
          width: double.infinity, // Takes the full width
          child: InfoCard(
            caseId: '12345',
            name: 'Julian',
            status: 'Ongoing',
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Legal Aid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat with Us',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String caseId;
  final String name;
  final String status;

  InfoCard({
    required this.caseId,
    required this.name,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 218, 201, 249),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Case ID: $caseId',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Name: $name',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
