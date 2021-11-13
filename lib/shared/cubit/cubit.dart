import 'package:bloc/bloc.dart';
import 'package:first_app/modules/todo_app_tasks/archived_tasks/archivedTasksScreen.dart';
import 'package:first_app/modules/todo_app_tasks/done_tasks/doneTasksScreen.dart';
import 'package:first_app/modules/todo_app_tasks/new_tasks/newTasksScreen.dart';

import 'package:first_app/shared/cubit/states.dart';
import 'package:first_app/shared/network/local/cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);


  int currentIndex=0;

  List<Widget> screen=[
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles=[
    "New Tasks",
    "Done Tasks",
    "Archived Tasks"
  ];
  List<Map> newList=[];
  List<Map> doneList=[];
  List<Map> archivedList=[];


  Database database;
  void CreateDatabase() {
     openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database,version){
        print("DataBase Created");
        database.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT, date TEXT, time TEXT, status TEXT)")
            .then((value){
          print("Table Created");
        }).catchError((error){
          print(error);
        });
      },
      onOpen: (database){
        getDataFromDataBase(database);

          print("DataBase Opened");

      },
    ).then((value){
      database=value;
      emit(AppCreateDatabaseState());
    });
  }

   insertToDataBase({
    @required String title,
    @required String date,
    @required String time
  }) async {
     await database.transaction((txn)
    {

      txn.rawInsert("INSERT INTO tasks(title,date,time,status) VALUES('$title','$date','$time','new')")
          .then((value) {

        print("$value Inserted Successfully");
        emit(AppInsertDatabaseState());

        getDataFromDataBase(database);

      }).catchError((error)
      {

        print(error.toString());

      });
      return null;
    });
  }


  void getDataFromDataBase(database) {

    newList=[];
    doneList=[];
    archivedList=[];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value){

      value.forEach((element)
      {
        if(element['status']=='new'){
          newList.add(element);
        }else if(element['status']=='done'){
          doneList.add(element);
        }else if(element['status']=='archived'){
          archivedList.add(element);
        }

      });

print(newList);
      emit(AppGetDatabaseState());

    });
  }


  void updateDatabase({
  @required String status,
  @required int id
}) {
     database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value){
          getDataFromDataBase(database);
          emit(AppUpdataDatabaseState());
     });
    // print('updated: $count');
  }

  void deletsDatabase({
    @required int id,
  }) {
    database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getDataFromDataBase(database);
      emit(AppDeleteDatabaseState());
    });
    // print('updated: $count');
  }


  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }


  bool isBottomSheet=false;
  IconData fabIcon=Icons.edit;


  changeBottomSheetState({
    @required IconData icon,
    @required bool isShow
}){

    isBottomSheet=isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheetState());
  }



  bool isDark=false;

  void changeAppMode({bool fromShared}){
    if(fromShared!=null){
      isDark=fromShared;
      emit(AppChangeModeState());
    }else{
      isDark= !isDark;
      CacheHelper.putBoolean(key: "isDark", value: isDark).then((value) =>{
        emit(AppChangeModeState())
      });

    }




  }


}

