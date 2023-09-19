import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:sih_project/screens/splash.dart';

import '../dbHelper/constant.dart';
import '../dbHelper/mongodb.dart';
import 'case_dashboard.dart';
import 'chatbot_screen.dart';

class LawyerHomePage extends StatefulWidget {
  final String lawyerId;
  LawyerHomePage({required this.lawyerId});

  @override
  _LawyerHomePageState createState() => _LawyerHomePageState();
}

class Case {
  final String caseId;
  final String caseType;
  final bool isClosed;

  Case({required this.caseId, required this.caseType, required this.isClosed});
}

Future<Map<String, dynamic>?> fetchCaseInfoFromDatabase(String lawyerId) async {
  final caseCollection = MongoDatabase.db.collection(CASE_COLLECTION);

  final Map<String, dynamic>? caseData = await caseCollection.findOne(
    mongo_dart.where.eq('LID', lawyerId),
  );
  return caseData;
}

class _LawyerHomePageState extends State<LawyerHomePage> {
  String _selectedFilter = 'Ongoing'; // Default selected filter
  Case? caseInfo;
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
        ),
      );
    }
  }

  void loadCaseInfo() async {
    final fetchedCaseInfo = await fetchCaseInfoFromDatabase(widget.lawyerId);
    setState(() {
      caseInfo = Case(
        caseId: fetchedCaseInfo?['case_Id'] ?? ' ',
        caseType: fetchedCaseInfo?['type'] ?? ' ',
        isClosed: fetchedCaseInfo?['isClosed'] ?? false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    loadCaseInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await MongoDatabase.db.close();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => splash(),
              ));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Your Cases',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: <String>[
                    'Ongoing',
                    'Past',
                  ].map((String filter) {
                    return DropdownMenuItem<String>(
                      value: filter,
                      child: Text(filter),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Display assigned cases based on the selected filter
            Container(
              height: 130, // Adjust the height as desired
              width: double.infinity, // Takes the full width
              child: CaseCard(
                caseId: '${caseInfo?.caseId ?? 'Loading...'}',
                caseType: '${caseInfo?.caseType ?? 'Loading...'}',
                progress:
                    '${caseInfo?.isClosed ?? false ? 'Closed' : 'Ongoing'}',
              ),
            ),
            // Add more CaseCard widgets based on the selected filter
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
                size: 40,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
                size: 40,
              ),
              label: 'Legal Aid',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                size: 40,
              ),
              label: 'Chat with Us',
            ),

          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.deepPurpleAccent,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class CaseCard extends StatelessWidget {
  final String caseId;
  final String caseType;
  final String progress;

  CaseCard({
    required this.caseId,
    required this.caseType,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another page when the card is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              // Replace `AnotherPage` with the actual page you want to navigate to
              return CaseInfoDashboard(caseId: caseId);
            },
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              Text(
                'Case ID: $caseId',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Case Type: $caseType',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Progress: $progress',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios), // Add the forward arrow icon
        ),
      ),
    );
  }
}
