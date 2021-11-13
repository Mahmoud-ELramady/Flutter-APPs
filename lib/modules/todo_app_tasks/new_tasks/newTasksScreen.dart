import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/componenets/Constants.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){

        var tasks=AppCubit.get(context).newList;

        return tasksBuilder(tasks: tasks);
      },

    );
    //
  }
}
