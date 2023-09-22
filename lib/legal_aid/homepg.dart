// main.dart

import 'package:flutter/material.dart';
import 'package:sih_project/legal_aid/dictionary.dart';
import 'legalDocuments.dart';
import 'faq.dart';
import 'rights.dart';
import 'visitation.dart';

class LegalAidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal Aid'),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(16.0), // Add padding around the GridView
        childAspectRatio: 3.0, // Adjust aspect ratio for tile height
        children: [
          _buildTile(context, 'Legal Glossary', SearchPage()),
          _buildTile(context, 'Legal FAQ', Faq()),
          _buildTile(context, 'Access to Rights', Rights()),
          _buildTile(context, 'Visitation Information', Visitation()),
          _buildTile(context, 'Legal Documents', LegalDocuments()),
          // Add similar lines for additional tiles if needed
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        margin:
            EdgeInsets.all(8.0), // Add margin to create spacing between tiles
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent, // Background color
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
