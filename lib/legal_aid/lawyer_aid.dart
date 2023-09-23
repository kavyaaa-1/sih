import 'package:flutter/material.dart';
import 'package:sih_project/legal_aid/crpc.dart';
import 'package:sih_project/legal_aid/ipc.dart';

class LawyerAid extends StatelessWidget {
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
        padding: EdgeInsets.all(12.0), // Add padding around the GridView
        childAspectRatio: 2.56, // Adjust aspect ratio for tile height
        children: [
          //SizedBox(height: 10,),
          _buildTile(context, 'Indian Penal Code', IPC()),
          _buildTile(context, 'CRPC', CRPC()),
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
            // Right column with text
            Expanded(
              child: Center(
                child: Container(
                  color: Colors.orange,
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
