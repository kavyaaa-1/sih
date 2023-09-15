import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() => runApp(MyApp());

class CaseInfo {
  final String caseNo;
  final String caseType;
  final String lawyerAssigned;
  final String judgeAssigned;
  final String prisonerName;
  final String caseDescription;

  CaseInfo({
    required this.caseNo,
    required this.caseType,
    required this.lawyerAssigned,
    required this.judgeAssigned,
    required this.prisonerName,
    required this.caseDescription,
  });
}

Future<CaseInfo> fetchCaseInfoFromDatabase(String caseId) async {
  // Simulate fetching data from a database based on the caseId
  // Replace this with actual database query logic
  await Future.delayed(Duration(seconds: 1));
  return CaseInfo(
    caseNo: '12345',
    caseType: 'Criminal',
    lawyerAssigned: 'John Doe',
    judgeAssigned: 'Jane Smith',
    prisonerName: 'John Smith',
    caseDescription:
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis, justo in euismod egestas, dui orci malesuada enim.',
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CaseInfoDashboard(),
    );
  }
}

class CaseInfoDashboard extends StatefulWidget {
  @override
  _CaseInfoDashboardState createState() => _CaseInfoDashboardState();
}

class _CaseInfoDashboardState extends State<CaseInfoDashboard> {
  String caseId = 'your_initial_case_id'; // Replace with your initial case ID
  CaseInfo? caseInfo;

  void loadCaseInfo() async {
    final fetchedCaseInfo = await fetchCaseInfoFromDatabase(caseId);
    setState(() {
      caseInfo = fetchedCaseInfo;
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
      ),
      body:
      Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Case No. ${caseInfo?.caseNo ?? 'Loading...'}',
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
                value: 75,
              ),
            ),
          ],
        ),
      ),
    );
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
