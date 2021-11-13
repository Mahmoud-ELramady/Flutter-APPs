import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/componenets/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSettingsScreen extends StatelessWidget {
var nameController=TextEditingController();
var emailController=TextEditingController();
var phoneController=TextEditingController();

var formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessGetProfileStates){

        }
      },
      builder: (context,state){

        var cubit=ShopCubit.get(context);
        var model=cubit.userModel;

        nameController.text=model.data.name;
        emailController.text=model.data.email;
        phoneController.text=model.data.phone;


        return ConditionalBuilder(
          condition:cubit.userModel!=null ,
          builder:(context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Expanded(
                child: Column(
                  children: [

                    if(state is ShopLoadingUpdateUserStates)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        controller: nameController,
                        inputType: TextInputType.name,
                        validate: (String value){

                          if(value.isEmpty){
                            return 'name must not be empty';

                          }

                        },
                        labelText: "name",
                        prefixIcon: Icons.person
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    defaultFormField(
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'email must not be empty';
                          }

                        },
                        labelText: "email",
                        prefixIcon: Icons.email_outlined
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    defaultFormField(
                        controller: phoneController,
                        inputType: TextInputType.phone,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'phone must not be empty';
                          }
                        },
                        labelText: "phone",
                        prefixIcon: Icons.phone_android_outlined
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    defaultButton(
                        function: (){

                          if(formKey.currentState.validate()){
                            cubit.updateUserData(
                                name: nameController.text ,
                                email: emailController.text,
                                phone: phoneController.text
                            );

                          }
                        },
                        text: "Update"
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    defaultButton(
                        function: (){
                          signOut(context);
                        },
                        text: "Logout"
                    ),


                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );
      },
    );
  }
}
