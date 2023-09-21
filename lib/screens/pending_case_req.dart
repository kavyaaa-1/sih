import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import '../dbHelper/constant.dart';
import '../dbHelper/mongodb.dart';

class Case {
  final String caseId;
  final String caseType;
  final String caseDesc;

  Case({required this.caseId, required this.caseType, required this.caseDesc});
}

class PendingCaseReq extends StatefulWidget {
  final String lawyerId;
  PendingCaseReq({required this.lawyerId});

  @override
  _PendingCaseReqState createState() => _PendingCaseReqState();
}

Future<List> fetchCaseInfoFromDatabase() async {
  final caseCollection = MongoDatabase.db.collection(CASE_COLLECTION);

  final pendingCasesList = await caseCollection
      .find(
        mongo_dart.where.eq('assigned', false),
      )
      .toList();
  //print(pendingCasesList);
  return pendingCasesList;
}

Future<bool> acceptCase(String caseId, String lawyerId) async {
  final query3 = mongo_dart.where.eq('case_Id', caseId);
  await MongoDatabase.db.collection(CASE_COLLECTION).update(query3, {
    '\$set': {
      'LID': lawyerId,
      'assigned': true
    }, // Update "assigned" status to true
  });
  return true;
}

class _PendingCaseReqState extends State<PendingCaseReq> {
  Future<List> fetchedData = fetchCaseInfoFromDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // ... your app bar settings
          ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pending Cases',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Display pending cases as cards
            Expanded(
              child: FutureBuilder<List>(
                future: fetchedData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No pending cases available.');
                  } else {
                    final pendingCasesList = snapshot.data as List;
                    print(pendingCasesList);
                    return ListView.builder(
                      itemCount: pendingCasesList.length,
                      itemBuilder: (context, index) {
                        final caseItem = pendingCasesList[index];
                        print(caseItem["case_Id"]);
                        return CaseCard(
                          caseId: caseItem["case_Id"],
                          caseType: caseItem["type"],
                          caseDesc: caseItem["case_desc"],
                          lawyerId: widget.lawyerId,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaseCard extends StatelessWidget {
  final String caseId;
  final String caseType;
  final String caseDesc;
  final String lawyerId;

  CaseCard(
      {required this.caseId,
      required this.caseType,
      required this.caseDesc,
      required this.lawyerId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Case Details'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Case ID: $caseId'),
                  Text('Case Type: $caseType'),
                  Text('Description: $caseDesc'),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    // Handle case acceptance logic here
                    await acceptCase(caseId, lawyerId);
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Case Assigned'),
                          content: Text('The case has been assigned to you.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Accept'),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8), // Adjust the margin as needed
        child: Padding(
          padding: EdgeInsets.all(16), // Adjust the padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Case ID: $caseId',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Case Type: $caseType',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Description: $caseDesc',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
