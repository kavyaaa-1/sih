import 'dart:developer';

import 'package:sih_project/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, familyCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    familyCollection = db.collection(USER_COLLECTION);
  }
}
