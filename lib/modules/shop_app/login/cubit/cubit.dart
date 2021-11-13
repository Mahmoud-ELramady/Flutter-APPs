
import 'package:bloc/bloc.dart';
import 'package:first_app/models/shop_app/login_model.dart';
import 'package:first_app/modules/shop_app/login/cubit/states.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userLogin({
  @required String email,
  @required String password,
}){

    emit(ShopLoginLoadingState());

    DioHelper.postDataShop(
        url: LOGIN,
        data: {
          "email":email,
          "password":password,
        },
    ).then((value)  {
      // print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());

      emit(ShopLoginErrorState(error.toString()));
    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPasswordShow=true;

  void changePasswordVisibility(){
    isPasswordShow=!isPasswordShow;

    suffix= isPasswordShow ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }

}