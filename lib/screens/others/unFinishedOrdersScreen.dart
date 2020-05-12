import 'package:delivery_man/_model/Product_Offer.dart';
import 'package:delivery_man/_model/customerOrderDetails.dart';
import 'package:delivery_man/_model/customers.dart';
import 'package:delivery_man/_model/orders.dart';
import 'package:delivery_man/_model/regions.dart';
import 'package:delivery_man/model/ord.dart';
import 'package:delivery_man/translation/global_translation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'widgets/orderCard.dart';
import '../../utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UnfinishedOrders extends StatefulWidget {
  List<Product_Offer> productsForOffer = <Product_Offer>[];
  UnfinishedOrders({this.productsForOffer});
  @override
  _UnfinishedOrders createState() => _UnfinishedOrders();
}

class _UnfinishedOrders extends State<UnfinishedOrders> {
  List<Orderr> itemsOrder = List();
  Orderr itemOrder;
  String delivaryId;
  DatabaseReference itemRefOrder;
  ScrollController _controller = new ScrollController();
  FirebaseDatabase _database = FirebaseDatabase.instance;
  bool downloaded = false;
  List<customerOrderDetails> customerDetailsList = <customerOrderDetails>[];



  @override
  void initState() {
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

  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0XFF21d493),
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: SizeConfig.getResponsiveWidth(30.0),
                  height: SizeConfig.getResponsiveHeight(30.0),
                  //margin: EdgeInsets.only(bottom: SizeConfig.getResponsiveHeight(5.0),top:SizeConfig.getResponsiveHeight(10.0)),
                  child: Image.asset(
                    "assets/images/delivery_man.png",
                    //color: Colors.white,
                  ),
                ),

                Text(
                  translations.text("AllOrderPage.appbartitle"),
                  style: TextStyle(
                    fontSize: SizeConfig.getResponsiveWidth(25.0),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(SizeConfig.getResponsiveWidth(10)),
                  child: Image.asset(
                    "assets/images/all_order.png",
                    width: 90.0,
                    height: 90.0,
                    fit: BoxFit.contain,
                  ),
                ),
                (downloaded == false)
                    ? Container()
                    : (customerDetailsList.length == 0)
                    ? Container(
                  //child: Text("NO ORDERED RECEVED"),
                ):
                Container(
                  margin: EdgeInsets.all(SizeConfig.getResponsiveWidth(10)),
                  child: Text(
                    translations.text("AllOrderPage.title"),
                    style: TextStyle(
                        fontSize: SizeConfig.getResponsiveWidth(25.0),
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                (downloaded == false)
                    ? Center(child:CircularProgressIndicator(
                  backgroundColor: Colors.black,

                )) :
                ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: customerDetailsList.length,
                    itemBuilder: (context, ind) {
                      if(customerDetailsList.elementAt(ind).order.state != "completed") {
                        return Ordercard(

                            productsForOffer:widget.productsForOffer,
                            customerDetails:
                            customerDetailsList.elementAt(ind));
                      }else{
                        return Container(color: Colors.yellow,);
                      }
                    }),
              ],
            ),
          ),
        );
      });
    });
  }



  void getOrdersForSpecificDelivary() async {
    // get the orders for the user..
    await _database
        .reference()
        .child("orders")
        .orderByChild("deliveryManID")
        .equalTo("22")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> ordersMap = snapshot.value;
      ordersMap.forEach((key, value) async {
        customerOrderDetails next = new customerOrderDetails();
        orders order = orders.fromMap(value, key);
        next.order = order;
        print(order.customerID+"cccccccccccccccccccc");

        // get the customer of that order.
        await _database
            .reference()
            .child("customers")
            .orderByKey()
            .equalTo(order.customerID)
            .once()
            .then((DataSnapshot sdnap) async {
          Map<dynamic, dynamic> customer = sdnap.value;
          await customer.forEach((key, value) async {
            customers customer = customers.fromMap(value, key);
            next.customer = customer;
            // customerDetails.add(next);
          });
        });

        // get the region details for that customer..try
        await _database
            .reference()
            .child("regions")
            .child("-M4zpMl9qHoQQoeAB2Vw")
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
