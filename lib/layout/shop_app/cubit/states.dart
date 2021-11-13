import 'package:first_app/models/shop_app/change_favorites_model.dart';
import 'package:first_app/models/shop_app/login_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}
class ShopChangeBottomNavStates extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}
class ShopSuccessHomeDataStates extends ShopStates{}
class ShopErrorHomeDataStates extends ShopStates{}

class ShopSuccessCategoriesStates extends ShopStates{}
class ShopErrorCategoriesStates extends ShopStates{}


class ShopSuccessChangeStates extends ShopStates{}
class ShopSuccessFavoritesStates extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessFavoritesStates(this.model);
}
class ShopErrorFavoritesStates extends ShopStates{}


class ShopLoadingGetFavoritesStates extends ShopStates{}
class ShopSuccessGetFavoritesStates extends ShopStates{}
class ShopErrorGetFavoritesStates extends ShopStates{}

class ShopLoadingGetProfileStates extends ShopStates{}
class ShopSuccessGetProfileStates extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessGetProfileStates(this.loginModel);
}
class ShopErrorGetProfileStates extends ShopStates{}


class ShopLoadingUpdateUserStates extends ShopStates{}
class ShopSuccessUpdateUserStates extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserStates(this.loginModel);
}
class ShopErrorUpdateUserStates extends ShopStates{}
