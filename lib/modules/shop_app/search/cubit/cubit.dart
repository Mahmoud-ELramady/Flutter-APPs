
import 'package:bloc/bloc.dart';
import 'package:first_app/models/shop_app/search_model.dart';
import 'package:first_app/modules/shop_app/search/cubit/states.dart';
import 'package:first_app/shared/componenets/Constants.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(): super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);


  SearchModel model;
  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postDataShop(
        url: SEARCH,
        token: token,
        data: {
          'text':text
        }
    ).then((value){
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());

    });
  }




}