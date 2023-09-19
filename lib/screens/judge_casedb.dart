import 'package:flutter/material.dart';
import 'hearing_details.dart';

class CaseDetails {
  final String caseNo;
  final String caseType;
  final String lawyerAssigned;
  final String judgeAssigned;
  final String prisonerName;
  final String caseDescription;
  final List<String> hearingDates;
  String verdict = '';

  CaseDetails({
    required this.caseNo,
    required this.caseType,
    required this.lawyerAssigned,
    required this.judgeAssigned,
    required this.prisonerName,
    required this.caseDescription,
    required this.hearingDates,
  });
}

class CaseDetailsPage extends StatefulWidget {
  @override
  State<CaseDetailsPage> createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  late CaseDetails caseInfo;

  @override
  void initState() {
    super.initState();
    caseInfo = CaseDetails(
      caseNo: 'Case #12345',
      caseType: 'Criminal Case',
      lawyerAssigned: 'John Doe',
      judgeAssigned: 'Judge Smith',
      prisonerName: 'Alice Johnson',
      caseDescription: 'Lorem ipsum dolor sit amet...',
      hearingDates: ['2023-09-10', '2023-09-15', '2023-09-17'],
    );
  }

  final TextEditingController _textEditingController = TextEditingController();

  bool canAddHearing = true;

  bool canAddVerdict = true;

  // bool isAddingHearing = false;

  // bool isAddingVerdict = false;

  String newHearingDate = '';

  DateTime datetime = DateTime.now();

  //String newTranscript = '';
  String newVerdict = '';

  @override
  Widget build(BuildContext context) {
    List<String> date =
        caseInfo.hearingDates[caseInfo.hearingDates.length - 1].split('-');
    List<int> intList = date.map((str) => int.parse(str)).toList();
    DateTime lastDate = DateTime(intList[2], intList[1], intList[0]);
    if (datetime.isAfter(lastDate)) {
      canAddHearing = true;
      canAddVerdict = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Case Details'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Case No. ${caseInfo.caseNo}',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 4,
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
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
                        '${caseInfo.caseType}',
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
                        '${caseInfo.lawyerAssigned}',
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
                        '${caseInfo.judgeAssigned}',
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
                        '${caseInfo.prisonerName}',
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
                      Text(caseInfo.caseDescription),
                      if (!canAddVerdict) SizedBox(height: 16),
                      Text(
                        'Case Verdict:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(caseInfo.verdict),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                color: Colors.white,
                margin: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Hearing Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children: caseInfo.hearingDates.map((date) {
                        return Card(
                          elevation: 4, // Add elevation for shadow
                          shadowColor: Colors.grey,
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  date,
                                  style: TextStyle(
                                    fontSize: 16,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Icon(Icons.arrow_forward),
                                onTap: () {
                                  // Handle date click action, e.g., show details or navigate to another page
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Hearing Date Details',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'Selected Date: $date',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HearingDetails(),
                                                ),
                                              );
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              if (canAddHearing && canAddVerdict)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (canAddHearing)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent.withOpacity(0.6),
                          onPrimary: Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text("Add Next Hearing Date"),
                        onPressed: () async {
                          final newD = await pickDate();
                          if (newD == null) return;
                          final newDate = DateTime(
                            newD.year,
                            newD.month,
                            newD.day,
                          );
                          setState(() {
                            canAddHearing = false;
                            caseInfo.hearingDates.add(
                                "${newDate.year}-${newDate.month}-${newDate.day}");
                            lastDate = newDate;
                          });
                        },
                      ),
                    if (canAddVerdict)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent.withOpacity(0.6),
                          onPrimary: Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text("Add Verdict"),
                        onPressed: () {
                          showInputDialog(context);
                          setState(() {
                            canAddVerdict = false;
                            canAddHearing = false;
                            caseInfo.verdict = newVerdict;
                          });
                        },
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Input verdict'),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(labelText: 'Enter Text'),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Get the input value from the text field
                newVerdict = _textEditingController.text;

                // Use inputValue as needed (store it in a variable, etc.)
                // For example, you can print it or set it in a state variable.
                // print('Input Value: $inputValue');

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: datetime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
}
