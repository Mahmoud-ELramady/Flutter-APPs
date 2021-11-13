import 'package:first_app/layout/news_app/cubit/states.dart';
import 'package:first_app/modules/news_app/serarch/search_screen.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                "News App"
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed:(){
                    navigateTo(context, SearchScreen());
                  }
              ),
              IconButton(
                  icon: Icon(
                      Icons.brightness_4_outlined
                  ),
                  onPressed:(){
                    AppCubit.get(context).changeAppMode();
                  }
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.items
          ),
        );

      },

    );
  }
}
