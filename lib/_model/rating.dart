import 'package:firebase_database/firebase_database.dart';

class ratings {
  String ratingId;
  String customerID;
  String productID;
  double rating;
  String comment;
  String isApproved;

  Map toJson() => {
        'customerID': customerID,
        'productID': productID,
        'rating': rating,
        'comment': comment,
        'isApproved': isApproved
      };

  ratings.fromSnapshot(DataSnapshot snap, String category)
      : this.ratingId = snap.key,
        this.customerID = snap.value["customerID"],
        this.productID = snap.value["productID"],
        this.rating = snap.value["rating"].toDouble(),
        this.comment = snap.value["comment"],
        this.isApproved = snap.value["isApproved"];

  ratings.fromMap(Map<dynamic, dynamic> value, String key){
    this.ratingId = key;
    this.customerID = value["customerID"];
    this.productID = value["productID"];
    this.rating = value["rating"].toDouble();
    this.comment = value["comment"];
    this.isApproved = value["isApproved"];
  }



  Map toMap() {
    return {
      "customerID": customerID,
      "productID": productID,
      "rating": rating,
      "comment": comment,
      "isApproved": isApproved
    };
  }
}
