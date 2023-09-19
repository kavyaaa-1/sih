import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class LegalAidOrganization {
  final String name;
  final String phone;
  final String email;

  LegalAidOrganization({
    required this.name,
    required this.phone,
    required this.email,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LegalAidListPage(),
    );
  }
}

class LegalAidListPage extends StatelessWidget {
  final List<LegalAidOrganization> legalAidOrganizations = [
  LegalAidOrganization(
    name: 'Legal Aid Society',
    phone: '+1 (123) 456-7890',
    email: 'legalaid@example.com',
  ),
  LegalAidOrganization(
    name: 'Pro Bono Legal Services',
    phone: '+1 (456) 789-1230',
    email: 'probono@example.com',
  ),
  LegalAidOrganization(
    name: 'Justice for All',
    phone: '+1 (789) 123-4567',
    email: 'justiceforall@example.com',
  ),
  LegalAidOrganization(
    name: 'Community Legal Services',
    phone: '+1 (567) 890-1234',
    email: 'communitylegal@example.com',
  ),
  LegalAidOrganization(
    name: 'Rights Advocates',
    phone: '+1 (234) 567-8901',
    email: 'rightsadvocates@example.com',
  ),
  LegalAidOrganization(
    name: 'Equal Justice Initiative',
    phone: '+1 (987) 654-3210',
    email: 'equaljustice@example.com',
  ),
  LegalAidOrganization(
    name: 'Access to Justice Foundation',
    phone: '+1 (321) 654-9870',
    email: 'accesstojustice@example.com',
  ),
  LegalAidOrganization(
    name: 'Human Rights Legal Center',
    phone: '+1 (876) 543-2109',
    email: 'humanrightslegal@example.com',
  ),
  LegalAidOrganization(
    name: 'Civil Liberties Union',
    phone: '+1 (543) 210-9876',
    email: 'civilliberties@example.com',
  ),
  LegalAidOrganization(
    name: 'Justice League',
    phone: '+1 (109) 876-5432',
    email: 'justiceleague@example.com',
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal Aid Organizations'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: legalAidOrganizations.length,
          itemBuilder: (context, index) {
            final organization = legalAidOrganizations[index];
            
            return CaseCard(
              name: organization.name,
              email: organization.email,
              phone: organization.phone,
            );
          },
        ),
      ),
    );
  }
}

class CaseCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  CaseCard({
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another page when the card is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              // Replace `AnotherPage` with the actual page you want to navigate to
              return LegalAidListPage();
            },
          ),
        );
      },
      child: Card(
        color: Color.fromARGB(255, 227, 220, 247),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                'Name: $name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Email ID: $email',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Phone no.: $phone',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios), // Add the forward arrow icon
        ),
      ),
    );
  }
}
