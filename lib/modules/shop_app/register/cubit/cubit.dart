import 'package:bloc/bloc.dart';
import 'package:first_app/models/shop_app/login_model.dart';
import 'package:first_app/modules/shop_app/login/cubit/states.dart';
import 'package:first_app/modules/shop_app/register/cubit/states.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister({
  @required String name,
  @required String email,
  @required String phone,
  @required String password,
}){

    emit(ShopRegisterLoadingState());

    DioHelper.postDataShop(
        url: REGISTER,
        data: {
          "name":name,
          "email":email,
          "phone":phone,
          "password":password,
        },
    ).then((value)  {
      // print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());

      emit(ShopRegisterErrorState(error.toString()));
    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPasswordShow=true;

  void changePasswordVisibility(){
    isPasswordShow=!isPasswordShow;

    suffix= isPasswordShow ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordVisibilityState());
  }

}