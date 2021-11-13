import 'package:bloc/bloc.dart';
import 'package:first_app/BmiResultScreen.dart';
import 'package:first_app/BmiScreen.dart';
import 'package:first_app/HomePage.dart';
import 'package:first_app/LoginScreen.dart';
import 'package:first_app/MassengerScreen.dart';
import 'package:first_app/UserScreen.dart';
import 'package:first_app/layout/news_app/cubit/cubit.dart';
import 'package:first_app/layout/news_app/cubit/states.dart';
import 'package:first_app/layout/shop_app/shop_layout.dart';
import 'package:first_app/layout/todo_app/HomeLayout.dart';
import 'package:first_app/modules/counter/CounterScreen.dart';
import 'package:first_app/shared/bloc_observer.dart';
import 'package:first_app/shared/componenets/Constants.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:first_app/shared/network/local/cash_helper.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:first_app/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/news_app/news_layout.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'modules/shop_app/login/shop_login.dart';
import 'modules/shop_app/on_boarding.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.initShop();
  await CacheHelper.init();

  Widget widget;

  bool isDark=CacheHelper.getData(key: "isDark");
  print("mode Now "+isDark.toString());

  bool onBoarding=CacheHelper.getData(key: "onBoarding");
  token=CacheHelper.getData(key: "token");

  print(token.toString());

  if(onBoarding!=null){
    if(token!=null) widget=ShopLayout();
    else widget=ShopLoginScreen();
  }else{
    widget=OnBoarding();
  }


  runApp(MyApp(isDark,widget));
}

class MyApp extends StatelessWidget {

  bool isDark;
  Widget widget;
  MyApp(this.isDark,this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()),
        BlocProvider(create:  (context)=>AppCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(create:  (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getProfileData()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:AppCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light ,
            home: widget,

          );
        },
      ),
    );
  }

}
