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
  String _assignedLawyer = '';
  String _assignedJudge = '';
  String _assignedLawyerId = '';
  String _assignedJudgeId = '';

  @override
  void initState() {
    super.initState();
    _assignLawyerAndJudgeToCase();
  }

  // Function to assign a lawyer and a judge to the case.
  void _assignLawyerAndJudgeToCase() async {
    // Assign a lawyer and a judge (You can implement your logic here)
    _assignedLawyer = await _assignLawyer();
    _assignedJudge = await _assignJudge();

    // Update the "assigned" status of the lawyer and judge in MongoDB
    await _updateAssignedStatus();

    setState(() {});
  }

  // Function to assign a lawyer to the case (You can implement your logic here)
  Future<String> _assignLawyer() async {
    final query = mongo_dart.where.eq('assigned', false);

    final lawyers = await MongoDatabase.db
        .collection(LAWYER_COLLECTION)
        .find(query)
        .toList();

    if (lawyers.isNotEmpty) {
      _assignedLawyerId = lawyers[0]['lid'];
      return lawyers[0]['name'];
    }

    return '';
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
    final query1 = mongo_dart.where.eq('lid', _assignedLawyerId);

    await MongoDatabase.db.collection(LAWYER_COLLECTION).update(query1, {
      '\$set': {'assigned': true}, // Update "assigned" status to true
    });

    final query2 = mongo_dart.where.eq('jid', _assignedJudgeId);

    await MongoDatabase.db.collection(JUDGE_COLLECTION).update(query2, {
      '\$set': {'assigned': true}, // Update "assigned" status to true
    });

    final query3 = mongo_dart.where.eq('case_Id', widget.caseId);
    await MongoDatabase.db.collection(CASE_COLLECTION).update(query3, {
      '\$set': {
        'PID': widget.pid,
        'LID': _assignedLawyerId,
        'JID': _assignedJudgeId
      }, // Update "assigned" status to true
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        title: Text('Assigned Details'),
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
                  widget.caseId,
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
