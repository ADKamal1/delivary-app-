import 'package:firebase_database/firebase_database.dart';

class offers {
  String offerID;
  String title;
  String arabicTitle;
  double rate;
  String fromDate;
  String toDate;

  offers({this.title, this.arabicTitle, this.rate, this.fromDate, this.toDate});

  Map toJson() => {
    'offerID': offerID,
    'title': title,
    'arabicTitle': arabicTitle,
    'rate': rate,
    'fromDate': fromDate,
    'toDate': toDate
  };

  offers.fromMap(Map<dynamic , dynamic> value , String key)
      : this.offerID = key,
        this.title = value["title"],
        this.arabicTitle = value["arabicTitle"],
        this.rate = value["rate"],
        this.fromDate = value["fromDate"],
        this.toDate = value["toDate"];

  offers.fromSnapshot(DataSnapshot snap)
      : this.offerID = snap.key,
        this.title = snap.value["title"],
        this.arabicTitle = snap.value["arabicTitle"],
        this.rate = snap.value["rate"],
        this.fromDate = snap.value["fromDate"],
        this.toDate = snap.value["toDate"];

  Map toMap() {
    return {
      "offerID": offerID,
      "title": title,
      "arabicTitle": arabicTitle,
      "rate": rate,
      "fromDate": fromDate,
      "toDate": toDate
    };
  }
}
