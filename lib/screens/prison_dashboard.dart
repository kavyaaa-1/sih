import 'package:flutter/material.dart';
import 'package:sih_project/screens/add_case.dart';
import 'package:sih_project/dbHelper/mongodb.dart';
import '../dbHelper/constant.dart';
import 'case_dashboard.dart';

class PrisonDashboard extends StatefulWidget {
  final String pid;
  PrisonDashboard({required this.pid});
  @override
  _PrisonDashboardState createState() => _PrisonDashboardState();
}

class _PrisonDashboardState extends State<PrisonDashboard> {
  List<Case> _cases = [];

  @override
  void initState() {
    super.initState();
    fetchCases();
  }

  Future<void> fetchCases() async {
    final caseCollection = MongoDatabase.db.collection(CASE_COLLECTION);
    final List<Map<String, dynamic>> cases =
        await caseCollection.find().toList();

    setState(() {
      _cases = cases.map((Map<String, dynamic> caseData) {
        final caseId = caseData['case_Id'];
        final caseType = caseData['type'] ?? ' ';
        final isClosed = caseData['isClosed'] ?? false;
        return Case(caseId, caseType, isClosed);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Home Page'), // Add a title to the app bar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Text(''),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: Text("Home Page"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrisonDashboard(
                      pid: widget.pid,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Enter new case details"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CaseInfoForm(
                            pid: widget.pid,
                          )),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(height: 20.0),
                Expanded(
                    child: ListView.builder(
                  itemCount: _cases.length,
                  itemBuilder: (context, index) {
                    final caseItem = _cases[index];
                    String casestatus =
                        'Status: ${caseItem.isClosed ? 'Closed' : 'Ongoing'}';

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
                      child: ListTileWithNavigation(
                        title: 'Case ID: ${caseItem.caseId}', // Display caseId
                        subtitle:
                            'Case Type: ${caseItem.caseType}\n Status: ${casestatus}', // Display caseType
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CaseInfoForm(
                              pid: widget.pid,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "Add new case",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Case {
  final String caseId;
  final String caseType;
  final bool isClosed;

  Case(this.caseId, this.caseType, this.isClosed);
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
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 17,
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
