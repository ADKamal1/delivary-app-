import 'package:delivery_man/_model/Product_Offer.dart';
import 'package:delivery_man/_model/customerOrderDetails.dart';
import 'package:delivery_man/_model/customers.dart';
import 'package:delivery_man/_model/offerProducts.dart';
import 'package:delivery_man/_model/offers.dart';
import 'package:delivery_man/_model/orderProducts.dart';
import 'package:delivery_man/_model/orders.dart';
import 'package:delivery_man/_model/product.dart';
import 'package:delivery_man/_model/productOrderDetails.dart';
import 'package:delivery_man/screens/others/widgets/reviewCard.dart';
import 'widgets/customListTile.dart';
import 'package:delivery_man/translation/global_translation.dart';
import 'scan_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DetailedOrderScreen extends StatefulWidget {
  customerOrderDetails customerDetails;
  customers customer;
  List<Product_Offer> productsForOffer = <Product_Offer>[];

  DetailedOrderScreen({this.customerDetails, this.productsForOffer,this.customer});

  @override
  _DetailedOrderScreenState createState() =>
      _DetailedOrderScreenState(customerDetails: this.customerDetails);
}

class _DetailedOrderScreenState extends State<DetailedOrderScreen> {
  _DetailedOrderScreenState({this.customerDetails});
  String state;
  customers customer;
  customerOrderDetails customerDetails;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Product> orderList = <Product>[];
  List<offers> offers_list = <offers>[];
  List<orderProducts> orderProductsList = <orderProducts>[];
  List<ProductOrderDetails> productOrderDetails = <ProductOrderDetails>[];
  //
//  // if the product has offer it will return the id else will return -1
//  offers ifProductHaveOffer(String id_product) {
//    offers productOffer;
//    String offerIdOfThatProduct ;
//    _database.reference().child("offerProducts").orderByChild("productID").equalTo(id_product)
//    .once().then((DataSnapshot snapshot){
//          Map<dynamic, dynamic> offerm = snapshot.value;
//          if(offerm !=null)
//          offerm.forEach((key, value) async {
//            offerProducts offer = offerProducts.fromMap(value, key);
//             if(offer.productID ==id_product){
//               offerIdOfThatProduct = offer.offerID;
//             }
//          });
//    });
//    if(offerIdOfThatProduct == null)return productOffer;
//    for(var off in offers_list){
//        if(off.offerId == offerIdOfThatProduct){
//           return off;
//        }
//    }
//
//    return productOffer;
//  }
//
//  getAllOffers() async {
//    await _database
//        .reference()
//        .child("offers")
//        .once()
//        .then((DataSnapshot snapshot) {
//      Map<dynamic, dynamic> productsMap = snapshot.value;
//      productsMap.forEach((key, value) {
//        offers_list.add(offers.fromMap(value, key));
//      });
//    });
//    if (mounted) setState(() {});
//  }

  // get all the order products given the orderId...
  void getAllOrderProductsOfOrder(String orderId) async {
    await _database
        .reference()
        .child("orderProducts")
        .orderByChild("orderID")
        .equalTo(orderId)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> ordersProducts = snapshot.value;
      ordersProducts.forEach((key, value) async {
        orderProducts orderP = orderProducts.fromMap(value, key);
        orderProductsList.add(orderP);
      });
    });

    for (var orderProducts in orderProductsList) {
      await _database
          .reference()
          .child("products")
          .orderByKey()
          .equalTo(orderProducts.productID)
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> productsOfOrder = snapshot.value;
        productsOfOrder.forEach((key, value) async {
          Product nextProduct = Product.fromMap(value, key);
          orderList.add(nextProduct);
          productOrderDetails.add(new ProductOrderDetails(
              orderProduct: orderProducts, product: nextProduct));
        });
      });
    }
    if (mounted) {
      setState(() {});
    }
  }

  initState() {
//    getAllOffers();
    getAllOrderProductsOfOrder(customerDetails.order.orderID);

    state = customerDetails.order.state.toString();
    if (mounted) setState(() {});
    print("order list has = " + orderList.length.toString());
  }

  double SubTotal = 90.0;
  double DeliveryCharge = 3.0;
  double freeDeliveryCharge = 80.0;
  double total = 80.0;
  double ValueAddedTax = 80.0;
  String clientAddress = "Egypt,Fayoum,Desia";
  String clientPhoneNumber = "01156281273";
  double onMoveLatitude = 24.633333;
  double onMoveLongitude = 46.716667;

  /// to open google maps in determined Location
  static Future<void> openGoogleMapApp(
      {double latitude, double longitude}) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
      print('opnenig');
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    //ScrollController _scrollController = new ScrollController();

    double deliveryCharge =
        double.parse(widget.customerDetails.region.fees.toStringAsFixed(2));
    double freeForCashOfDelivery =
        (widget.customerDetails.order.totalPrice > 100) ? 0.0 : 10;
    double overAll = double.parse(
        (widget.customerDetails.order.totalPrice).toStringAsFixed(2));

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
                  child: Image.asset(
                    "assets/images/delivery_man.png",
                    //color: Colors.white,
                  ),
                ),
                Text(
                  translations.text("NewOrderPage.appbartitle"),
                  style: TextStyle(
                    fontSize: SizeConfig.getResponsiveWidth(25.0),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          body: Stack(
            children:<Widget>[
              Container(
            padding: EdgeInsetsDirectional.only(bottom: 170),
                child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          translations.text("NewOrderPage.title"),
                          style: TextStyle(
                              fontSize: SizeConfig.getResponsiveWidth(20.0),
                              color: Color(0XFF21d493),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        "assets/images/new_order.png",
                        width: 60.0,
                        height: 50.0,
                        //fit: BoxFit.cover,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.getResponsiveWidth(5.0),
                            right: SizeConfig.getResponsiveWidth(5.0)),
                        child: Card(
                          elevation: 5.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Container(
                                          width:
                                              SizeConfig.getResponsiveWidth(30.0),
                                          height: SizeConfig.getResponsiveHeight(
                                              30.0),
                                          child: Card(
                                              color: Color.fromRGBO(
                                                  229, 249, 238, 1),
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0)),
                                              elevation: 0,
                                              child: Image.asset(
                                                  'assets/images/icons/payment-method.png'))),
                                      Text(
                                          translations.text(
                                              "NewOrderPage.PaymentMethodText"),
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.getResponsiveHeight(
                                                      12)))
                                    ])
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10),
                                color: Color.fromRGBO(242, 246, 249, 1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Radio(),
                                          Container(
                                            child: Text(
                                                translations.text(
                                                    "NewOrderPage.PayByCashText"),
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .getResponsiveHeight(
                                                            12))),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: SizeConfig.getResponsiveHeight(30.0),
                                      height:
                                          SizeConfig.getResponsiveHeight(30.0),
                                      child: Image.asset(
                                          "assets/images/icons/pay-cache.png"),
                                    )
//                  Container( margin:EdgeInsets.only(right: SizeConfig.getResponsiveHeight(20)),child: Icon(Icons.email ,size: SizeConfig.getResponsiveHeight(20),))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width:
                                            SizeConfig.getResponsiveWidth(30.0),
                                        height:
                                            SizeConfig.getResponsiveHeight(30.0),
                                        child: Card(
                                            color:
                                                Color.fromRGBO(229, 249, 238, 1),
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        25.0)),
                                            elevation: 0,
                                            child: Image.asset(
                                                'assets/images/icons/order-summary.png'))),
                                    new Text(
                                      translations
                                          .text("NewOrderPage.OrderSummaryText"),
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  CustomListTile(
                                    title: translations
                                        .text("NewOrderPage.DeliveryChargeText"),
                                    value:
                                        "${double.parse(freeForCashOfDelivery.toString()).toStringAsFixed(2)}",
                                  ),
                                  CustomListTile(
                                    title: translations
                                        .text("NewOrderPage.TotalText"),
                                    value:
                                        "${double.parse(overAll.toString()).toStringAsFixed(2)}",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 5, bottom: 10),
                        child: Card(
                          elevation: 5.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 30,
                                child: ListTile(
                                  //////  Client_adress donot apear
                                  leading: Image.asset(
                                    "assets/images/client_address.png",
                                    width: 40,
                                    color: Colors.green,
                                    height: 40,
                                  ),
                                  title: Text(
                                    translations
                                        .text("NewOrderPage.ClientAddressText"),
                                    style: TextStyle(
                                        //fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 40,
                                  ),
                                  title: Text(
                                    (translations.currentLanguage == 'ar')
                                        ? " ${widget.customerDetails.region.arabicTitle.toString()}"
                                        : " ${widget.customerDetails.region.title.toString()}",
                                    style: TextStyle(
                                        //fontSize: 20.0,
                                        //fontWeight: FontWeight.bold
                                        ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                height: 30,
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 40,
                                  ),
                                  title: Text(
                                    widget.customerDetails.customer.phone
                                        .toString(),
                                    style: TextStyle(
                                        //fontSize: 20.0,
                                        //fontWeight: FontWeight.bold
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            margin:
                                EdgeInsets.only(left: 40, right: 40, bottom: 10),
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  openGoogleMapApp(
                                      latitude:
                                          widget.customerDetails.region.latitude,
                                      longitude: widget
                                          .customerDetails.region.longitude);
                                });
                              },
                              color: Color(0XFF21d493),
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Row(
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/maps_location.png",
                                    width: SizeConfig.getResponsiveWidth(40),
                                  ),
                                  Text(
                                    translations
                                        .text("NewOrderPage.ClientLocationOnMap"),
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.getResponsiveWidth(12)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Color.fromRGBO(229, 249, 239, 1),
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.getResponsiveHeight(5.0),
                                right: SizeConfig.getResponsiveWidth(90.0),
                                left: SizeConfig.getResponsiveWidth(90.0),
                                top: SizeConfig.getResponsiveHeight(2)),
                            child: new FlatButton(
                              padding: EdgeInsets.all(7.0),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0)),
                              child: new Text(
                                "Review Your Order",
                                style: TextStyle(
                                    fontSize: SizeConfig.getResponsiveHeight(10),
                                    color: Color.fromRGBO(33, 213, 147, 1)),
                              ),
                              onPressed: () {
                                return _displayDialog(context);
                              },
                            ),
                          ),
                          /////  buttton open QR Code
                          Container(
                            height: 30,
                            margin:
                                EdgeInsets.only(left: 20, right: 10, bottom: 50),
                            child: FlatButton(
                              onPressed: () {
                                return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => qrCodeScan()));
                              },
                              color: Color(0XFF21d493),
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Text(translations
                                  .text("NewOrderPage.OrderDeliverdAssurance")),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),


                ],
            ),

              ),
              Positioned(
                  bottom: 0,

                  left: 0,
                  right: 0,
                  child: Container(
                    height: 190,
                    margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 5.0,
                              offset: Offset(1.0, -10))
                        ]),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height: 60,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green[50],
                                ),
                                child: Image.asset(
                                  "assets/images/1.png",
                                  scale: 2.2,
                                )),
                            SizedBox(width: 10),
                            Text(
                              (translations.currentLanguage == 'ar')
                                  ? "تابع عمليه توصيل الطلب"
                                  : "Client Order Progress",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
//                            SizedBox(height: 30),
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Container(
                              height: 3,
                              color: Colors.green[100],
                              margin: EdgeInsets.only(left: 60, right: 60),
                            ),
                          ),
//                        ,Padding(padding: EdgeInsets.only(top:25),child:  Container(height: 3,color: Colors.green[300],margin: EdgeInsets.only(left: 60,right: 250),),),
                          (state == "charging")
                              ? Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Container(
                              height: 4,
                              color: Colors.green[500],
                              margin: EdgeInsets.only(left: 60, right: 190),
                            ),
                          )
                              : (state == "completed")
                              ? Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Container(
                              height: 4,
                              color: Colors.green[700],
                              margin:
                              EdgeInsets.only(left: 60, right: 60),
                            ),
                          )
                              : Container(color: Colors.black54,),
                          Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width,
                            child: Column(children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      // put on database that the order is in process
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green[50],
                                        ),
                                        child: Image.asset("assets/images/3.png",
                                            scale: 2.5)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _displayConfirm(context);
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green[50],
                                        ),
                                        child: Image.asset(
                                          "assets/images/4.png",
                                          scale: 2.5,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: (translations.currentLanguage == 'ar')
                                                  ? Text("تأكيد")
                                                  : Text("Confirmation"),
                                              content: Container(
                                                child: (translations.currentLanguage == 'ar')
                                                    ? Text("تأكيد وصول الطلب")
                                                    : Text("Sure Delevared"),
                                              ),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: (translations.currentLanguage == 'ar')
                                                      ? new Text("إلغاء")
                                                      : new Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                new FlatButton(
                                                  child: (translations.currentLanguage == 'ar')
                                                      ? new Text("تأكيد")
                                                      : new Text('Confirm'),
                                                  onPressed: () async {
                                                    orders ord;
                                                    Navigator.of(context).pop();

                                                    await _database
                                                        .reference()
                                                        .child("orders")
                                                        .child(widget.customerDetails.order.orderID)
                                                        .once()
                                                        .then((DataSnapshot snap) {
                                                      // snap.value["date"] = DateTime.parse(snap.value["date"]);
                                                      ord = orders.fromSnapshot(snap);
//                                         print("name " + ord.customerID);
                                                    });
                                                    await _database
                                                        .reference()
                                                        .child("orders")
                                                        .child(widget.customerDetails.order.orderID)
                                                        .remove()
                                                        .then((_) {});
                                                    await _database
                                                        .reference()
                                                        .child("orders")
                                                        .child(widget.customerDetails.order.orderID)
                                                        .set({
                                                      'customerID': ord.customerID,
                                                      'regionID': ord.regionID,
                                                      'deliveryManID': ord.deliveryManID,
                                                      //  'date': ord.date,
                                                      'totalPrice': ord.totalPrice,
                                                      'usedCreditCard': ord.usedCreditCard,
                                                      'state': "completed",
                                                    }).whenComplete(() {
                                                      if (mounted)
                                                        setState(() {
                                                          state = "completed";
                                                          customerDetails.order.state = state ;
                                                        });
                                                    });

                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(right: 20.0),
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green[50],
                                        ),
                                        child: Image.asset("assets/images/5.png",
                                            scale: 2.5)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 80,
                                    child: Text(
                                      (translations.currentLanguage == 'ar')
                                          ? "قيد التنفيذ"
                                          : "In progress",
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Container(
                                      width: 120,
                                      child: Text(
                                        (translations.currentLanguage == 'ar')
                                            ? "اضغط حين يتم الشحن"
                                            : "press when order is charget",
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 80,
                                    child: Text(
                                      (translations.currentLanguage == 'ar')
                                          ? "تم التوصيل"
                                          : "Delivered",
                                      softWrap: true,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          )
                        ],
                      ),
                    ]),
                  )),

        ],
          ),

        );

      }
      );
    }
    );
  }

  _displayDialog(BuildContext context) async {
    print(orderList.length.toString() + " this is from displayDialog");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Client\'s Order'),
            content: Container(
              width: double.maxFinite,
              child: ListView(
                padding: EdgeInsets.all(8.0),
                children: List.generate(
                  productOrderDetails.length,
                  (index) {
                    return Container(
                        width: 20.0,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: reviewCard(
                                product: productOrderDetails
                                    .elementAt(index)
                                    .product,
                                orderProduct: productOrderDetails
                                    .elementAt(index)
                                    .orderProduct)));
                  },
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CLOSE'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _displayConfirm(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: (translations.currentLanguage == 'ar')
                ? Text("تأكيد")
                : Text("Confirmation"),
            content: Container(
              child: (translations.currentLanguage == 'ar')
                  ? Text("تأكيد شحن الطلب")
                  : Text("Confirm Charging"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: (translations.currentLanguage == 'ar')
                    ? new Text("إلغاء")
                    : new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: (translations.currentLanguage == 'ar')
                    ? new Text("تأكيد")
                    : new Text('Confirm'),
                onPressed: () async {
                  orders ord;
                  Navigator.of(context).pop();

                  await _database
                      .reference()
                      .child("orders")
                      .child(widget.customerDetails.order.orderID)
                      .once()
                      .then((DataSnapshot snap) {
                   // snap.value["date"] = DateTime.parse(snap.value["date"]);
                    ord = orders.fromSnapshot(snap);
//                                         print("name " + ord.customerID);
                  });
                  await _database
                      .reference()
                      .child("orders")
                      .child(widget.customerDetails.order.orderID)
                      .remove()
                      .then((_) {});
                  await _database
                      .reference()
                      .child("orders")
                      .child(widget.customerDetails.order.orderID)
                      .set({
                    'customerID': ord.customerID,
                    'regionID': ord.regionID,
                    'deliveryManID': ord.deliveryManID,
                  //  'date': ord.date,
                    'totalPrice': ord.totalPrice,
                    'usedCreditCard': ord.usedCreditCard,
                    'state': "charging",
                  }).whenComplete(() {
                    if (mounted)
                      setState(() {
                        state = "charging";
                        customerDetails.order.state = state ;
                      });
                  });

                },
              )
            ],
          );
        });
  }
}
