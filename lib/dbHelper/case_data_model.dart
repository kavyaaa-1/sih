import 'dart:convert';

Case mongoDbFromJson(String str) => Case.fromJson(json.decode(str));

String mongoDbToJson(Case data) => json.encode(data.toJson());

class Case {
  //ObjectId? id;
  String case_Id;
  String case_desc;
  String type;
  String loc;
  DateTime offense_date;
  String inmate_ID;
  String prisoner_name;
  String DOB;
  String gender;
  DateTime date_arrest;
  String arresting_officer;
  String arrest_loc;
  List? evidence;
  bool isClosed;
  String? PID;
  String? LID;
  String? JID;
  bool assigned;

  Case(
      {required this.case_Id,
      required this.case_desc,
      required this.type,
      required this.loc,
      required this.offense_date,
      required this.inmate_ID,
      required this.prisoner_name,
      required this.DOB,
      required this.gender,
      required this.date_arrest,
      required this.arresting_officer,
      required this.arrest_loc,
      required this.evidence,
      required this.isClosed,
      required this.PID,
      required this.LID,
      required this.JID,
      required this.assigned});

  factory Case.fromJson(Map<String, dynamic> json) => Case(
      case_Id: json['case_Id'],
      case_desc: json['case_desc'],
      type: json['type'],
      loc: json['loc'],
      offense_date: json['offense_date'],
      inmate_ID: json['inmate_ID'],
      prisoner_name: json['prisoner_name'],
      DOB: json['DOB'],
      gender: json['gender'],
      date_arrest: DateTime.parse(json['date_arrest']),
      arresting_officer: json['arresting_officer'],
      arrest_loc: json['arrest_loc'],
      evidence: json['evidence'],
      PID: json['PID'],
      LID: json['LID'],
      JID: json['JID'],
      isClosed: json['isClosed'],
      assigned: json['assigned']);

  Map<String, dynamic> toJson() => {
        'case_Id': case_Id,
        'case_desc': case_desc,
        'type': type,
        'loc': loc,
        'offense_date': offense_date,
        'inmate_ID': inmate_ID,
        'prisoner_name': prisoner_name,
        'DOB': DOB,
        'gender': gender,
        'date_arrest': date_arrest.toIso8601String(),
        'arresting_officer': arresting_officer,
        'arrest_loc': arrest_loc,
        'evidence': evidence,
        'PID': PID,
        "JID": JID,
        "LID": LID,
        "isClosed": isClosed,
        "assigned": assigned,
      };
}
