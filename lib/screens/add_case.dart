import 'package:flutter/material.dart';

import 'assign_lawyer.dart';

class CaseInfoForm extends StatefulWidget {
  @override
  _CaseInfoFormState createState() => _CaseInfoFormState();
}

class _CaseInfoFormState extends State<CaseInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Define variables to store input data
  String prisonerName = '';
  String prisonerDOB = '';
  String prisonerGender = '';
  int prisonerID = 0;

  String offenseType = '';
  String offenseDateAndTime = '';
  String offenseLocation = '';
  String offenseDesc = '';

  String arrestDateAndTime = '';
  String arrestLoc = '';
  String arrestOfficer = '';
  int arrestwarrantNumber = 0;

  int bailAmt = 0;
  String bailConditions = '';

  String witnessName = '';
  int witnessContact = 0;

  String evidenceInfo = '';
  String additionalComments = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process and submit the data as needed (e.g., send to a server)
      // You can access the entered data using the defined variables

      // Navigate to the next page or perform any other action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Enter Case Information',
        style: TextStyle(color: Colors.white),),
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
              _buildTextField('Date and Time of offense', (value) {
                //select using a calendar
                offenseDateAndTime = value;
              }),
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
              _buildTextField('Date and Time of Arrest', (value) {
                arrestDateAndTime = value;
              }),
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
                child: Text('SUBMIT',
                style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
void _submitForm(BuildContext context, GlobalKey<FormState> formKey) {
  if (formKey.currentState!.validate()) {
    // Process and submit the data as needed (e.g., send to a server)
    // You can access the entered data using the defined variables

    // Navigate to the CaseConfirmationPage
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CaseConfirmationPage(),
      ),
    );
  }
}

