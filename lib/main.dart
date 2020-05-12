import 'package:delivery_man/_model/customers.dart';
import 'package:delivery_man/_model/orders.dart';
import 'package:delivery_man/screens/others/LoginScreen.dart';
import 'package:delivery_man/screens/others/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './translation/bloc/translation_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '_model/customerOrderDetails.dart';
import '_model/regions.dart';
import 'translation/global_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// Initialization of the translations based on supported language
  /// and the  fallback language (Optional)
  List<String> supportedLanguages = ["en", "ar"];
  await translations.init(supportedLanguages, fallbackLanguage: 'ar');

  return runApp(BlocProvider(
    create: (context) => TranslationBloc(),
    child: MyApp(),
  ));
}
const bool debugEnableDeviceSimulator = true;

class MyApp extends StatelessWidget {
//  customers c = new customers("name", "gender", "email", "phone", "regionId",
//  true);
//
//orders ss = new orders(regionID: "regionId2",
//    deliveryManID: "fanDccgAuBQC3gehIkUWFuUt4rQ2" , totalPrice: 15.5,usedCreditCard: true,state: 0);
//
// regions rr =  regions("title", "ci", "arabicTitel", 15.055,
//  52.55, 15.5);

 List<customerOrderDetails> o= <customerOrderDetails>[];

  @override
  Widget build(BuildContext context) {
    //o.add(new customerOrderDetails(customer: c , region: rr , order: ss));
    String url;
    /// I'm using the Translation bloc here to provide the selected language whenever it changes
    /// But after that , you are free to not use Bloc pattern at all
    /// @Required
    return BlocBuilder<TranslationBloc, TranslationState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: state.locale ?? translations.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: translations.supportedLocales(),

//            Login()
            home:  yourOrder()


          );
        });
  }
}
