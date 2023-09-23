import 'package:flutter/material.dart';

class IPC extends StatefulWidget {
  @override
  _IPCState createState() => _IPCState();
}

class _IPCState extends State<IPC> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Penal Code'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search by Section Number',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            ..._buildSectionTiles(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSectionTiles() {
    List<Widget> sectionTiles = [];
    for (var section in sections) {
      if (_searchText.isEmpty ||
          section['id']!.toLowerCase().contains(_searchText.toLowerCase())) {
        sectionTiles.add(
          CustomTile(
            title: section['title'],
            description: section['text'],
          ),
        );
      }
    }
    return sectionTiles;
  }
}

class CustomTile extends StatelessWidget {
  final String? title;
  final String? description;

  CustomTile({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: Color(0xff8336f4),
            width: 1.5,
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  top: 8.0,
                ),
                child: Text(
                  title ?? 'Title not available',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8336f4),
                  ),
                ),
              ),
              Divider(
                color: Color(0xff8336f4),
                thickness: 1.0,
              ),
              Text(
                description ?? 'Description not available',
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, String>> sections = [
  {
    "id": "2",
    "title": "Section 2 in The Indian Penal Code",
    "text":
        "Every person shall be liable to punishment under this Code and not otherwise for every act or omission contrary to the provisions thereof, of which he shall be guilty within India."
  },
  {
    "id": "3",
    "title": "Section 3 in The Indian Penal Code",
    "text":
        "Any person liable, by any Indian law to be tried for an offence committed beyond India shall be dealt with according to the provisions of this Code for any act committed beyond India in the same manner as if such act had been committed within India."
  },
  {
    "id": "4",
    "title": "Section 4 in The Indian Penal Code",
    "text":
        "Extension of Code to extra-territorial offences. '\n' The provisions of this Code apply also to any offence committed by:— '\n'   1. Any citizen of India in any place without and beyond India; '\n' 2. Any person on any ship or aircraft registered in India wherever it may be."
  },
  {
    "id": "5",
    "title": "Section 5 in The Indian Penal Code",
    "text":
        "Certain laws not to be affected by this Act. Nothing in this Act shall affect the provisions of any Act for punishing mutiny and desertion of officers, soldiers, sailors or airmen in the service of the Government of India or the provisions of any special or local law."
  },
  {
    "id": "6",
    "title": "Section 6 in The Indian Penal Code",
    "text":
        "Definitions in the Code to be understood subject to exceptions. Throughout this Code every definition of an offence, every penal provision and every illustration of every such definition or penal provision shall be understood subject to the exceptions contained in the chapter entitled \"General Exceptions,\" though those exceptions are not repeated in such definition, penal provision or illustration."
  },
  {
    "id": "7",
    "title": "Section 7 in The Indian Penal Code",
    "text":
        "Sense of expression once explained. Every expression which is explained in any part of this Code is used in every part of this Code in conformity with the explanation."
  },
  {
    "id": "8",
    "title": "Section 8 in The Indian Penal Code",
    "text":
        "Gender. The pronouns \"he\" and \"him\" denote a male, \"she\" and \"her\" denote a female. The word \"person\" includes any Company or Association or body of persons, whether incorporated or not."
  },
  {
    "id": "9",
    "title": "Section 9 in The Indian Penal Code",
    "text":
        "Number.The word \"number\" shall include any letter, punctuation mark or other symbol which expresses or implies a number, or is used as a numeral."
  },
  {
    "id": "10",
    "title": "Section 10 in The Indian Penal Code",
    "text":
        "Things done by accident or misfortune— Nothing is an offence which is done by accident or misfortune, and without any criminal intention or knowledge in the doing of a lawful act in a lawful manner by lawful means and with proper care and caution."
  },
  {
    "id": "20",
    "title": "Section 20 in The Indian Penal Code",
    "text":
        "“Criminal conspiracy”.—(1) Except in the States of Jammu and Kashmir, A person who, with the intention of committing an offence, agrees with any other person to commit the offence shall, where no express provision is made by this Code for the punishment of such a conspiracy, be punished with imprisonment of either description for a term not exceeding six months, or with fine or with both."
  },
  {
    "id": "50",
    "title": "Section 50 in The Indian Penal Code",
    "text":
        "“Punishment of abetment if the act abetted is committed in consequence and where no express provision is made for its punishment”.—The punishment of abetment where there is no express provision in this Code for the punishment of the act abetted, shall be the same as is provided for the offence abetted."
  },
  {
    "id": "100",
    "title": "Section 100 in The Indian Penal Code",
    "text":
        "When the right of private defence of the body extends to causing death.—The right of private defence of the body extends, under the restrictions mentioned in the last preceding section,to the voluntary causing of death or of any other harm to the assailant, if the offence which occasions the exercise of the right be of any of the descriptions hereinafter enumerated, namely:—"
  },
  {
    "id": "150",
    "title": "Section 150 in The Indian Penal Code",
    "text":
        "“Hiring, or conniving at hiring, of persons to join unlawful assembly”.—Whoever hires or engages,or employs, or promotes, or connives at the hiring, engagement or employment of any person to join or become a member of any unlawful assembly, shall be punishable as a member of such unlawful assembly, and for any offence which may be committed by any such person as a member of such unlawful assembly in pursuance of such hiring, engagement or employment, in the same manner and to the same extent as if he had been a member of such unlawful assembly, or himself had committed such offence."
  },
  {
    "id": "200",
    "title": "Section 200 in The Indian Penal Code",
    "text":
        "Using as true such declaration knowing it to be false.—Whoever corruptly uses or attempts to use as true any such declaration, knowing the same to be false in any material point, shall be punished in the same manner as if he gave false evidence."
  }

  // Add more sections as needed
];
