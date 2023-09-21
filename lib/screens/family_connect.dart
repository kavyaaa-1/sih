import 'package:flutter/material.dart';

class ConnectToPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Connect To'),
        ),
        body: ConnectToTiles(),
      ),
    );
  }
}

class ConnectToTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      children: [
        ConnectToTile(
          title: 'Your Lawyer',
          icon: Icons.account_circle,
          onTap: () {
            // Add navigation logic to Pro Bono Lawyers page
          },
        ),
        ConnectToTile(
          title: 'Legal Clinics',
          icon: Icons.local_hospital,
          onTap: () {
            // Add navigation logic to Legal Clinics page
          },
        ),
        ConnectToTile(
          title: 'Legal Aid Organizations',
          icon: Icons.business,
          onTap: () {
            // Add navigation logic to Legal Aid Organizations page
          },
        ),
        ConnectToTile(
          title: 'UTRCs for Bail Process',
          icon: Icons.directions_run,
          onTap: () {
            // Add navigation logic to UTRCs for Bail Process page
          },
        ),
      ],
    );
  }
}

class ConnectToTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  ConnectToTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60.0,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 12.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
