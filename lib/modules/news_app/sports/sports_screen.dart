import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/news_app/cubit/cubit.dart';
import 'package:first_app/layout/news_app/cubit/states.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){

        var list=NewsCubit.get(context).sports;

        return articleBuilder(list,context);
      },
    );
  }
}
