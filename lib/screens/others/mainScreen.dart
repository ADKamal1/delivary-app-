import 'dart:async';
import 'dart:io';
import 'package:delivery_man/Animation/FadeAnimation.dart';
import 'package:delivery_man/_model/Product_Offer.dart';
import 'package:delivery_man/_model/customerOrderDetails.dart';
import 'package:delivery_man/_model/customers.dart';
import 'package:delivery_man/_model/deliveryMen.dart';
import 'package:delivery_man/_model/offerProducts.dart';
import 'package:delivery_man/_model/offers.dart';
import 'package:delivery_man/_model/orders.dart';
import 'package:delivery_man/_model/product.dart';
import 'package:delivery_man/_model/regions.dart';
import 'package:delivery_man/screens/others/unFinishedOrdersScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../model/Order.dart';
import '../../model/orderData.dart';
import 'package:flutter/cupertino.dart';
import '../drawer.dart';
import '../../utils/size_config.dart';
import 'package:flutter/material.dart';
import 'allFinishedOrderScreen.dart';
import '../../translation/global_translation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class yourOrder extends StatefulWidget {
  _yourOrder createState() => new _yourOrder();
}

class _yourOrder extends State<yourOrder> with SingleTickerProviderStateMixin {

  Map _source = {ConnectivityResult.wifi: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  var url;

  FirebaseDatabase _database = FirebaseDatabase.instance;

  List<customerOrderDetails> customerDetails = <customerOrderDetails>[];
  static List<Product_Offer> productsForOffer = <Product_Offer>[];
  List<offers> offers_list = <offers>[];
  List<offerProducts> offer_products = <offerProducts>[];

  String deliveryId = "22";            //// - when start app get Current User and get Id For Delivery Men
  deliveryMen currentDeliveryMen ;
  regions regionForThatDeliveryMen;



  void getOfferList() async{
//    await _database
//          .reference()
//          .child("offers")
//          .once()
//          .then((DataSnapshot snapshot) {
//      Map<dynamic, dynamic> productsMap = snapshot.value;
//      productsMap.forEach((key, value) {
//        offers_list.add(offers.fromMap(value, key));
//      });
//    });

    await _database
        .reference()
        .child("offerProducts")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> productsMap = snapshot.value;
      productsMap.forEach((key, value) {
        print("offer product in offerProducts = " + value.toString());
        offer_products.add(offerProducts.fromMap(value, key));
      });
    }).whenComplete(()async {
     await _database
          .reference()
          .child("offers")
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> productsMap = snapshot.value;
        productsMap.forEach((key, value) {
          offers_list.add(offers.fromMap(value, key));
        });
      }).whenComplete(() async{
        for (var offer in offer_products) {
          offers newOffer = new offers();
          Product nextProduct = new Product();
          for (var of in offers_list) {
            if (offer.offerID == of.offerID) {
              newOffer = of;
             await  _database
                  .reference()
                  .child("products")
                  .child(offer.productID)
                  .once()
                  .then((DataSnapshot snapshot) {
                nextProduct = Product.fromMap(snapshot.value, snapshot.key);
              }).whenComplete(() {
                productsForOffer.add(new Product_Offer(newOffer, nextProduct));
                if (mounted) setState(() {});
              });
            }
          }

        }
      });
    });
    if(mounted)
      setState(() {

      });
  }



  // get the details of the order
  void getOrdersForSpecificDelivary() async {

    print("\nddvdsvdsvdsvsvsvv");
    print("\n"+deliveryId);

    // get the orders for the user..
    await _database
        .reference()
        .child("orders")
        .orderByChild("deliveryManID")
        .equalTo("22")                //// now is Constant 22  but after that getcurrent user from delivary app
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> ordersMap = snapshot.value;
     ordersMap.forEach((key, value) async {
        customerOrderDetails next = new customerOrderDetails();
       orders order = orders.fromMap(value, key);
       next.order = order;
//        print(order.customerID);

        // get the customer of that order.
        await _database
            .reference()
            .child("customers")
            .orderByKey()
            .equalTo("KUqs8uuHw2flzKDqPu1kCPDavLR2")
            .once()
            .then((DataSnapshot sdnap) async {
          Map<dynamic, dynamic> customer = sdnap.value;
          await customer.forEach((key, value) async {
            customers customer = customers.fromMap(value, key);
            next.customer = customer;
            customerDetails.add(next);
          }
          );
        });
       // print("dddddddd"+order.customerID);

        print("\n\n 55555555555 \n");
        print(next.order.orderID);
        //print(next.customer.name);
        print("\n\n 66666666 \n");

       // print(next.customer.regionID);

        ///  - get Region details for that customer about delivary Man
        /// deliveryMen deliverMen;
        //    await  _database
        //        .reference()
        //        .child("deliveryMen")
        //        .child(deliveryId)
        //        .once()
        //        .then((DataSnapshot snapshot) {
        //      deliverMen = deliveryMen.fromMap(snapshot.value, snapshot.key);
        //    });
        ///

        if(mounted)
          setState(() {

          });
      });
    });
//    print("\n\n");
//    print(currentDeliveryMen);
//    print(regionForThatDeliveryMen.arabicTitle);
  }


  /// --  Notifications
  String textValue = 'Hello World !';
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, "This is title", "this is demo", platform);
  }

  ////- that method for update data in Delivery Men and add Token for that DeliveryMen when open app from his Device.
  update(String token) async {
    deliveryMen deliverMen;
    await  _database
        .reference()
        .child("deliveryMen")
        .child(deliveryId)
        .once()
        .then((DataSnapshot snapshot) {
      deliverMen = deliveryMen.fromMap(snapshot.value, snapshot.key);
    });

    print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('deliveryMen/${deliveryId}').set({
      "token": token,
      "name":"syed sayed",
      "arabicName": deliverMen.arabicName,
      "phone": deliverMen.phone,
      "regionID": deliverMen.regionID
    },);
    textValue = token;
    setState(() {

    });
  }

  ForStrartNotifications() {
    ///- Notifications
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print(" onLaunch called ${(msg)}");
      },
      onResume: (Map<String, dynamic> msg) {
        print(" onResume called ${(msg)}");
      },
      onMessage: (Map<String, dynamic> msg) {
        showNotification(msg);
        print(" onMessage called ${(msg)}");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
    firebaseMessaging.getToken().then((token) {
      update(token);
    });


  }


  @override
  void initState() {
       super.initState();

       print("\n111111111111");
//    FirebaseAuth.instance.currentUser().then((user) {
//      deliveryId = user.uid;
//    }).whenComplete(() async {
//      await getOrdersForSpecificDelivary();
//    });
    getOrdersForSpecificDelivary();
    print("\n333333333");
    //update(token); (to add token current user to table)
    ///- and get all Notifications that delivered for his region
    ForStrartNotifications();

    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      if(mounted)
      setState(() => _source = source);
    });

    if(mounted)
         setState(() {

         });
    }



  @override
  Widget build(BuildContext context) {
    String internatStatus;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        internatStatus = "Offline";
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return Scaffold(
              backgroundColor: Colors.white,
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
                      translations.text('loginPage.deliveryManText'),
                      style: TextStyle(
                        fontSize: SizeConfig.getResponsiveWidth(25.0),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                  child: Container(
                child: Column(
                  children: <Widget>[
                    Container(child: showToast()),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      translations.text("mainScreenPage.YourOrder"),
                      style: TextStyle(
                          fontSize: SizeConfig.getResponsiveWidth(30.0),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/your_order.png",
                      width: 100.0,
                      height: 140.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          //onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>missiosAllOrder(orderData))),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllOrder(
                                      ))),
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Image.network(url),
//                              Image.asset(
//                                "assets/images/all_order.png",
//                                width: 80.0,
//                                height: 80.0,
//                                fit: BoxFit.cover,
//                                color: Color(0XFF21d493),
//                              ),
                              Text(
                                translations.text("mainScreenPage.unFinishedOrder"),
                                style: TextStyle(
                                  fontSize: SizeConfig.getResponsiveWidth(20.0),
                                  //fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            return Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UnfinishedOrders(
                                        productsForOffer:productsForOffer,
                                        )));
                          },
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Image.asset("assets/images/new_order.png",
                                  width: 80.0,
                                  height: 80.0,
                                  color: Color(0XFF21d493),
                                  fit: BoxFit.cover
                                  // fit: BoxFit.cover,
                                  ),
                              Text(
                                translations.text("mainScreenPage.FinishedOrder"),
                                style: TextStyle(
                                  fontSize: SizeConfig.getResponsiveWidth(20.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
              drawer: SideMenu(),
            );
          });
        });
        break;
      case ConnectivityResult.mobile:
        internatStatus = "Mobile: Online";
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return Scaffold(
              backgroundColor: Colors.white,
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
                      translations.text('loginPage.deliveryManText'),
                      style: TextStyle(
                        fontSize: SizeConfig.getResponsiveWidth(25.0),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    FadeAnimation(
                      1.6,
                      Text(
                        translations.text("mainScreenPage.YourOrder"),
                        style: TextStyle(
                            fontSize: SizeConfig.getResponsiveWidth(30.0),
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      1.8,
                      Image.asset(
                        "assets/images/your_order.png",
                        width: 100.0,
                        height: 140.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    FadeAnimation(
                      2.0,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            //onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>missiosAllOrder(orderData))),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllOrder(
                                        ))),
                            color: Colors.white,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/all_order.png",
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                  color: Color(0XFF21d493),
                                ),
                                Text(
                                  translations.text("mainScreenPage.unFinishedOrder"),
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.getResponsiveWidth(20.0),
                                    //fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                          FlatButton(
                          onPressed: (){},

//                              return Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => DetailedOrderScreen(
//                                          customerDetails: customerDetails)));

                            color: Colors.white,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Image.asset("assets/images/new_order.png",
                                    width: 80.0,
                                    height: 80.0,
                                    color: Color(0XFF21d493),
                                    fit: BoxFit.cover
                                    // fit: BoxFit.cover,
                                    ),
                                Text(
                                  translations.text("mainScreenPage.FinishedOrder"),
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.getResponsiveWidth(20.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              drawer: SideMenu(),
            );
          });
        });
        break;
      case ConnectivityResult.wifi:
        internatStatus = "WiFi: Online";
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return Scaffold(
              backgroundColor: Colors.white,
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
                      translations.text('loginPage.deliveryManText'),
                      style: TextStyle(
                        fontSize: SizeConfig.getResponsiveWidth(25.0),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    FadeAnimation(
                      1.6,
                      Text(
                        translations.text("mainScreenPage.YourOrder"),
                        style: TextStyle(
                            fontSize: SizeConfig.getResponsiveWidth(30.0),
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      1.8,
                      Image.asset(
                        "assets/images/your_order.png",
                        width: 100.0,
                        height: 140.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    FadeAnimation(
                      2.0,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => AllOrder()),
                              );
                            },
                            color: Colors.white,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/all_order.png",
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                  color: Color(0XFF21d493),
                                ),
                                Text(
                                  translations.text("mainScreenPage.FinishedOrder"),
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.getResponsiveWidth(20.0),
                                    //fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UnfinishedOrders(productsForOffer:productsForOffer,)));
                            },
                            color: Colors.white,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Image.asset("assets/images/new_order.png",
                                    width: 80.0,
                                    height: 80.0,
                                    color: Color(0XFF21d493),
                                    fit: BoxFit.cover
                                    // fit: BoxFit.cover,
                                    ),
                                Text(
                                  translations.text("mainScreenPage.unFinishedOrder"),
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.getResponsiveWidth(20.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Container(child:Text(currentDeliveryMen.name)),
                   // Container(child:Text(currentDeliveryMen.regionID)),
                    //Container(child:Text(regionForThatDeliveryMen.arabicTitle)),
                  ],
                ),
              ),
              drawer: SideMenu(customerDetails: customerDetails,
              ),
            );
          });
        });
    }
  }

  //     ---    List getAllOrderProductsForUser() {}

  ///- toast say the connection to internat Field;
  Widget showToast() {
    Fluttertoast.showToast(
      msg: ' Connetion to Internat Field ',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red[800],
      textColor: Colors.white,
    );
  }

}

/// this class for check internat in app
class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}

///- that class for Animation of buttons
class ScaleRotateRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRotateRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: RotationTransition(
              turns: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linear,
                ),
              ),
              child: child,
            ),
          ),
        );
}
