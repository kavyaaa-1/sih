// page5.dart

import 'package:flutter/material.dart';

class Visitation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitation Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              VisitationInfoTile(
                title: "Eligibility for Visits",
                content:
                    "An under trial inmate is entitled for visits every seven days while a convict can have visits every fortnight.",
              ),
              VisitationInfoTile(
                title: "How to Apply for a Visit?",
                content:
                    "To visit a prisoner, you can apply to the Superintendent of the Prison concerned between 8:00 AM and 11:00 AM on a printed application available at the Prison gate for Rs 2.",
              ),
              VisitationInfoTile(
                title: "Visiting Schedule",
                content: "Visits are generally conducted as follows:\n\n"
                    "Central Jails: Tue, Wed, Thu, Sat, Sun\n"
                    "District Jails ‘A’ & ‘B’ Classes: Tue, Wed, Sat, Sun\n"
                    "Sub-Jails: Tue, Wed, Sat, Sun\n"
                    "Women Reformatory: Wed and Sun\n"
                    "Young Offenders’ Reformatory: Wed and Sun\n\n"
                    "Visiting hours: 10 AM to 12 PM, 3 PM to 4 PM. Duration of visit: 45 minutes.",
              ),
              VisitationInfoTile(
                title: "Who Can Visit?",
                content:
                    "Relatives and friends are allowed to visit prisoners for discussing domestic matters only. Up to 3 persons can visit at a time.",
              ),
              VisitationInfoTile(
                title: "Items Permitted During Visit",
                content:
                    "Food articles are not allowed for prisoners where Jail canteens are functional. In other jails, prisoners can receive fruits, biscuits, toiletries, etc., from visitors, subject to jail incharge's discretion. Except convicted prisoners, others can receive civil dress as well.",
              ),
              VisitationInfoTile(
                title: "Visit Procedure",
                content:
                    "Every visitor will be searched by prison staff. Permissible items like fruits, biscuits, and toiletries are allowed in limited quantity. Female visitors will be searched by female staff.",
              ),
              VisitationInfoTile(
                title: "Legal Counsel Visits",
                content:
                    "Legal counsels can visit prisoners during working hours, except government holidays, by making an application to the Superintendent.",
              ),
              VisitationInfoTile(
                title: "How can a prisoner directly contact with their family?",
                content:
                    "Inmates can send and receive letters to/from relatives, friends, and consuls. All inmate-written communication is subject to censorship by prison authorities. Needy inmates are provided with postcards for letter writing.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VisitationInfoTile extends StatelessWidget {
  final String title;
  final String content;

  VisitationInfoTile({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
