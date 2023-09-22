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
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        title: Text('Resources'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(16.0), // Add padding around the GridView
        childAspectRatio: 2.56, // Adjust aspect ratio for tile height
        children: [
          //SizedBox(height: 10,),
          _buildTile(context, 'Legal Glossary', SearchPage(), 'images/dictionary.png'),
          _buildTile(context, 'Legal FAQ', Faq(), 'images/faq.png'),
          _buildTile(context, 'Access to Rights', Rights(), 'images/civil-right-movement.png'),
          _buildTile(context, 'Visitation Information', Visitation(),'images/visitor.png'),
          _buildTile(context, 'Legal Documents', LegalDocuments(), 'images/folder.png'),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, Widget page, String img) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0), // Add margin to create spacing between tiles
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners

        ),
        child: Row(
          children: [
            // Left column with image
            Container(

              width: 150, // Set the width for the image container
              height: 150, // Set the height for the image container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), // Rounded top-left corner
                  bottomLeft: Radius.circular(20.0), // Rounded bottom-left corner
                ),
                image: DecorationImage(
                  image: AssetImage(img), // Use your image asset here
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
            ),
            // Right column with text
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0), // Add padding to the text container
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
