import 'package:flutter/material.dart';
import 'package:sih_project/screens/judge_casedb.dart';

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

class HearingDetails extends StatefulWidget {
  @override
  _HearingDetailsState createState() => _HearingDetailsState();
}

class _HearingDetailsState extends State<HearingDetails> {
  List<Hearing> caseHearings = [
    Hearing(
      hearingDate: '2023-09-10',
      transcript:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla at tellus nec nunc bibendum vulputate. Proin congue elit eu arcu scelerisque, non pharetra ligula tincidunt. Sed euismod vestibulum lorem, ut dapibus turpis interdum vel.',
      verdictProvided: false,
    ),
    // Add more hearing cases as needed
  ];

  bool showAddVerdictButton = true;
  bool showAddHearingButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Hearing Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          SizedBox(height: 20,),
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CaseDetailsPage()),
                  );
                  // Handle add hearing date button click here
                  setState(() {
                    showAddHearingButton = false;
                    showAddVerdictButton = false;
                  });
                },
                icon: Icon(Icons.add),
                label: Text('Add Hearing Date',style: TextStyle(fontSize: 16),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent.withOpacity(0.6),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle add verdict button click here
                  // Set caseInfo.verdictProvided = true
                  setState(() {
                    caseHearings.forEach((caseInfo) {
                      caseInfo.verdictProvided = true;
                    });
                    showAddVerdictButton = false;
                    showAddHearingButton = false;
                  });
                },
                child: Text('Provide Verdict', style: TextStyle(fontSize: 16),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent.withOpacity(0.6),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: caseHearings.length,
              itemBuilder: (context, index) {
                Hearing caseInfo = caseHearings[index];
                return Center(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hearing Date: ${caseInfo.hearingDate}',
                          style: TextStyle(
                            fontSize: 20,
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
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
