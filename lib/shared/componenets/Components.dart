import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/models/shop_app/favorites_model.dart';
import 'package:first_app/modules/news_app/web_view/web_view.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

 Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue,
  bool isUpperCase=true,
  @required Function function,
  @required String text,
}) => Container(
  width: width
  ,
  color: background,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase?text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);




 Widget defaultFormField({
  @required TextEditingController controller,
  @required  TextInputType inputType,
   Function onSubmit,
   Function onChanged,
   Function onTap,
   @required Function validate,
   @required String labelText,
   @required IconData prefixIcon,
   IconData suffixIcon,
   bool isPassword=false,
   Function suffixPressed,
   bool isEnable=true,


})=>TextFormField(
   controller: controller,
   keyboardType:inputType ,
   onFieldSubmitted:onSubmit,
   onChanged:onChanged,
   enabled:isEnable ,
   validator: validate,
   obscureText: isPassword,
   onTap: onTap,
   decoration: InputDecoration(
     labelText: labelText,
     border: OutlineInputBorder(),
     prefixIcon: Icon(prefixIcon),
     suffixIcon: suffixIcon!=null?IconButton(
         icon:Icon(suffixIcon),
       onPressed:suffixPressed ,
     ):null,
   ),
 );


Widget defaultTextButton({
  @required Function function,
  @required String text
})=>TextButton(onPressed: function, child: Text(text.toUpperCase()));




 Widget buildTaskItem(Map model,context) =>Dismissible(
   key: Key(model['id'].toString()),
   child: Padding(
     padding: const EdgeInsets.all(20.0),
     child: Row(
       children: [
         CircleAvatar(
           radius: 40.0,
           child: Text(
               "${model['time']}"
           ),
         ),
         SizedBox(
           width: 20.0,
         ),
         Expanded(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 "${model['title']}",
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 18.0,
                 ),
               ),
               Text(
                 "${model['date']}",
                 style: TextStyle(
                   color: Colors.grey,
                 ),
               ),
             ],
           ),
         ),
         SizedBox(
           width: 20.0,
         ),
         IconButton(
             icon: Icon(
                 Icons.check_box,
               color: Colors.green,
             ),
             onPressed:(){
               AppCubit.get(context).updateDatabase(status: "done", id: model['id'],);
             }
         ),
         IconButton(
             icon: Icon(
                 Icons.archive,
               color: Colors.black45,
             ),
             onPressed:(){
               AppCubit.get(context).updateDatabase(status: "archived", id: model['id'],);
             }
         ),

       ],
     ),
   ),
   onDismissed: (direction){
     AppCubit.get(context).deletsDatabase(id:  model['id']);
   },
 );



 Widget tasksBuilder({
  @required List<Map> tasks
})=>ConditionalBuilder(
   condition: tasks.length>0,
   builder: (context)=> ListView.separated(
       itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
       separatorBuilder: (context,index)=>MyDivider(),
       itemCount: tasks.length
   ),
   fallback: (context)=> Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Icon(
           Icons.menu,
           size: 100.0,
           color: Colors.grey,
         ),
         Text("No Tasks Yet, Please Add Some Tasks",
           style: TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.bold,
             color: Colors.grey,
           ),
         )
       ],
     ),
   ),
 );


 Widget MyDivider()=>Padding(
   padding: const EdgeInsetsDirectional.only(
       start: 20.0
   ),
   child: Container(
     width: double.infinity,
     height: 1.0,
     color: Colors.grey[300],
   ),
 );

 Widget buildNewItem({
  @required list,
   context
 })=>InkWell(
   onTap: (){
     navigateTo(context, WebViewScreen(list['url']),);
   },
   child: Padding(
     padding: const EdgeInsets.all(20.0),
     child: Row(
       children: [
         Container(
           width: 120.0,
           height: 120.0,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.0),
               image: DecorationImage(
                   image: NetworkImage('${list['urlToImage']}'),
                   fit: BoxFit.cover
               )
           ),
         ),
         SizedBox(width: 20.0,),
         Expanded(
           child: Container(
             height: 120,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
               children: [
                 Expanded(
                   child: Text(
                     '${list['title']}',
                     style: Theme.of(context).textTheme.bodyText1,
                     maxLines: 3,
                     overflow: TextOverflow.ellipsis,
                   ),
                 ),
                 Text(
                   '${list['publishedAt']}',
                   style: TextStyle(
                     color: Colors.grey,
                   ),
                 ),
               ],
             ),
           ),
         ),
       ],
     ),
   ),
 );



 Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
   condition: list.length>0,
   builder: (context)=>ListView.separated(
       physics: BouncingScrollPhysics(),
       itemBuilder: (context,index)=>buildNewItem(list:list[index],context: context),
       separatorBuilder: (context,index)=>MyDivider(),
       itemCount: list.length
   ),
   fallback:(context)=> isSearch?Container(): Center(child: CircularProgressIndicator()),
 );


 void navigateTo(context,widget)=>Navigator.push(
     context,
     MaterialPageRoute(
       builder: (context)=>widget,
     )
 );


 void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
     context,
     MaterialPageRoute(
       builder: (context)=>widget,
     ),
     (Route<dynamic> route)=>false,
 );


 void ShowToast({
  @required String text,
  @required ToastStates states,
}){
   Fluttertoast.showToast(
       msg: text,
       toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 5,
       backgroundColor: changeToastColor(states),
       textColor: Colors.white,
       fontSize: 16.0
   );
 }


 enum ToastStates{SUCCESS,WARNING,ERROR}

 Color changeToastColor(ToastStates states){
   switch(states){
     case ToastStates.SUCCESS:
       return Colors.green;
       break;
     case ToastStates.ERROR:
       return Colors.red;
       break;
     case ToastStates.WARNING:
       return Colors.amber;
       break;

   }
 }


Widget buildListProduct(model, cubit,context,{bool isOldPrice=true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage("${model.image}"),
              width: 120,
              height: 120,
            ),

            if(model.discount!=0&&isOldPrice)
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
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "${model.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize:14.0 ,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    "${model.price}",
                    style: TextStyle(
                        fontSize:12.0 ,
                        color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount!=0&&isOldPrice)

                    Text(
                      "${model.oldPrice}",
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
                      backgroundColor:ShopCubit.get(context).favourites[model.id]?defaultColor: Colors.grey,
                      child: Icon(
                        Icons.favorite_outline,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ) ,
                    onPressed: (){
                      ShopCubit.get(context).changeFavourites(model.id);
                    },
                  )

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
