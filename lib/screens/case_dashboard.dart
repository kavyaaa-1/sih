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

List<CaseInfo> _cases = [];

class CaseInfoDashboard extends StatefulWidget {
  final String caseId;

  CaseInfoDashboard({required this.caseId});

  @override
  _CaseInfoDashboardState createState() => _CaseInfoDashboardState();
}

Future<Map<String, dynamic>?> fetchCaseInfoFromDatabase(String caseId) async {
  try {
    await MongoDatabase.db.open();

    final caseCollection = MongoDatabase.db.collection(CASE_COLLECTION);

    final Map<String, dynamic>? caseData = await caseCollection.findOne(
      mongo_dart.where.eq('case_Id', caseId),
    );
    print(caseData);
    return caseData;
  } finally {
    await MongoDatabase.db.close();
  }
}

class _CaseInfoDashboardState extends State<CaseInfoDashboard> {
  CaseInfo? caseInfo;
  double bailPrediction = 75; // Replace with actual bail prediction value

  void loadCaseInfo() async {
    final fetchedCaseInfo = await fetchCaseInfoFromDatabase(widget.caseId);
    setState(() {
      caseInfo = CaseInfo(
        caseId: fetchedCaseInfo?['case_Id'] ?? ' ',
        caseType: fetchedCaseInfo?['type'] ?? ' ',
        lawyerAssigned: fetchedCaseInfo?['lawyer'] ?? ' ',
        judgeAssigned: fetchedCaseInfo?['judge'] ?? ' ',
        prisonerName: fetchedCaseInfo?['prisoner_name'] ?? ' ',
        caseDescription: fetchedCaseInfo?['case_desc'] ?? ' ',
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
                  'Case No. ${caseInfo?.caseId ?? 'Loading...'}',
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
