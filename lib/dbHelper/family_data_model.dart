import 'dart:convert';

Family mongoDbFromJson(String str) => Family.fromJson(json.decode(str));

String mongoDbToJson(Family data) => json.encode(data.toJson());

class Family {
  //ObjectId? id;
  String phone;
  String pswd;
  String caseId;

  Family({
    //this.id,
    required this.phone,
    required this.pswd,
    required this.caseId,
  });

  factory Family.fromJson(Map<String, dynamic> json) => Family(
        //id: json["id"],
        phone: json["phone"],
        pswd: json["pswd"],
        caseId: json["case_ID"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "phone": phone,
        "pswd": pswd,
        "case_ID": caseId,
      };
}
