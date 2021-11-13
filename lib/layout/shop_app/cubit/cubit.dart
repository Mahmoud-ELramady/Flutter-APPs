import 'package:bloc/bloc.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/models/shop_app/categories_model.dart';
import 'package:first_app/models/shop_app/change_favorites_model.dart';
import 'package:first_app/models/shop_app/favorites_model.dart';
import 'package:first_app/models/shop_app/home_model.dart';
import 'package:first_app/models/shop_app/login_model.dart';
import 'package:first_app/modules/shop_app/categories/categories_screen.dart';
import 'package:first_app/modules/shop_app/favourites/favourites_screen.dart';
import 'package:first_app/modules/shop_app/products/products_screen.dart';
import 'package:first_app/modules/shop_app/settings/settings_screen.dart';
import 'package:first_app/shared/componenets/Constants.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> bottomScreens=[
    ShopProductScreen(),
    ShopCategoriesScreen(),
    ShopFavouritesScreen(),
    ShopSettingsScreen(),
  ];

  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavStates());
  }

 HomeModel homeModel;
  Map<int,bool> favourites={};
  void getHomeData(){
    emit(ShopLoadingHomeDataStates());
    DioHelper.getDataShop(
        url: HOME,
      token:token
    ).then((value) {

      homeModel=HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favourites.addAll({
          element.id : element.inFavorites,
        });
      });

      print(homeModel.status.toString());
      print(favourites.toString());
      emit(ShopSuccessHomeDataStates());
      print( "Success");
    }).catchError((error){
      print( "Here Error: "+error.toString());

      emit(ShopErrorHomeDataStates());

    });

  }


  ChangeFavoritesModel changeFavoritesModel;
  void changeFavourites(int productId){

    favourites[productId]=!favourites[productId];
    emit(ShopSuccessChangeStates());


    DioHelper.postDataShop(
        url: FAVORITES,
        data: {
          'product_id':productId,
        },
      token: token
    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel.status){
        favourites[productId]=!favourites[productId];
      }else{
        getFavoritesData();
      }

      emit(ShopSuccessFavoritesStates(changeFavoritesModel));


    }).catchError((onError){
      favourites[productId]=!favourites[productId];
      emit(ShopErrorFavoritesStates());

    });
  }


  CategoriesModel categoriesModel;

  void getCategoriesData(){
    DioHelper.getDataShop(
        url: GET_CATEGORIES,
      token:token,
    ).then((value) {

      categoriesModel=CategoriesModel.fromJson(value.data);

      print(categoriesModel.status.toString());

      emit(ShopSuccessCategoriesStates());
      print( "Success");

    }).catchError((error){
      print( "Here Error: "+error.toString());

      emit(ShopErrorCategoriesStates());

    });

  }



  FavoritesModel favoritesModel;

  void getFavoritesData(){

    emit(ShopLoadingGetFavoritesStates());

    DioHelper.getDataShop(
      url: FAVORITES,
      token:token,
    ).then((value) {

      favoritesModel=FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesStates());
      print( "SuccessFav");

    }).catchError((error){
      print( "ErrorFav: "+error.toString());

      emit(ShopErrorGetFavoritesStates());

    });

  }




  ShopLoginModel userModel;

  void getProfileData(){

    emit(ShopLoadingGetFavoritesStates());

    DioHelper.getDataShop(
      url: PROFILE,
      token:token,
    ).then((value) {

      userModel=ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessGetProfileStates(userModel));
      print( "SuccessProf");

    }).catchError((error){
      print( "ErrorProf: "+error.toString());

      emit(ShopErrorGetProfileStates());

    });

  }



  void updateUserData({
  @required String name,
  @required String email,
  @required String phone,
}){

    emit(ShopLoadingUpdateUserStates());

    DioHelper.putDataShop(
      url: UPDATE,
      token:token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {

      userModel=ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserStates(userModel));
      print( "SuccessProf");

    }).catchError((error){
      print( "ErrorProf: "+error.toString());

      emit(ShopErrorUpdateUserStates());

    });

  }



}