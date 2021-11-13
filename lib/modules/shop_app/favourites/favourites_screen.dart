import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/models/shop_app/favorites_model.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopFavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(

      listener:(context,state){

      } ,
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesStates,
          builder:(context,)=> ListView.separated(
              itemBuilder: (context,index)=>buildListProduct(cubit.favoritesModel.data.data[index].product,cubit,context),
              separatorBuilder:(context,index)=> MyDivider(),
              itemCount: cubit.favoritesModel.data.data.length
          ),
          fallback: (context,)=>Center(child: CircularProgressIndicator()),
        );
      },

    );

  }





}
