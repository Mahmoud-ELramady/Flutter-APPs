import 'package:conditional_builder/conditional_builder.dart';

import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget
{


  var keyScaffold=GlobalKey<ScaffoldState>();
  var keyForm=GlobalKey<FormState>();


  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();



  // @override
  // void initState() {
  //   super.initState();
  //   CreateDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){

          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
            titleController.text="";
            timeController.text="";
            dateController.text="";
          }

        } ,
        builder: (context,state){

          AppCubit cubit=AppCubit.get(context);

          return Scaffold(
            key: keyScaffold,
            appBar: AppBar(
              title: Text(
            cubit.titles[cubit.currentIndex]
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder:(context)=>cubit.screen[cubit.currentIndex],
              fallback:(context)=> Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(cubit.isBottomSheet){
                  if(keyForm.currentState.validate()){
                  cubit.insertToDataBase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text
                  );
                  }


                }else{
                  keyScaffold.currentState.showBottomSheet(
                        (context) =>Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: keyForm,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                                controller: titleController,
                                inputType: TextInputType.text,
                                validate: (String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return "title must not be empty";
                                  }
                                  return null;
                                },
                                labelText: "Task Title",
                                prefixIcon: Icons.title
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              controller: timeController,
                              inputType: TextInputType.datetime,
                              onTap: (){
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now()
                                ).then((value){
                                  timeController.text=value.format(context).toString();
                                });
                              },
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return "time must not be empty";
                                }
                                return null;
                              },
                              labelText: "Task Time",
                              prefixIcon: Icons.watch_later_outlined,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              controller: dateController,
                              inputType: TextInputType.datetime,
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate:DateTime.now() ,
                                  lastDate: DateTime.parse("2022-05-03"),

                                ).then((value) {
                                  print(DateFormat.yMMMd().format(value));
                                  dateController.text=DateFormat.yMMMd().format(value);
                                });
                              },
                              validate: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return "data must not be empty";
                                }
                                return null;
                              },
                              labelText: "Task Date",
                              prefixIcon: Icons.calendar_today_outlined,
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  ).closed.then((value){
                    cubit.changeBottomSheetState(icon: Icons.edit, isShow: false);
                    titleController.text="";
                    timeController.text="";
                    dateController.text="";
                  });
                cubit.changeBottomSheetState(icon: Icons.add, isShow: true);
                }
              },
              child: Icon(
                  cubit.fabIcon
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 15,
              currentIndex:cubit.currentIndex,
              onTap:(index){
                cubit.changeIndex(index);
                print(index);
              } ,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived'
                ),
              ],
            ),
          );
        },

      ),
    );
  }

  Future<String> getString() async{
    return "Amr Ahmed";
  }




}


