import 'dart:io';

import 'package:delivery_man/_model/orderProducts.dart';
import 'package:delivery_man/_model/product.dart';
import 'package:delivery_man/utils/size_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class reviewCard extends StatefulWidget {
  Product product;
  orderProducts orderProduct;

   reviewCard({this.product , this.orderProduct});

  @override
  _reviewCardState createState() => _reviewCardState();
}

var bodyBytes;
class _reviewCardState extends State<reviewCard> {

  Future<void> downloadFile(StorageReference ref) async {
    final String url = await ref.getDownloadURL();
    final http.Response downloadData = await http.get(url);
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/tmp.jpg');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
    final int byteCount = (await task.future).totalByteCount;
    bodyBytes = downloadData.bodyBytes;
    final String name = await ref.getName();
    final String path = await ref.getPath();
    print(
      'Success!\nDownloaded $name \nUrl: $url'
          '\npath: $path \nBytes Count :: $byteCount',
    );
    if(mounted)
    setState(() {

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final ref =  FirebaseStorage().ref().child('images/577268-82a889cb2d733321db5b0831aeb97240.jpg');
    downloadFile(ref).then((v){
       if(mounted)
        setState(() {

        });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Container(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.white,
          elevation: 3,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        right: SizeConfig.getResponsiveWidth(10.0),
                        top: SizeConfig.getResponsiveHeight(5.0),
                        bottom: SizeConfig.getResponsiveHeight(10.0)),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: new BorderRadius.all(Radius.circular(5.0))),
                    width: SizeConfig.getResponsiveWidth(90.0),
                    height: SizeConfig.getResponsiveHeight(10.0),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "${widget.product.stockQuantity.toString()}  ",
                          style: new TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.getResponsiveWidth(9.0)),
                        ),
                      ),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.getResponsiveHeight(0.0),
                        right: SizeConfig.getResponsiveWidth(8.0)),
                    child: Text(
                      "${widget.orderProduct.price.toString()} SAR",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: SizeConfig.getResponsiveWidth(9),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.getResponsiveWidth(10.0),
                            bottom: SizeConfig.getResponsiveHeight(0.0)),
                        child: Text(
                          "${widget.product.title}",
                          maxLines: 3,
                          //   overflow:TextOverflow. ,
                          style: TextStyle(
                            fontSize: SizeConfig.getResponsiveWidth(12.0),
//                        fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      InkWell(

                        child: (bodyBytes != null)?Container(
                          height: SizeConfig.getResponsiveHeight(50.0),
                          width: SizeConfig.getResponsiveWidth(70.0),
                          child: FittedBox(
                            fit: BoxFit.contain,
                         child:new Image.memory(bodyBytes)
                          ),
                        ): CircularProgressIndicator(),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.getResponsiveHeight(0.0),
                                right: SizeConfig.getResponsiveWidth(0.0)),
                            child: Text(
                              "Quantity : ${widget.orderProduct.quantity.toString()}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: SizeConfig.getResponsiveWidth(12),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),

                ],
              )
            ],
          ),
        ));
  }
}
