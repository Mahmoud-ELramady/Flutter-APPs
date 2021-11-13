import 'package:first_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:first_app/modules/shop_app/search/cubit/states.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchScreen extends StatelessWidget {


  var fromKey=GlobalKey<FormState>();

  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){

          var cubit=SearchCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key:fromKey ,

              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        inputType: TextInputType.text,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (String text){
                          cubit.search(text);
                        },
                        labelText: "Search",
                        prefixIcon: Icons.search
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),

                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index)=>buildListProduct(cubit.model.data.data[index],cubit,context,isOldPrice: false),
                          separatorBuilder:(context,index)=> MyDivider(),
                          itemCount: cubit.model.data.data.length
                      ),
                    ),


                  ]
                ),
              ),
            ),
          );

        } ,
      ),
    );
  }
}
