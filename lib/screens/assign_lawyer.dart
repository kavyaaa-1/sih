import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:sih_project/dbHelper/mongodb.dart';
import '../dbHelper/constant.dart';

class CaseConfirmationPage extends StatefulWidget {
  final String pid;
  final String caseId;

  CaseConfirmationPage({required this.pid, required this.caseId});

  @override
  _CaseConfirmationPageState createState() => _CaseConfirmationPageState();
}

class _CaseConfirmationPageState extends State<CaseConfirmationPage> {
  String _assignedJudge = '';
  String _assignedLawyer = 'A lawyer will be assigned soon.';
  String _phone = '';
  String _assignedJudgeId = '';

  @override
  void initState() {
    super.initState();
    _assignLawyerAndJudgeToCase();
  }

  // Function to assign a lawyer and a judge to the case.
  void _assignLawyerAndJudgeToCase() async {
    // Assign a lawyer and a judge (You can implement your logic here)
    await _assignLawyer();

    await _assignJudge();

    // Update the "assigned" status of the lawyer and judge in MongoDB
    await _updateAssignedStatus();

    setState(() {});
  }

  // Function to assign a lawyer to the case (You can implement your logic here)
  Future<void> _assignLawyer() async {
    final caseDataList = await MongoDatabase.db
        .collection(CASE_COLLECTION)
        .find(mongo_dart.where.eq('case_Id', widget.caseId))
        .toList();

    if (caseDataList.isNotEmpty) {
      final caseData =
          caseDataList.first; // Get the first (and presumably only) case data
      if (caseData["LID"] != null && caseData["LID"].isNotEmpty) {
        final lawyer = await MongoDatabase.db
            .collection(LAWYER_COLLECTION)
            .find(mongo_dart.where.eq('lid', caseData["LID"]))
            .toList();
        if (lawyer.isNotEmpty) {
          final lawyerData = lawyer.first;
          _assignedLawyer = lawyerData["name"];
          _phone = lawyerData["phone"];
        }
      }
    }
  }

  // Function to assign a judge to the case (You can implement your logic here)
  Future<String> _assignJudge() async {
    final query = mongo_dart.where.eq('assigned', false);

    final judges = await MongoDatabase.db
        .collection(JUDGE_COLLECTION)
        .find(query)
        .toList();

    if (judges.isNotEmpty) {
      _assignedJudgeId = judges[0]['jid'];
      return judges[0]['name'];
    }

    return '';
  }

  // Function to update the "assigned" status of a user in MongoDB
  Future<void> _updateAssignedStatus() async {
    final query2 = mongo_dart.where.eq('jid', _assignedJudgeId);

    await MongoDatabase.db.collection(JUDGE_COLLECTION).update(query2, {
      '\$set': {'assigned': true}, // Update "assigned" status to true
    });

    final query3 = mongo_dart.where.eq('case_Id', widget.caseId);
    await MongoDatabase.db.collection(CASE_COLLECTION).update(query3, {
      '\$set': {
        'PID': widget.pid,
        'JID': _assignedJudgeId
      }, // Update "assigned" status to true
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.deepPurpleAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Assigned Details',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Color.fromARGB(255, 244, 243, 247),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 25.0),
                      Text(
                        'CASE ID',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.caseId,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        'ASSIGNED LAWYER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Name: $_assignedLawyer\nPhone number: $_phone',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        'ASSIGNED JUDGE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        _assignedJudge,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 200.0),
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
