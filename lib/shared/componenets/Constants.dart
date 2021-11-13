// GET https://newsapi.org/
// v2/top-headlines?
// country=us&apiKey=1ab1a6897b924a15a68a93ec7cfeb316

// https://newsapi.org/v2/everything?q=tesla&apiKey=1ab1a6897b924a15a68a93ec7cfeb316

import 'package:first_app/modules/shop_app/login/shop_login.dart';
import 'package:first_app/shared/network/local/cash_helper.dart';

import 'Components.dart';

void signOut(context){
  CacheHelper.clearData("token").then((value){
    if(value)  navigateAndFinish(context, ShopLoginScreen());
  });
}

String token='';
