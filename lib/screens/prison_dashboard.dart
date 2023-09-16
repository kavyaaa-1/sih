import 'package:flutter/material.dart';
import 'package:sih_project/screens/add_case.dart';
import 'package:sih_project/screens/assign_lawyer.dart';
import 'package:sih_project/screens/case_dashboard.dart';

class Case {
  final String id;
  final String caseName;
  final bool isClosed;

  Case(this.id, this.caseName, this.isClosed);
}

class ListTileWithNavigation extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget destinationPage;

  ListTileWithNavigation(
      {required this.title,
        required this.subtitle,
        required this.destinationPage});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 7),
      //color: Color.fromARGB(255, 225, 225, 225),
      //shadowColor: Colors.deepPurpleAccent,
      child: ListTile(
        title: Text(title,
        style: TextStyle(
          fontSize: 20,

        ),),
        subtitle: Text(subtitle,
          style: TextStyle(
          fontSize: 17,

        ),),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ), // Arrow icon on the right corner
        onTap: () {
          // Navigate to the destination page when the list tile is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
      ),
    );
  }
}

class PrisonDashboard extends StatefulWidget {
  @override
  _PrisonDashboardState createState() => _PrisonDashboardState();
}

class _PrisonDashboardState extends State<PrisonDashboard> {
  String _selectedFilter = 'All';

  final List<Case> _cases = [
    Case('1', 'Case 1', false),
    Case('2', 'Case 2', true),
    Case('3', 'Case 3', false),
    Case('4', 'Case 4', true),
  ];

  List<Case> getFilteredCases() {
    if (_selectedFilter == 'All') {
      return _cases;
    } else if (_selectedFilter == 'Ongoing') {
      return _cases.where((c) => !c.isClosed).toList();
    } else {
      return _cases.where((c) => c.isClosed).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredCases = getFilteredCases();

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.deepPurpleAccent,
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
                    builder: (context) => PrisonDashboard(),
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
                  MaterialPageRoute(builder: (context) => CaseInfoForm()),
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
                Container(
                  child: DropdownButton<String>(
                    iconEnabledColor: Colors.deepPurpleAccent,
                    value: _selectedFilter,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedFilter = newValue!;
                      });
                    },
                    items: ['All', 'Ongoing', 'Closed']
                        .map((filter) => DropdownMenuItem<String>(
                      value: filter,
                      child: Text(filter),
                    ))
                        .toList(),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCases.length,
                    itemBuilder: (context, index) {
                      final caseItem = filteredCases[index];
                      String casestatus =
                          'Status: ${caseItem.isClosed ? 'Closed' : 'Ongoing'}';
                      return ListTileWithNavigation(
                        title: caseItem.caseName,
                        subtitle: casestatus,
                        destinationPage:
                        CaseInfoDashboard(), //redirect to case PrisonDashboard
                      );
                    },
                  ),
                ),
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
                    MaterialPageRoute(builder: (context) => CaseInfoForm()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                child: Row(
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
