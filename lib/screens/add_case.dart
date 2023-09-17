import 'package:flutter/material.dart';
import '../dbHelper/case_data_model.dart';
import '../dbHelper/constant.dart';
import '../dbHelper/mongodb.dart';
import 'assign_lawyer.dart';

class CaseInfoForm extends StatefulWidget {
  final String pid;
  CaseInfoForm({required this.pid});
  @override
  _CaseInfoFormState createState() => _CaseInfoFormState();
}

class _CaseInfoFormState extends State<CaseInfoForm> {
  bool isSubmitButtonEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime datetime = DateTime.now();
  DateTime datetimeoffense = DateTime.now();
  DateTime datetimearrest = DateTime.now();
  DateTime dob = DateTime(2001, 1, 1);

  // Define variables to store input data
  String prisonerName = '';
  //String prisonerDOB = '';
  String prisonerGender = 'Male';
  String prisonerID = '';

  String offenseType = '';
  String offenseLocation = '';
  String offenseDesc = '';

  // String dtoffense = '';
  // String dtarrest = '';

  String arrestLoc = '';
  String arrestOfficer = '';
  int arrestwarrantNumber = 0;

  int bailAmt = 0;
  String bailConditions = '';

  String witnessName = '';
  int witnessContact = 0;

  String evidenceInfo = '';
  String additionalComments = '';

  void _submitForm() async {
    if (prisonerName != '' &&
        evidenceInfo != '' &&
        prisonerGender != '' &&
        prisonerID != '' &&
        offenseType != '' &&
        offenseLocation != '' &&
        offenseDesc != '' &&
        arrestLoc != '' &&
        arrestOfficer != '') {
      isSubmitButtonEnabled = true;
      String case_ID =
          (await MongoDatabase.db.collection(CASE_COLLECTION).count() + 1)
              .toString();

      final data = Case(
          case_Id: case_ID,
          case_desc: offenseDesc,
          type: offenseType,
          loc: offenseLocation,
          offense_date: datetimeoffense,
          inmate_ID: prisonerID,
          prisoner_name: prisonerName,
          DOB: dob.toIso8601String(),
          gender: prisonerGender,
          date_arrest: datetimearrest,
          arresting_officer: arrestOfficer,
          arrest_loc: arrestLoc,
          evidence: evidenceInfo.split(",").toList(),
          isClosed: false,
          PID: "",
          LID: "",
          JID: "");

      // Insert data into the MongoDB collection
      await MongoDatabase.db.open();
      await MongoDatabase.db.collection(CASE_COLLECTION).insert(data.toJson());

      // Show a success message or navigate to a success page
      print('Data inserted successfully.');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('The case has been registered successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      // Navigate to the next page or perform any other action
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CaseConfirmationPage(
            pid: widget.pid,
            caseId: case_ID,
          ),
        ),
      );
    } else {
      // Show an error message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Empty Field'),
            content: Text('Some fields are empty'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        title: Text(
          'Enter Case Information',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "PRISONER INFORMATION",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
                _buildTextField('Prisoner Full Name', (value) {
                  prisonerName = value;
                }, true),
                // _buildTextField('DOB', (value) {
                //   prisonerDOB = value;
                // }, true),
                SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final date = await pickDateDOB();
                    if (date == null) return;

                    final newDate = DateTime(
                      date.year,
                      date.month,
                      date.day,
                    );

                    setState(() => dob = newDate);
                  },
                  decoration: InputDecoration(
                    labelText: 'Select DOB of Prisoner',
                    hintText: '${dob.year}/${dob.month}/${dob.day}',
                    prefixIcon: Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),

                // _buildTextField('Gender', (value) {
                //   prisonerGender = value;
                // }, true),
                const SizedBox(height: 10.0),
                DropdownButtonFormField<String>(
                  value: prisonerGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      prisonerGender = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Gender of Prisoner',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>[
                    'Male',
                    'Female',
                    'Non-Binary',
                    'Other',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                _buildTextField('Inmate ID', (value) {
                  prisonerID = value;
                }, true),
                const SizedBox(height: 40.0),
                const Text(
                  "CASE DETAILS",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final date = await pickDate();
                    if (date == null) return;

                    final newDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      datetimeoffense.hour,
                      datetimeoffense.minute,
                    );

                    setState(() => datetimeoffense = newDateTime);
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Date and Time of Offense',
                    hintText:
                        '${datetimeoffense.year}/${datetimeoffense.month}/${datetimeoffense.day}',
                    prefixIcon: Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final time = await pickTime();
                    if (time == null) return;

                    final newDateTime = DateTime(
                      datetimeoffense.year,
                      datetimeoffense.month,
                      datetimeoffense.day,
                      time.hour,
                      time.minute,
                    );

                    setState(() => datetimeoffense = newDateTime);
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Time of Offense',
                    hintText:
                        '${datetimeoffense.hour}:${datetimeoffense.minute}',
                    prefixIcon: Icon(Icons.access_time),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),

                _buildTextField('Type of offense', (value) {
                  offenseType = value;
                }, true),
                _buildTextField('Location of alleged offense', (value) {
                  offenseLocation = value;
                }, true),
                _buildTextField('Description of alleged offense', (value) {
                  offenseDesc = value;
                }, true),
                const SizedBox(height: 40.0),
                const Text(
                  "ARREST INFORMATION",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
                // _buildTextField('Date and Time of Arrest', (value) {
                //   arrestDateAndTime = value;
                // }),
                SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final date = await pickDate();
                    if (date == null) return;

                    final newDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      datetimeoffense.hour,
                      datetimeoffense.minute,
                    );

                    setState(() => datetimeoffense = newDateTime);
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Date and Time of Arrest',
                    hintText:
                        '${datetimeoffense.year}/${datetimeoffense.month}/${datetimeoffense.day}',
                    prefixIcon: Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final time = await pickTime();
                    if (time == null) return;

                    final newDateTime = DateTime(
                      datetimeoffense.year,
                      datetimeoffense.month,
                      datetimeoffense.day,
                      time.hour,
                      time.minute,
                    );

                    setState(() => datetimeoffense = newDateTime);
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Time of Offense',
                    hintText:
                        '${datetimeoffense.hour}:${datetimeoffense.minute}',
                    prefixIcon: Icon(Icons.access_time),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),

                _buildTextField('Location of Arrest', (value) {
                  arrestLoc = value;
                }, true),
                _buildTextField('Name of Arresting Officer', (value) {
                  arrestOfficer = value;
                }, true),
                _buildTextField('Arrest Warrant Name(if applicable)', (value) {
                  arrestwarrantNumber = value;
                }, false),
                const SizedBox(height: 40.0),
                const Text(
                  "BAIL INFORMATION",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
                _buildTextField('Bail Amount(if applicable)', (value) {
                  bailAmt = value;
                }, false),
                _buildTextField('Bail Conditions(if applicable)', (value) {
                  bailConditions = value;
                }, false),
                const SizedBox(height: 40.0),
                const Text(
                  "WITNESS INFORMATION",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
                _buildTextField('Witness Name(if any)', (value) {
                  witnessName = value;
                }, false),
                _buildTextField('Witness Contact(if any)', (value) {
                  witnessContact = value;
                }, false),
                const SizedBox(height: 40.0),
                const Text(
                  "EVIDENCE AND DOCUMENTATION",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
                _buildTextField(
                    'List of Evidence and Documents related to the Case',
                    (value) {
                  evidenceInfo = value;
                }, true),
                const SizedBox(height: 40.0),
                const Text(
                  "ADDITIONAL COMMENTS AND NOTES",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
                _buildTextField(
                    'Additional Information related to the case(if any)',
                    (value) {
                  additionalComments = value;
                }, false),
                SizedBox(height: 35.0),
                ElevatedButton(
                  onPressed: () => _submitForm(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent, // Button color
                    onPrimary: Colors.white, // Text color
                  ),
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: datetime,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
      );

  Future<DateTime?> pickDateDOB() => showDatePicker(
        context: context,
        initialDate: dob,
        firstDate: DateTime(1923),
        lastDate: DateTime(2005),
      );

  Future<TimeOfDay?> pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  Widget _buildTextField(
      String labelText, Function(dynamic) onChanged, bool compulsory) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      validator: (value) {
        if (value!.isEmpty && compulsory) {
          return 'Please enter $labelText';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
