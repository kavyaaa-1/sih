import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Hearing {
  final String hearingDate;
  final String transcript;
  bool verdictProvided;

  Hearing({
    required this.hearingDate,
    required this.transcript,
    required this.verdictProvided,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HearingDetails(),
    );
  }
}

class HearingDetails extends StatelessWidget {
  final Hearing caseInfo = Hearing(
    hearingDate: '2023-09-10',
    transcript:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla at tellus nec nunc bibendum vulputate. Proin congue elit eu arcu scelerisque, non pharetra ligula tincidunt. Sed euismod vestibulum lorem, ut dapibus turpis interdum vel.',
    verdictProvided: false,
  );

  bool showAddVerdictButton = true;
  bool showAddHearingButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hearing Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hearing Date: ${caseInfo.hearingDate}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              ExpandableTranscriptCard(transcript: caseInfo.transcript),
              SizedBox(height: 16.0),
              Text(
                'Verdict Provided: ${caseInfo.verdictProvided ? 'Yes' : 'No'}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              if (!caseInfo.verdictProvided)
                Column(
                  children: [
                    if (showAddVerdictButton)
                      ElevatedButton(
                        onPressed: () {
                          // Handle add verdict button click here
                          // Set caseInfo.verdictProvided = true
                          caseInfo.verdictProvided = true;
                          showAddVerdictButton = false;
                          showAddHearingButton = false;
                        },
                        child: Text('Provide Verdict'),
                      ),
                    if (showAddHearingButton)
                      ElevatedButton(
                        onPressed: () {
                          // Handle add hearing date button click here
                          showAddHearingButton = false;
                          showAddVerdictButton = false;
                        },
                        child: Text('Add Hearing Date'),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableTranscriptCard extends StatefulWidget {
  final String transcript;

  ExpandableTranscriptCard({required this.transcript});

  @override
  _ExpandableTranscriptCardState createState() =>
      _ExpandableTranscriptCardState();
}

class _ExpandableTranscriptCardState extends State<ExpandableTranscriptCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Transcript',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: isExpanded
                ? Icon(Icons.expand_less)
                : Icon(Icons.expand_more),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(widget.transcript),
            ),
        ],
      ),
    );
  }
}
