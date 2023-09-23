import 'package:flutter/material.dart';

class ConnectWithLawyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              width: 400,
              height: 600,
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Connect with Your Lawyer",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  ClipOval(
                    child: Image.asset(
                      'images/elegant-man-with-crossed-amrs.jpg', // Replace with your image asset
                      width: 240, // Adjust the size as needed
                      height: 240, // Adjust the size as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Surya Raghuvanshi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Pro Bono Lawyer',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularButton(
                        label: 'Call',
                        icon: Icons.call,
                        onPressed: () {
                          // Add your action here
                        },
                      ),
                      CircularButton(
                        label: 'Chat',
                        icon: Icons.chat,
                        onPressed: () {
                          // Add your action here
                        },
                      ),
                      CircularButton(
                        label: 'Video Call',
                        icon: Icons.videocam,
                        onPressed: () {
                          // Add your action here
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  CircularButton({
    required this.label,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          onPressed: onPressed,
          child: Icon(icon),
        ),
        SizedBox(height: 8),
        Text(
          label,
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ConnectWithLawyer(),
  ));
}
