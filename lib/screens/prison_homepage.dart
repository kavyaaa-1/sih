import 'package:flutter/material.dart';
import 'package:sih_project/screens/add_case.dart';
import 'package:sih_project/dbHelper/mongodb.dart';
import 'package:sih_project/screens/splash.dart';
import '../dbHelper/constant.dart';
import 'case_dashboard.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;

class PrisonDashboard extends StatefulWidget {
  final String pid;
  PrisonDashboard({required this.pid});
  @override
  _PrisonDashboardState createState() => _PrisonDashboardState();
}

Future<List<Map<String, dynamic>>> fetchCaseInfoFromDatabase(String pid) async {
  final caseCollection = MongoDatabase.db.collection(CASE_COLLECTION);

  final List<Map<String, dynamic>> caseData =
      await caseCollection.find(mongo_dart.where.eq('PID', pid)).toList();

  return caseData;
}

class _PrisonDashboardState extends State<PrisonDashboard> {
  List<Case> _cases = [];

  void loadCaseInfo() async {
    final fetchedCaseInfo = await fetchCaseInfoFromDatabase(widget.pid);

    setState(() {
      _cases = fetchedCaseInfo
          .map((data) => Case(
                caseId: data['case_Id'] ?? ' ',
                caseType: data['type'] ?? ' ',
                isClosed: data['isClosed'] ?? false,
              ))
          .toList();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Cases",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _cases.length,
                    separatorBuilder: (BuildContext context, int index) {
                      // Add a 10-pixel gap between the cards
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      final caseItem = _cases[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to CaseDashboard and pass the case ID
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CaseInfoDashboard(caseId: caseItem.caseId),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Colors.orange.shade200, // Orange border color
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTileWithNavigation(
                            title: 'Case ID: ${caseItem.caseId}',
                            subtitle:
                                'Case Type: ${caseItem.caseType}\nStatus: ${caseItem.isClosed ? 'Closed' : 'Ongoing'}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.psychology,
              size: 40,
            ),
            label: 'Rehabilitation Program',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 40,
            ),
            label: 'Add Case',
          ),
        ],
        currentIndex: 0,
        backgroundColor: Colors.deepPurpleAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (int index) {
          if (index == 0) {
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CaseInfoForm(
                  pid: widget.pid,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class Case {
  final String caseId;
  final String caseType;
  final bool isClosed;

  Case({required this.caseId, required this.caseType, required this.isClosed});
}

class ListTileWithNavigation extends StatelessWidget {
  final String title;
  final String subtitle;

  ListTileWithNavigation({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
    );
  }
}
