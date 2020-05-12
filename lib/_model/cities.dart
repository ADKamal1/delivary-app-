import 'package:firebase_database/firebase_database.dart';

class cities {
  String cityID;
  String title;
  String arabicTitle;

  Map toJson() => {"title": title, "arabicTitle": arabicTitle};

  cities.fromSnapshot(DataSnapshot snap)
      : this.cityID = snap.key,
        this.arabicTitle = snap.value["arabicTitle"],
        this.title = snap.value["title"];

  cities.fromMap(Map<dynamic , dynamic> value , String key)
      :this.cityID = key,
        this.arabicTitle = value["arabicTitle"],
        this.title = value["title"];
  Map toMap() {
    return {"title": title, "arabicTitle": arabicTitle};
  }
}
