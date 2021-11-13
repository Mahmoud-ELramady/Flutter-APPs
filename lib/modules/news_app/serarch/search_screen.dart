import 'package:first_app/layout/news_app/cubit/cubit.dart';
import 'package:first_app/layout/news_app/cubit/states.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget{

  var searchController=TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){

        var list=NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  inputType: TextInputType.text,
                  validate: (String value){
                    if(value.isEmpty){
                      return 'must not be empty';
                    }
                    return null;
                  },
                  labelText: "Search",
                  prefixIcon: Icons.search,
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                  child: articleBuilder(list, context,isSearch: true)
              ),
            ],
          ),
        );
      },

    );

  }

}