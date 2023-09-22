import 'package:flutter/material.dart';

class Rights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Access to Rights'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionTile(
                title: 'Prisoners\' Rights in Constitution of India',
                content: ConstitutionRights(),
              ),
              SectionTile(
                title: 'Rights of Prisoners Under Code of Criminal Procedure',
                content: CriminalProcedureRights(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTile extends StatelessWidget {
  final String title;
  final List<Widget> content;

  SectionTile({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the background color here
      child: ExpansionPanelList(
        elevation: 1,
        expandedHeaderPadding: EdgeInsets.all(10),
        dividerColor: Colors.grey,
        animationDuration: Duration(milliseconds: 500),
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            body: Column(
              children: content,
            ),
            isExpanded: true, // Initially expanded
          ),
        ],
      ),
    );
  }
}

List<Widget> ConstitutionRights() {
  return [
    RightsTile(
      title: 'Article 20 - Protection In Respect Of Conviction For Offences',
      content:
          '(1) No person shall be convicted of any offence except for violation of the law in force at the time of the commission of the act charged as an offence, nor be subjected to a penalty greater than that which might have been inflicted under the law in force at the time of the commission of the offence;\n\n'
          '(2) No person shall be prosecuted and punished for the same offence more than once;\n\n'
          '(3) No person accused of any offence shall be compelled to be a witness against himself',
    ),
    RightsTile(
      title: 'Article 21 - Protection Of Life And Personal Liberty',
      content:
          'No person shall be deprived of his life and personal liberty except according to procedure established by law.',
    ),
    RightsTile(
        title: 'Article 22',
        content:
            'The relevant parts of the provision are as follows: Protection against arrest and detention in certain cases;\n\n'
            '(1) No person who is arrested shall be detained in custody without being informed of the grounds of such arrest and he shall not be denied the right to consult and defend himself by a legal practitioner of his choice.;\n\n'
            '(2) Every person who is arrested and detained in custody shall be produced before the nearest magistrate within a period of twenty-four hours of such arrest;\n\n'
            '(3) Nothing in clauses (1) and (2) shall apply— \n\n'
            '(a) to any person who for the time being is an enemy alien; or \n\n'
            '(b) to any person who is arrested or detained under any law providing for preventive detention. \n\n'
            '(4) No law providing for preventive detention shall authorise the detention of a person for a longer period than three months unless— \n\n'
            '(a) an Advisory Board consisting of persons who are, or have been, or are qualified to be appointed as, Judges of a High Court has reported before the expiration of the said period of three months that there is in its opinion sufficient cause for such detention:Provided that nothing in this sub-clause shall authorise the detention of any person beyond the maximum period prescribed by any law made by Parliament under sub-clause (b) of clause (7); or \n\n'
            '(b) such person is detained in accordance with the provisions of any law made by Parliament under subclauses (a) and (b) of clause (7).\n\n'
            '(5) When any person is detained in pursuance of an order made under any law providing for preventive detention, the authority making the order shall, as soon as may be, communicate to such person the grounds on which the order has been made and shall afford him the earliest opportunity of making a representation against the order. \n\n'),
  ];
}

List<Widget> CriminalProcedureRights() {
  return [
    RightsTile(
      title: 'Right to Bail - Section 50',
      content:
          '(1) Every police officer or other person arresting any person without a warrant shall forthwith communicate to him full particulars of the offence for which he is arrested or other grounds for such arrest.\n\n'
          '(2) Where a police officer arrests without warrant any person other than a person accused of a non-bailable offence, he shall inform the person arrested that he is entitled to be released on bail and that he may arrange for sureties on his behalf.',
    ),
    RightsTile(
      title: 'Right To Be Taken To Magistrate Without Delay - Section 56',
      content:
          'A police officer making an arrest without warrant shall, without unnecessary delay and subject to the provisions herein contained as to bail, take or send the person arrested before a Magistrate having jurisdiction in the case, or before the officer in charge of a police station.',
    ),
    RightsTile(
      title: 'Right To Have Legal Practitioner - Section 41D',
      content:
          'When any person is arrested and interrogated by the police, he shall be entitled to meet an advocate of his choice during interrogation, though not throughout interrogation.',
    ),
    RightsTile(
      title: 'Right To Free Legal Aid - Section 304',
      content:
          'Where, in a trial before the Court of Session, the accused is not represented by a pleader, and where it appears to the Court that the accused has not sufficient means to engage a pleader, the Court shall assign a pleader for his defence at the expense of the State.',
    ),
    RightsTile(
      title: 'Right To Examination By Medical Practitioner - Section 54',
      content:
          '(1) When a person who is arrested, whether on a charge or otherwise, alleges, at the time when he is produced before a Magistrate or at any time during the period of his detention in custody that the examination of his body will afford evidence which will disprove the commission by him of any offence or which will establish the commission by any other person of any offence against his body, the Magistrate shall, if requested by the arrested person so to do direct the examination of the body of such person by a registered medical practitioner unless the Magistrate considers that the request is made for the purpose of vexation or delay or for defeating the ends of justice.\n\n'
          '(2) Where an examination is made under Sub-Section (1), a copy of the report of such examination shall be furnished by the registered medical practitioner to the arrested person or the person nominated by such arrested person.',
    ),
    RightsTile(
      title: 'Search - Section 51(2)',
      content:
          'Whenever it is necessary to cause a female to be searched, the search shall be made by another female with strict regard to decency.',
    ),
    RightsTile(
      title: 'Right To Be Present During Trial - Section 273',
      content:
          'Except as otherwise expressly provided, all evidence taken in the course of the trial or other proceeding shall be taken in the presence of the accused, or, when his personal attendance is dispensed with, in the presence of his pleader.',
    ),
    RightsTile(
      title: 'Right To Get Copies Of Documents - Section 208',
      content:
          '(i) the statements recorded under section 200 or section 202, of all persons examined by the Magistrate;\n\n'
          '(ii) the statements and confessions, if any, recorded under section 161 or section 164;\n\n'
          '(iii) any documents produced before the Magistrate on which the prosecution proposes to rely: Provided that if the Magistrate is satisfied that any such document is voluminous, he shall, instead of furnishing the accused with a copy thereof, direct that he will only be allowed to inspect it either personally or through pleader in Court.',
    ),
    RightsTile(
      title: 'Right To Appeal - Chapter XXIX',
      content:
          'Chapter XXIX of the Code provides for the right of Appeal in certain cases.',
    ),
    RightsTile(
      title: 'Right to Human Treatment - Section 55a',
      content:
          'It shall be the duty of the person having custody of an accused to take reasonable care of the health and safety of the accused.',
    ),
  ];
}

class RightsTile extends StatelessWidget {
  final String title;
  final String content;

  RightsTile({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(Icons.arrow_forward), // Arrow icon here
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: Text(content),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
