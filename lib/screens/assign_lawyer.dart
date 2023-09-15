import 'package:flutter/material.dart';
import 'package:sih_project/screens/add_case.dart';

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
        title: Text('Case Confirmation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
                'Congratulations! The case information has been saved successfully',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.blueAccent)),
            const SizedBox(height: 25.0,),
            const Text('CASE ID',
            style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black)), 
            Text(_caseId, 
            style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black)),

            const SizedBox(height: 25.0),

            const Text('ASSIGNED LAWYER',
            style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black)),
            Text(_assignedLawyer,
            style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black)),

            const SizedBox(height: 25.0),

            const Text('ASSIGNED JUDGE',
            style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black)),
            Text(_assignedJudge,
            style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black)),
            
            const SizedBox(height: 25.0),

            ElevatedButton(
                onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CaseInfoForm()),
                      );
                    },
                child: Text('GO BACK TO HOME PAGE'),
            ),
          ],
        ),
      ),
    );
  }
}
