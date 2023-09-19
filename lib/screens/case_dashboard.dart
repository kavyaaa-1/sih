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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Case No. ${widget.caseId}',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Case Type:',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${caseInfo?.caseType ?? 'Loading...'}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Assigned Lawyer:',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${caseInfo?.lawyerAssigned ?? 'Loading...'}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Judge Assigned:',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${caseInfo?.judgeAssigned ?? 'Loading...'}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Prisoner Name:',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${caseInfo?.prisonerName ?? 'Loading...'}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Description of the Case:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(caseInfo?.caseDescription ?? 'Loading...'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24), // Add spacing
                Text(
                  'Bail Prediction * ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8), // Add spacing
                Container(
                  height: 200, // Adjust the height as needed
                  child: SpeedometerChart(
                    value: bailPrediction,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class SpeedometerChart extends StatelessWidget {
  final double value;

  SpeedometerChart({required this.value});

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
              color: Colors.red, // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 70,
              color: Colors.yellow, // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 70,
              endValue: 100,
              color: Colors.green, // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
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
                    fontSize: 25,
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
