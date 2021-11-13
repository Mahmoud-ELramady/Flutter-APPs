
import 'package:bloc/bloc.dart';
import 'package:first_app/layout/news_app/cubit/states.dart';
import 'package:first_app/modules/news_app/business/business_screen.dart';
import 'package:first_app/modules/news_app/science/science_screen.dart';
import 'package:first_app/modules/news_app/sports/sports_screen.dart';

import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem> items= [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business_center
        ),
      label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.sports_baseball
        ),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.science
        ),
        label: 'Science'
    ),

  ];

List<Widget> screens=[
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),

];

  void changeBottomNavBar(int index){
    currentIndex=index;
    if(index==1){
      getSports();
    }

    if(index==2){
      getScience();
    }
    emit(NewsBottomNavState());
  }


  List<dynamic> business=[];

  void getBusiness(){
    emit(NewsBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country":"eg",
        "category":"business",
        "apiKey":"1ab1a6897b924a15a68a93ec7cfeb316",
      },
    ).then((value) {
      business=value.data["articles"];
      print(business.length.toString());
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print("errorA7a: "+error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }






  List<dynamic> sports=[];

  void getSports(){
    emit(NewsSportsLoadingState());

    if(sports.length==0)
    {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country":"eg",
          "category":"sports",
          "apiKey":"1ab1a6897b924a15a68a93ec7cfeb316",
        },
      ).then((value) {
        sports=value.data["articles"];
        print(business.length.toString());
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print("errorA7a: "+error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }


  }



  List<dynamic> science=[];

  void getScience(){
    emit(NewsScienceLoadingState());

    if(science.length==0){
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country":"eg",
          "category":"science",
          "apiKey":"1ab1a6897b924a15a68a93ec7cfeb316",
        },
      ).then((value) {
        science=value.data["articles"];
        print(business.length.toString());
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print("errorA7a: "+error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }


  }





  List<dynamic> search=[];

  void getSearch(String value){
    emit(NewsSearchLoadingState());


    search=[];

    DioHelper.getData(
      url: "v2/everything",
      query: {
        "q":value,
        "apiKey":"1ab1a6897b924a15a68a93ec7cfeb316",
      },
    ).then((value) {
      search=value.data["articles"];
      print(search.length.toString());
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print("errorSearch: "+error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });


  }




}