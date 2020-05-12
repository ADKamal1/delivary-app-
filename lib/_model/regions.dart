import 'package:firebase_database/firebase_database.dart';

class regions {
  String regionID;
  String title;
  String citiesID;
  String arabicTitle;
  double latitude;
  double longitude;
  double fees;

  regions(this.title, this.citiesID, this.arabicTitle, this.latitude,
      this.longitude, this.fees);

  Map toJson() => {
    'regionID': regionID,
    'title': title,
    'citiesID': citiesID,
    'arabicTitle': arabicTitle,
    'latitude': latitude,
    'longitude': longitude,
    'fees': fees
  };

  regions.fromSnapshot(DataSnapshot snap)
      : this.regionID = snap.key,
        this.title = snap.value["title"],
        this.arabicTitle = snap.value["arabicTitle"],
        this.latitude = snap.value["latitude"],
        this.longitude = snap.value["longitude"],
        this.fees =snap.value["fees"] + 0.0;


  regions.fromMap(Map<dynamic, dynamic> value, String key):
        this.regionID = key,
        this.title = value["title"],
        this.arabicTitle = value["arabicTitle"],
        this.latitude = value["latitude"],
        this.longitude = value["longitude"],
        this.fees = (value["fees"] == null)?0.0:(value["fees"]+0.0);



  Map toMap() {
    return {
      "regionID": regionID,
      "title": title,
      "citiesID": citiesID,
      "arabicTitle": arabicTitle,
      "latitude": latitude,
      "longitude": longitude,
      "fees": fees
    };
  }
}
