import 'package:flutter/material.dart';
import 'package:sih_project/screens/chatbot_screen.dart';
import 'package:sih_project/screens/family_connect.dart';
import 'package:sih_project/screens/splash.dart';
import '../dbHelper/constant.dart';
import 'package:sih_project/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../legal_aid/homepg.dart';

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
    callLawyerJudge();
  }

  void callLawyerJudge() async {
    await getLawyerJudge();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          //builder: (context) => LegalAidListPage(),
          builder: (context) => LegalAidPage(),
        ),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LetsConnect(),
        ),
      );
    }

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatBotScreen(),
        ),
      );
    }
  }

  Future<void> getLawyerJudge() async {
    final query = mongo_dart.where.eq('lid', widget.data[0]['LID']);

    final lawyers = await MongoDatabase.db
        .collection(LAWYER_COLLECTION)
        .find(query)
        .toList();

    final query1 = mongo_dart.where.eq('jid', widget.data[0]['JID']);

    final judge = await MongoDatabase.db
        .collection(JUDGE_COLLECTION)
        .find(query1)
        .toList();

    setState(() {
      phonenum = lawyers.isNotEmpty ? lawyers[0]['phone'] : '';
      lawyer_name = lawyers.isNotEmpty ? lawyers[0]['name'] : '';
      judge_name = judge.isNotEmpty ? judge[0]['name'] : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Handle opening the menu
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await MongoDatabase.db.close();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => splash(),
              ));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.deepPurpleAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Your Case',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: widget.data[0]['isClosed']
                                ? Colors.orange
                                : Colors.orange,
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: Text(
                            widget.data[0]['isClosed'] ? 'Closed' : 'Ongoing',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Case ID: ${widget.data[0]['case_Id']}',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Judge Assigned',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        phonenum,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      ExpansionTile(
                        title: Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          Text(
                            '${widget.data[0]['case_desc']}',
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            Container(
                              height: 200,
                              width: 355,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(
                                    8.0), // Adjust the radius as needed
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 5),
                                      height: 200,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: _BailPredictionGraph(
                                          value: bailPrediction,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 60),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Bail\nPrediction',
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // Add other text or widgets here
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Colors.deepPurpleAccent, // Set the background color to white
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              size: 35,
            ),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add,
              size: 35,
            ),
            label: 'Connect',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 35,
            ),
            label: 'Chat with Us',
          ),
        ],
        // Increase the label font size here
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
              color: Color.fromRGBO(144, 114, 227, 1.0), // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 70,
              color: Color.fromRGBO(83, 53, 168, 1.0), // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 70,
              endValue: 100,
              color: Color.fromRGBO(36, 18, 98, 1.0), // Customize the color
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              needleColor: Colors.white,
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
                    fontSize: 26,
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
