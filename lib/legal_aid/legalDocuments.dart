// legalDocuments.dart

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
        title: Text('Legal Templates'),
      ),
      body: ListView.builder(
        itemCount: legalDocuments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(legalDocuments[index]),
            onTap: () {
              // Navigate to the selected legal document template
              // You can add navigation logic here
            },
          );
        },
      ),
    );
  }
}
