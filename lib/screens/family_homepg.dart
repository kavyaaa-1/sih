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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Case Details',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 130,
              width: double.infinity,
              child: InfoCard(
                caseId: '12345',
                name: 'Julian',
                status: 'Ongoing',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 40, // Adjust the icon size
              ),
              label: 'Dashboard',
              // You can customize the label style here
              // For example, to increase the font size:
              // labelStyle: TextStyle(fontSize: 18),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
                size: 40, // Adjust the icon size
              ),
              label: 'Legal Aid',
              // You can customize the label style here
              // For example, to increase the font size:
              // labelStyle: TextStyle(fontSize: 18),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                size: 40, // Adjust the icon size
              ),
              label: 'Chat with Us',
              // You can customize the label style here
              // For example, to increase the font size:
              // labelStyle: TextStyle(fontSize: 18),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          onTap: _onItemTapped,
        ),
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
      color: Color.fromARGB(255, 255,255,255),
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
