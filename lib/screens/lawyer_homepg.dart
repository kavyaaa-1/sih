import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:sih_project/legal_aid/lawyer_aid.dart';
import 'package:sih_project/screens/pending_case_req.dart';
import 'package:sih_project/screens/splash.dart';

import '../dbHelper/constant.dart';
import '../dbHelper/mongodb.dart';
import 'chatbot_screen.dart';
import 'lawyer_casedb.dart';

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
  //String _selectedFilter = 'Ongoing'; // Default selected filter
  Case? caseInfo;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LawyerAid(),
        ),
      );
    }

    if (index == 1) {
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
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Handle opening the menu
              },
            );
          },
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Your Cases',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Align the container to the right
            children: [
              InkWell(
                onTap: () {
                  // Handle the navigation to another page here
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        // Replace with the desired page you want to navigate to
                        return PendingCaseReq(
                          lawyerId: widget.lawyerId,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  height: 50,
                  width: 220,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications, // Use the notification bell icon
                          color: Colors.white, // Customize the icon color
                        ),
                        SizedBox(
                            width:
                                10), // Add some space between the icon and text
                        Text(
                          "New Case Requests",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                ),
              )
            ],
          ),
          // Display assigned cases based on the selected filter
          Container(
            margin: EdgeInsets.all(12.0),
            height: 160, // Adjust the height as desired
            width: double.infinity, // Takes the full width
            child: Padding(
              padding: EdgeInsets.all(12.0), // Add your desired padding here
              child: CaseCard(
                caseId: '${caseInfo?.caseId ?? 'Loading...'}',
                caseType: '${caseInfo?.caseType ?? 'Loading...'}',
                progress:
                    '${caseInfo?.isClosed ?? false ? 'Closed' : 'Ongoing'}',
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange.shade300,
                width: 1.0, // Adjust the border width as needed
              ),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
          ),

          // Add more CaseCard widgets based on the selected filter
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.deepPurpleAccent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
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
              // Replace AnotherPage with the actual page you want to navigate to
              return LawyerCaseDashboard(caseId: caseId);
            },
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
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
