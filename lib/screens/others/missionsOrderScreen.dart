import 'package:delivery_man/Animation/FadeAnimation.dart';
import 'package:delivery_man/_model/customerOrderDetails.dart';
import 'package:delivery_man/_model/customers.dart';
import 'package:delivery_man/_model/orders.dart';
import 'package:delivery_man/_model/regions.dart';
import 'package:delivery_man/screens/others/widgets/orderCard.dart';
import 'package:delivery_man/translation/global_translation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class missionAllOrder extends StatefulWidget {
  List<customerOrderDetails> customerDetails = <customerOrderDetails>[];
  missionAllOrder({this.customerDetails});
  @override
  _missionAllOrderState createState() => _missionAllOrderState();
}

class _missionAllOrderState extends State<missionAllOrder> {
  var numberOfAllOrder = 0;
  var numberOfPendingOrder = 0;
  var numberOFComplatedOrder = 0;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  bool downloaded = false;
  String delivaryId;
  List<customerOrderDetails> customerDetailsList = <customerOrderDetails>[];

  void getOrderDetails() {
    for (var customerOrderDetails in widget.customerDetails) {
      numberOfAllOrder++;
      if (customerOrderDetails.order.state != "completed") {
        numberOfPendingOrder++;
      } else {
        // completed
        numberOFComplatedOrder++;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAuth.instance.currentUser().then((user) {
      delivaryId = "22";
    }).whenComplete(() async {
      await getOrdersForSpecificDelivary();
      if (mounted) {
        setState(() {
          downloaded = true;
          customerDetailsList.sort((a, b) {
            var adate = a.order.date;
            var bdate = b.order.date;
            return adate.compareTo(bdate);
          });
        });
      }
    });
    if (mounted) {
      setState(() {});
    }

    getOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF21d493),
          centerTitle: true,
          title: Text(
            translations.text("MissionsPage.appbartitle"),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            FadeAnimation(
              1.6,
              Text(
                translations.text("MissionsPage.title"),
                style: (TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
              ),
            ),
            FadeAnimation(
                1.8,
                Container(
                  height: 150,
                  margin:
                      EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 40),
                  child: Image.asset(
                    "assets/images/number_all_order.png",
                  ),
                )),
            FadeAnimation(
                2.0,
                Card(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  elevation: 10.0,
                  child: Row(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              translations.text("MissionsPage.TotalText"),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "$numberOfAllOrder",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: new SizedBox(
                          width: 3.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: 50.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      //VerticalDivider(thickness: 8.0,color: Colors.red,width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[100],
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(5.0))),
                                //width: SizeConfig.getResponsiveWidth(90.0),
                                //height: SizeConfig.getResponsiveHeight(30.0),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        translations
                                            .text("MissionsPage.PendingText"),
                                        style: new TextStyle(
                                            color: Colors.yellow,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Text(
                                "$numberOfPendingOrder",
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35.0),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(5.0))),
                                //width: SizeConfig.getResponsiveWidth(90.0),
                                //height: SizeConfig.getResponsiveHeight(30.0),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        translations
                                            .text("MissionsPage.ComplatedText"),
                                        style: new TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Text(
                                "$numberOFComplatedOrder",
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            FadeAnimation(
              2.0,
              Text(
                translations.text("MissionsPage.DetailsText"),
                style: (TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            (downloaded == false)
                ? Center(child: CircularProgressIndicator())
                : FadeAnimation(
                    2.2,
                    ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: customerDetailsList.length,
                        itemBuilder: (context, ind) {
                          return Ordercard(
                              customerDetails:
                                  customerDetailsList.elementAt(ind));
                        }),
                  ),
          ],
        ));
  }

  void getOrdersForSpecificDelivary() async {
    // get the orders for the user..
    await _database
        .reference()
        .child("orders")
        .orderByChild("deliveryManID")
        .equalTo(delivaryId)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> ordersMap = snapshot.value;
      ordersMap.forEach((key, value) async {
        customerOrderDetails next = new customerOrderDetails();
        orders order = orders.fromMap(value, key);
        next.order = order;

        // get the customer of that order.
        await _database
            .reference()
            .child("customers")
            .orderByKey()
            .equalTo("KUqs8uuHw2flzKDqPu1kCPDavLR2")
        //order.customerID
            .once()
            .then((DataSnapshot sdnap) async {
          Map<dynamic, dynamic> custmomer = sdnap.value;
          await custmomer.forEach((key, value) async {
            customers customer = customers.fromMap(value, key);
            next.customer = customer;
            // customerDetails.add(next);
          });
        });

        // get the region details for that customer..try
        await _database
            .reference()
            .child("regions")
            .child("-M4zpMl9qHoQQoeAB2Vw")//next.customer.regionID
            .once()
            .then((DataSnapshot snap) {
          regions customerRegions = regions.fromSnapshot(snap);
          next.region = customerRegions;
          customerDetailsList.add(next);
        }).then((_) {
          if (mounted) {
            setState(() {});
          }
        });

//        // get the city of the user
//        await _database
//            .reference()
//            .child("_cities")
//            .child(next.region.citiesID)
//            .once()
//            .then((DataSnapshot snapp) {
//          cities customerCity = cities.fromSnapshot(snapp);
//          next.city = customerCity;
//
//        });
      });
    });
  }
}
