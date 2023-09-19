import 'package:flutter/material.dart';
import 'package:sih_project/screens/case_dashboard.dart';
import 'package:sih_project/screens/chatbot_screen.dart';
import 'package:sih_project/screens/select_user_type.dart';
import '../dbHelper/constant.dart';
import 'package:sih_project/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FamilyHomePage extends StatefulWidget {
  final List data;

  FamilyHomePage({required this.data});

  @override
  _FamilyHomePageState createState() => _FamilyHomePageState();
}

class _FamilyHomePageState extends State<FamilyHomePage> {
  int _selectedIndex = 0;
  String phonenum = '';
  String judge_name = '';
  String lawyer_name = '';
  double bailPrediction = 75;

  @override
  void initState() {
    super.initState();
    callLawyer();
  }

  void callLawyer() async {
    await getLawyer();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatBotScreen(),
        ),
      );
    }
  }

  Future<void> getLawyer() async {
    final query = mongo_dart.where.eq('lid', widget.data[0]['LID']);

    final lawyers = await MongoDatabase.db
        .collection(LAWYER_COLLECTION)
        .find(query)
        .toList();

    setState(() {
      phonenum = lawyers.isNotEmpty ? lawyers[0]['phone'] : '';
      lawyer_name = lawyers.isNotEmpty ? lawyers[0]['name'] : '';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await MongoDatabase.db.close();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SelectUserTypePage(),
              ));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Your Case',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Ink(
                decoration: ShapeDecoration(
                  color: widget.data[0]['isClosed'] ? Colors.red : Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0), // Adjust the border radius as needed
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    // Handle button click here
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Adjust padding as needed
                    child: Text(
                      widget.data[0]['isClosed'] ? 'Closed' : 'Ongoing',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: double.infinity, // Make the Card width match the screen width
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Case ID',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold, // Bold for headings
                        ),
                      ),
                      Text(
                        '${widget.data[0]['case_Id']}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Case Type',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold, // Bold for headings
                        ),
                      ),
                      Text(
                        '${widget.data[0]['type']}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),

                      Text(
                        'Judge Assigned',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold, // Bold for headings
                        ),
                      ),
                      Text(
                        judge_name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Lawyer Assigned',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold, // Bold for headings
                        ),
                      ),
                      Text(
                        lawyer_name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Lawyer Phone',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold, // Bold for headings
                        ),
                      ),
                      Text(
                        phonenum,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold, // Bold for headings
                        ),
                      ),
                      Text(
                        '${widget.data[0]['case_desc']}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),



              SizedBox(
                height: 20,
              ),
              Text(
                'Bail Prediction*',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200, // Adjust the height as needed
                child: _BailPredictionGraph(
                  value: bailPrediction,
                ),
              ), // Add your bail prediction graph widget here
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 40,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
                size: 40,
              ),
              label: 'Legal Aid',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                size: 40,
              ),
              label: 'Chat with Us',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class _BailPredictionGraph extends StatelessWidget {
  final double value;

  _BailPredictionGraph({required this.value});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 30,
              color: Colors.red, // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 70,
              color: Colors.yellow, // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 70,
              endValue: 100,
              color: Colors.green, // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: value,
              enableAnimation: true,
              animationType: AnimationType.ease,
              animationDuration: 1000,
              needleStartWidth: 1,
              needleEndWidth: 6,
              needleLength: 0.8,
              knobStyle: KnobStyle(
                knobRadius: 0.07,
              ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  '$value%',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}
