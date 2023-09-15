import 'package:flutter/material.dart';

class CaseConfirmationPage extends StatefulWidget {
  @override
  _CaseConfirmationPageState createState() => _CaseConfirmationPageState();
}

class _CaseConfirmationPageState extends State<CaseConfirmationPage> {
  // data for case ID, lawyer, and judge.
  String _caseId = '12345'; //should be auto generated
  String _assignedLawyer = 'John Doe';
  String _assignedJudge = 'Judge Smith';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(''),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const Text(
                //   'Congratulations! The case information has been saved successfully',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 25.0,
                //   ),
                // ),
                const SizedBox(height: 25.0),
                const Text(
                  'CASE ID',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  _caseId,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 25.0),
                const Text(
                  'ASSIGNED LAWYER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  _assignedLawyer,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 25.0),
                const Text(
                  'ASSIGNED JUDGE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  _assignedJudge,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 25.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
