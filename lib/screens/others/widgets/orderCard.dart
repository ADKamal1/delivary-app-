import 'package:delivery_man/_model/Product_Offer.dart';
import 'package:delivery_man/_model/customerOrderDetails.dart';
import 'package:delivery_man/model/ord.dart';
import 'package:delivery_man/screens/others/detailedOrderScreen.dart';
import 'package:delivery_man/translation/global_translation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class Ordercard extends StatefulWidget {

  List<Product_Offer> productsForOffer = <Product_Offer>[];
  customerOrderDetails customerDetails;
  Ordercard({this.customerDetails , this.productsForOffer});

  @override
  _OrdercardState createState() => _OrdercardState();
}

class _OrdercardState extends State<Ordercard> {

  @override
  Widget build(BuildContext context) {
 //   DateTime clientOrderTime = widget.customerDetails.order.date;
    //String clientOrderTime = widget.customerDetails.order.date;
   // DateTime delivaryAt = clientOrderTime.add(Duration(days: 3));
   // String orderDateTime =clientOrderTime.day.toString()+ "-" + clientOrderTime.month.toString() + "-" + clientOrderTime.year.toString();
   // String deliveryDate =  delivaryAt.day.toString()+ "-" + delivaryAt.month.toString() + "-" + delivaryAt.year.toString();

    return InkWell(
        onTap: (){Navigator.push(context, new MaterialPageRoute(builder: (context) => new DetailedOrderScreen(customerDetails:widget.customerDetails)));},
        child:Container(
        margin: EdgeInsets.all(SizeConfig.getResponsiveWidth(5)),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.white,
          elevation: 3,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.getResponsiveHeight(10.0),
                      bottom: SizeConfig.getResponsiveHeight(5.0),
                      left: SizeConfig.getResponsiveWidth(20.0),
                      right: SizeConfig.getResponsiveWidth(20.0),
                    ),
                    child: Text(
                      translations.text("AllOrderPage.client"),
                      style: new TextStyle(
                          color: Color(0XFF21d493),
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.getResponsiveWidth(20.0)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.getResponsiveHeight(15.0),
                        left: SizeConfig.getResponsiveWidth(15.0),
                        right: SizeConfig.getResponsiveWidth(15.0)),
                    decoration:(widget.customerDetails.order.state == "completed")? BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius:
                        new BorderRadius.all(Radius.circular(3.0))):
                    BoxDecoration(
                        color: Colors.red[100],
                        borderRadius:
                            new BorderRadius.all(Radius.circular(3.0))),
                    width: SizeConfig.getResponsiveWidth(90.0),
                    height: SizeConfig.getResponsiveHeight(20.0),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: (widget.customerDetails.order.state =="completed")
                              ? Text(
                            (translations.currentLanguage == 'ar')?"completed":"منتهى",
                                  style: new TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConfig.getResponsiveWidth(25.0)),
                                )
                              :  Text(
                            (translations.currentLanguage == 'ar')?"لم ينتهى بعد":"waiting",
                                      style: new TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              SizeConfig.getResponsiveWidth(
                                                  25.0)),
                                    ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile1.jpg"),
                      radius: SizeConfig.getResponsiveHeight(30),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(SizeConfig.getResponsiveWidth(5)),
                    child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        " ${widget.customerDetails.customer.name.toString()}",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.getResponsiveWidth(20),
                        ),
                      ),
                      Text(
                        (translations.currentLanguage == 'ar')?" ${widget.customerDetails.region.arabicTitle.toString()}":" ${widget.customerDetails.region.title.toString()}",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.getResponsiveWidth(15),
                        ),
                      ),
                    ],
                  ),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.getResponsiveWidth(12.0),
            right: SizeConfig.getResponsiveWidth(12.0)

        ),
                    alignment: Alignment.centerLeft,
                    child: (translations.currentLanguage == 'ar')?Text(
                      " ${widget.customerDetails.order.totalPrice.toString()} ر.س " ,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.getResponsiveWidth(15),
                      ),
                    ) : Text(
                      " ${widget.customerDetails.order.totalPrice.toString()} SAR" ,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.getResponsiveWidth(15),
                      ),
                    ),
                  ),
                 Container(
                   margin: EdgeInsets.only(right:15 ,bottom: 10 , left: 15 , ),
                   child:(translations.currentLanguage == 'ar')? Column(
                    children: <Widget>[
                      Text(
                        "ستصلك ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.getResponsiveWidth(15),
                        ),
                      ),
                      Text(
                       "من" +"11",
                           //orderDateTime,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.getResponsiveWidth(15),
                        ),
                      ),
                      Text(
                       "إلى " + "14",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.getResponsiveWidth(15),
                        ),
                      ),
                    ],
                  ):Column(
                     children: <Widget>[
                       Text(
                         "Delivered ",
                         textAlign: TextAlign.left,
                         style: TextStyle(
                           color: Colors.black45,
                           fontWeight: FontWeight.bold,
                           fontSize: SizeConfig.getResponsiveWidth(15),
                         ),
                       ),
                       Text(
                         "from " + "11",
                         textAlign: TextAlign.left,
                         style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                           fontSize: SizeConfig.getResponsiveWidth(15),
                         ),
                       ),
                       Text(
                         "to " + "15",
                         textAlign: TextAlign.left,
                         style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                           fontSize: SizeConfig.getResponsiveWidth(15),
                         ),
                       ),
                     ],
                   ),)
                ],
              )
            ],
          ),
        )));
  }
}
