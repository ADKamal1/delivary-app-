import 'package:firebase_database/firebase_database.dart';

class categories {
  String categoryID;
  String title;
  String arabicTitle;
  String photo;

  categories(this.title, this.arabicTitle, this.photo);

  Map toJson() => {
        'categoryID': categoryID,
        'title': title,
        'arabicTitle': arabicTitle,
        'photo': photo,
      };

  categories.fromSnapshot(DataSnapshot snap)
      : this.categoryID = snap.key,
        this.title = snap.value["title"],
        this.arabicTitle = snap.value["arabicTitle"],
        this.photo = snap.value["photo"];


  categories.fromMap(Map<dynamic , dynamic> value , String id)
      : this.categoryID=id,
        this.title = value["title"],
        this.arabicTitle =value["arabicTitle"],
        this.photo = value["photo"];

  Map toMap() {
    return {
      "categoryID": categoryID,
      "title": title,
      "arabicTitle": arabicTitle,
      "photo": photo,
    };
  }
}
