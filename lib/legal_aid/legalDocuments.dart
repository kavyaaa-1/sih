import 'package:flutter/material.dart';

class LegalDocuments extends StatelessWidget {
  final List<String> legalDocuments = [
    'Bail Filing Template',
    'Power of Attorney Form',
    'Affidavit of Support',
    'Release of Information Form',
    'Plea Agreement',
    'Financial Affidavit',
    'Notice of Appeal'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: Text('Legal Templates'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 25), // Add some spacing here
          Expanded(
            child: ListView.builder(
              itemCount: legalDocuments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(legalDocuments[index], style: TextStyle(fontSize: 20)),
                  onTap: () {
                    // Navigate to the selected legal document template
                    // You can add navigation logic here
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
