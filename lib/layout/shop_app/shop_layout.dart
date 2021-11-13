import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/modules/shop_app/login/shop_login.dart';
import 'package:first_app/modules/shop_app/search/search_screen.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/componenets/Constants.dart';
import 'package:first_app/shared/network/local/cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){

        },
        builder: (context,state){

          var cubit=ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "Salla"
              ),
              actions: [
                IconButton(
                    icon:
                    Icon(
                        Icons.search
                    )
                    , onPressed: (){
                  navigateTo(context, ShopSearchScreen());
                }),
              ],
            ),

            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottom(index);
              },
                currentIndex: cubit.currentIndex,
                items:[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                    label: "Home"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps),
                    label: "Categories"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_outlined),
                    label: "Favourites"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                    label: "Settings"
                  ),

                ]
            ),
          );
        },
    );
  }
}
