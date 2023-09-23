import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:sih_project/dbHelper/constant.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../dbHelper/mongodb.dart'; 

class CaseInfo {
  final String caseId;
  final String caseType;
  final String lawyerAssigned;
  final String judgeAssigned;
  final String prisonerName;
  final String caseDescription;

  CaseInfo({
    required this.caseId,
    required this.caseType,
    required this.lawyerAssigned,
    required this.judgeAssigned,
    required this.prisonerName,
    required this.caseDescription,
  });
}

class CaseInfoDashboard extends StatefulWidget {
  final String caseId;

  CaseInfoDashboard({required this.caseId});

  @override
  _CaseInfoDashboardState createState() => _CaseInfoDashboardState();
}

List fetchedCaseInfo = [];
String assignedLawyer = "";
String assignedJudge = "";

Future<List> fetchCaseInfoFromDatabase(String caseId) async {
  final caseCollection = MongoDatabase.db.collection(CASE_COLLECTION);

  return await caseCollection
      .find(
        mongo_dart.where.eq('case_Id', caseId),
      )
      .toList();
  //print(fetchedCaseInfo);
}

class _CaseInfoDashboardState extends State<CaseInfoDashboard> {
  CaseInfo? caseInfo;
  double bailPrediction = 75; // Replace with actual bail prediction value

  void loadCaseInfo() async {
    fetchedCaseInfo = await fetchCaseInfoFromDatabase(widget.caseId);
    final istrue = await getAssignedInfo();
    print(fetchedCaseInfo);
    print(istrue);

    setState(() {
      caseInfo = CaseInfo(
        caseId: fetchedCaseInfo[0]?['case_Id'] ?? ' ',
        caseType: fetchedCaseInfo[0]?['type'] ?? ' ',
        lawyerAssigned: assignedLawyer,
        judgeAssigned: assignedJudge,
        prisonerName: fetchedCaseInfo[0]?['prisoner_name'] ?? ' ',
        caseDescription: fetchedCaseInfo[0]?['case_desc'] ?? ' ',
      );
    });
  }

  Future<bool> getAssignedInfo() async {
    final query1 = mongo_dart.where.eq("lid", fetchedCaseInfo[0]?['LID']);
    final lawyerResult = await MongoDatabase.db
        .collection(LAWYER_COLLECTION)
        .find(query1)
        .toList();

    if (lawyerResult.isNotEmpty) {
      assignedLawyer = lawyerResult[0]["name"];
    }

    final query2 = mongo_dart.where.eq("jid", fetchedCaseInfo[0]?['JID']);
    final judgeResult = await MongoDatabase.db
        .collection(JUDGE_COLLECTION)
        .find(query2)
        .toList();

    if (judgeResult.isNotEmpty) {
      assignedJudge = judgeResult[0]["name"];
    }

    print(assignedLawyer);
    print(assignedJudge);

    setState(() {});

    return (assignedJudge.isNotEmpty && assignedLawyer.isNotEmpty);
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
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          title: Text("Case Details"),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: double
                      .infinity, // Make the Card width match the screen width
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Case ID: ${widget.caseId}',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        caseInfo?.caseType ?? 'Loading...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors
                            .grey, // You can specify the color of the line
                        thickness:
                            1, // You can adjust the thickness of the line
                        height:
                            20, // You can set the height or space above and below the line
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Prisoner Name',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${caseInfo?.prisonerName ?? 'Loading...'}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Assigned Lawyer',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${caseInfo?.lawyerAssigned ?? 'Loading...'}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Assigned Judge',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${caseInfo?.judgeAssigned ?? 'Loading...'}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      ExpansionTile(
                        title: Text(
                          'Case Description',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          Text(
                            caseInfo?.caseDescription ?? 'Loading...',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            Container(
                              height: 200,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(
                                    8.0), // Adjust the radius as needed
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 5),
                                      height: 200,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: _BailPredictionGraph(
                                          value: bailPrediction,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 60),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Bail\nPrediction',
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // Add other text or widgets here
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BailPredictionGraph extends StatelessWidget {
  final double value;

  _BailPredictionGraph({required this.value});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 30,
              color: Color.fromRGBO(144, 114, 227, 1.0), // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 70,
              color: Color.fromRGBO(83, 53, 168, 1.0), // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 70,
              endValue: 100,
              color: Color.fromRGBO(36, 18, 98, 1.0), // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              needleColor: Colors.white,
              value: value,
              enableAnimation: true,
              animationType: AnimationType.ease,
              animationDuration: 1000,
              needleStartWidth: 1,
              needleEndWidth: 6,
              needleLength: 0.8,
              knobStyle: KnobStyle(
                knobRadius: 0.07,
              ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  '$value%',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}
