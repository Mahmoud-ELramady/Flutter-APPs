import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/models/shop_app/categories_model.dart';
import 'package:first_app/models/shop_app/home_model.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessFavoritesStates){
          if(!state.model.status){
            ShowToast(text: state.model.message, states: ToastStates.ERROR);
          }else{
            ShowToast(text: state.model.message, states: ToastStates.SUCCESS);
          }
        }
      },

      builder: (context,state){

        var cubit=ShopCubit.get(context);

        return ConditionalBuilder(
            condition: cubit.homeModel!=null && cubit.categoriesModel!=null ,
            builder: (context)=>productsBuilder(cubit.homeModel,cubit.categoriesModel,cubit),
          fallback:(context)=> Center(child: CircularProgressIndicator()),
        );
      },
    ) ;
  }


  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,ShopCubit cubit) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data.banners.map((e) =>
          Image(
              image: NetworkImage(
                "${e.image}",
              ),
            width: double.infinity,
            fit: BoxFit.cover,
          ) ,).toList(),

          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1.0,
          ),

        ),
        SizedBox(
          height: 10.0,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>buildCategoriesItem(categoriesModel.data.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoriesModel.data.data.length
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              Text(
                "New Products",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 10.0,
        ),


        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1/1.72,
            children: List.generate(
                model.data.products.length,
                    (index) => buildGridProduct(model.data.products[index],cubit)
            ),
          ),
        ),
      ],
    ),
  );


  Widget buildGridProduct(ProductsModel model,ShopCubit cubit)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,
            ),

            if(model.discount!=0)
             Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(
                  horizontal: 5,
                vertical: 5,
              ),
              child: Text(
                "DISCOUNT",
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize:14.0 ,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    model.price.round().toString(),
                    style: TextStyle(
                      fontSize:12.0 ,
                      color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount!=0)

                   Text(
                    model.oldPrice.round().toString(),
                    style: TextStyle(
                        fontSize:10.0 ,
                        color: Colors.grey,
                      decoration: TextDecoration.lineThrough
                    ),
                  ),

                  Spacer(),
                  IconButton(
                      icon:CircleAvatar(
                        radius: 15.5,
                        backgroundColor:cubit.favourites[model.id]?defaultColor: Colors.grey,
                        child: Icon(
                            Icons.favorite_outline,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ) ,
                      onPressed: (){
                        cubit.changeFavourites(model.id);
                      },
                      )

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );


  Widget buildCategoriesItem(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image:NetworkImage("${model.image}"),
        width: 100.0,
        height: 100.0,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "${model.name}",
            style: TextStyle(
                color: Colors.white
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],

  );


}
