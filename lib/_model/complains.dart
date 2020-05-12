import 'package:firebase_database/firebase_database.dart';

class complains {
  String complainID;
  String customerID;
  String message;

  Map toJson() => {"customerID": customerID, "message": message};

  complains(this.customerID, this.message);

  complains.fromSnapshot(DataSnapshot snap)
      : this.complainID = snap.key,
        this.customerID = snap.value["customerID"],
        this.message = snap.value["message"];

  Map toMap() {
    return {"customerID": customerID, "message": message};
  }
}
