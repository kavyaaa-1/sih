import 'package:flutter/material.dart';
import 'package:sih_project/screens/case_dashboard.dart';
import 'package:sih_project/screens/chatbot_screen.dart';
import '../dbHelper/constant.dart';
import 'package:sih_project/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;

class FamilyHomePage extends StatefulWidget {
  final List data;

  FamilyHomePage({required this.data});

  @override
  _FamilyHomePageState createState() => _FamilyHomePageState();
}

class _FamilyHomePageState extends State<FamilyHomePage> {
  int _selectedIndex = 0;
  String phonenum = '';

  @override
  void initState() {
    super.initState();
    callLawyer();
  }

  void callLawyer() async {
    await getLawyer();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatBotScreen(),
        ),
      );
    }
  }

  Future<void> getLawyer() async {
    final query = mongo_dart.where.eq('lid', widget.data[0]['LID']);

    final lawyers = await MongoDatabase.db
        .collection(LAWYER_COLLECTION)
        .find(query)
        .toList();

    setState(() {
      phonenum = lawyers[0]['phone'];
    });  
  }

  @override
  Widget build(BuildContext context) {
    print(phonenum);
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
              height: 160,
              width: double.infinity,
              child: InfoCard(
                caseId: widget.data[0]['case_Id'].toString(),
                name: widget.data[0]['prisoner_name'].toString(),
                status: (widget.data[0]['isClosed']) ? "Closed" : 'Ongoing',
                phonenum: phonenum,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
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

  // _launchPhoneCall(String phoneNumber) async {
  //   final phoneUrl = 'tel:$phoneNumber';
  //   if (await canLaunch(phoneUrl)) {
  //     await launch(phoneUrl);
  //   } else {
  //     throw 'Could not launch $phoneUrl';
  //   }
  // }
}

class InfoCard extends StatelessWidget {
  final String caseId;
  final String name;
  final String status;
  final String phonenum;

  InfoCard({
    required this.caseId,
    required this.name,
    required this.status,
    required this.phonenum,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the new page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CaseInfoDashboard(caseId: caseId), // Replace with your new page
          ),
        );
      },
      child: Expanded(
        child: Card(
          color: Color.fromARGB(255, 255, 255, 255),
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
                
                Text(
                  "Lawyer's phone number:${phonenum}",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
