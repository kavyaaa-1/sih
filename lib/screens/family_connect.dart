import 'package:flutter/material.dart';
import 'package:sih_project/screens/connect_with_lawyer.dart';
import 'package:sih_project/screens/legal_aid_orgs.dart';

class LetsConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        title: Text("Let's Connect"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(12.0), // Add padding around the GridView
        childAspectRatio: 2.56, // Adjust aspect ratio for tile height
        children: [
          //SizedBox(height: 10,),
          _buildTile(
              context, 'Your Lawyer', ConnectWithLawyer(), 'images/lawyer.png'),
          _buildTile(context, 'Legal Aid Organizations', LegalAidListPage(),
              'images/legal_aid_org.png'),
          _buildTile(context, 'Legal Clinics', LegalAidListPage(),
              'images/legal_clinic.png'),
          _buildTile(
              context, 'UTRCs for Bail', LegalAidListPage(), 'images/UTRC.png'),
        ],
      ),
    );
  }

  Widget _buildTile(
      BuildContext context, String title, Widget page, String img) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        margin:
            EdgeInsets.all(10.0), // Add margin to create spacing between tiles
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.withOpacity(0.07),
          borderRadius: BorderRadius.circular(20.0),
          // border: Border.all(
          //   color: Colors.deepPurpleAccent.withOpacity(0.5), // Border color with opacity
          //   width:1, // Border width
          // ),// Rounded corners
        ),
        child: Row(
          children: [
            // Left column with image
            Container(
              margin: EdgeInsets.all(10.0),
              width: 120, // Set the width for the image container
              height: 120, // Set the height for the image container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), // Rounded top-left corner
                  bottomLeft:
                      Radius.circular(20.0), // Rounded bottom-left corner
                ),
                image: DecorationImage(
                  image: AssetImage(img), // Use your image asset here
                  //fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
            ),
            // Right column with text
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
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
