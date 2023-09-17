import 'package:flutter/material.dart';
import '../dbHelper/case_data_model.dart';
import '../dbHelper/constant.dart';
import '../dbHelper/mongodb.dart';
import 'assign_lawyer.dart';

class CaseInfoForm extends StatefulWidget {
  @override
  _CaseInfoFormState createState() => _CaseInfoFormState();
}

class _CaseInfoFormState extends State<CaseInfoForm> {
  bool isSubmitButtonEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime datetime = DateTime.now();
  DateTime datetimeoffense = DateTime.now();
  DateTime datetimearrest = DateTime.now();

  // Define variables to store input data
  String prisonerName = '';
  String prisonerDOB = '';
  String prisonerGender = '';
  String prisonerID = '';

  String offenseType = '';
  String offenseLocation = '';
  String offenseDesc = '';

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
    if (_formKey.currentState!.validate()) {
      isSubmitButtonEnabled = true;
      String case_ID = "123456";

      final data = Case(
          case_Id: case_ID,
          case_desc: offenseDesc,
          type: offenseType,
          loc: offenseLocation,
          offense_date: datetimeoffense,
          inmate_ID: prisonerID,
          prisoner_name: prisonerName,
          DOB: prisonerDOB,
          gender: prisonerGender,
          date_arrest: datetimearrest,
          arresting_officer: arrestOfficer,
          arrest_loc: arrestLoc,
          evidence: evidenceInfo.split(" ").toList());

      // Insert data into the MongoDB collection
      await MongoDatabase.db.open();
      await MongoDatabase.db.collection(CASE_COLLECTION).insert(data.toJson());

      // Close the MongoDB connection
      await MongoDatabase.db.close();

      // Show a success message or navigate to a success page
      print('Data inserted successfully.');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('The case has been registered successfully'),
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
          builder: (context) => CaseConfirmationPage(),
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
    // final hours = datetime.hour.toString().padLeft(2, '0');
    // final minutes = datetime.minute.toString().padLeft(2, '0');
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
          child: ListView(
            children: [
              const Text(
                "PRISONER INFORMATION",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent),
              ),
              _buildTextField('Prisoner Full Name', (value) {
                prisonerName = value;
              }),
              _buildTextField('DOB', (value) {
                prisonerDOB = value;
              }),
              _buildTextField('Gender', (value) {
                prisonerGender = value;
              }),
              _buildTextField('Inmate ID', (value) {
                prisonerID = value;
              }),
              const SizedBox(height: 40.0),
              const Text(
                "CASE DETAILS",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent),
              ),
              _buildTextField('Type of offense', (value) {
                offenseType = value;
              }),
              SizedBox(height: 16.0),
              const Text(
                'Select Date and Time of Offense',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 109, 108, 108),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final date = await pickDate();
                        if (date == null) return;

                        final newDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          datetime.hour,
                          datetime.minute,
                        );

                        setState(() => {
                              datetimeoffense = newDateTime,
                              datetime = newDateTime,
                            });
                      },
                      child: Text(
                          '${datetimeoffense.year}/${datetimeoffense.month}/${datetimeoffense.day}'),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final time = await pickTime();
                        if (time == null) return;

                        final newDateTime = DateTime(
                          datetime.year,
                          datetime.month,
                          datetime.day,
                          time.hour,
                          time.minute,
                        );
                        setState(() => {
                              datetimeoffense = newDateTime,
                              datetime = newDateTime,
                            });
                      },
                      child: Text(
                          '${datetimeoffense.hour}:${datetimeoffense.minute}'),
                    ),
                  ),
                ],
              ),

              // _buildTextField('Date and Time of offense', (value) {
              //   //select using a calendar
              //   offenseDateAndTime = value;
              // }),
              _buildTextField('Location of alleged offense', (value) {
                offenseLocation = value;
              }),
              _buildTextField('Description of alleged offense', (value) {
                offenseDesc = value;
              }),
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
              const Text(
                'Select Date and Time of Arrest',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 109, 108, 108),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final date = await pickDate();
                        if (date == null) return;

                        final newDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          datetime.hour,
                          datetime.minute,
                        );

                        setState(() => {
                              datetimearrest = newDateTime,
                              datetime = newDateTime,
                            });
                      },
                      child: Text(
                          '${datetimearrest.year}/${datetimearrest.month}/${datetimearrest.day}'),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final time = await pickTime();
                        if (time == null) return;

                        final newDateTime = DateTime(
                          datetime.year,
                          datetime.month,
                          datetime.day,
                          time.hour,
                          time.minute,
                        );
                        setState(() => {
                              datetimearrest = newDateTime,
                              datetime = newDateTime,
                            });
                      },
                      child: Text(
                          '${datetimearrest.hour}:${datetimearrest.minute}'),
                    ),
                  ),
                ],
              ),
              _buildTextField('Location of Arrest', (value) {
                arrestLoc = value;
              }),
              _buildTextField('Name of Arresting Officer', (value) {
                arrestOfficer = value;
              }),
              _buildTextField('Arrest Warrant Name(if applicable)', (value) {
                arrestwarrantNumber = value;
              }),
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
              }),
              _buildTextField('Bail Conditions(if applicable)', (value) {
                bailConditions = value;
              }),
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
              }),
              _buildTextField('Witness Contact(if any)', (value) {
                witnessContact = value;
              }),
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
              }),
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
              }),
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
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: datetime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: datetime.hour,
          minute: datetime.minute,
        ),
      );

  Widget _buildTextField(String labelText, Function(dynamic) onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
