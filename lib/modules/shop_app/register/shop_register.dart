import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/shop_app/shop_layout.dart';
import 'package:first_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:first_app/modules/shop_app/login/cubit/states.dart';
import 'package:first_app/modules/shop_app/register/cubit/cubit.dart';
import 'package:first_app/modules/shop_app/register/cubit/states.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/componenets/Constants.dart';
import 'package:first_app/shared/network/local/cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();


  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener: (context,state){

          if(state is ShopRegisterSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.data.token);
              print(state.loginModel.message);
              CacheHelper.saveData(key: "token", value: state.loginModel.data.token).then((value){

                token=state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());

              });
              ShowToast(
                  text: state.loginModel.message.toString(),
                  states: ToastStates.SUCCESS
              );

            }else{
              ShowToast(
                  text: state.loginModel.message.toString(),
                  states: ToastStates.ERROR
              );

            }
          }


        },
        builder: (context,state){

          var cubit=ShopRegisterCubit.get(context);


          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          "Register now to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            inputType: TextInputType.name,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please enter your name';
                              }
                            },
                            labelText: "User Name",
                            prefixIcon: Icons.person
                        ),
                        SizedBox(
                          height: 15.0,
                        ),


                        defaultFormField(
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please enter your email';
                              }
                            },
                            labelText: "Email",
                            prefixIcon: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15.0,
                        ),

                        defaultFormField(
                            controller: phoneController,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please enter your phone';
                              }
                            },
                            labelText: "Phone Number",
                            prefixIcon: Icons.phone
                        ),
                        SizedBox(
                          height: 15.0,
                        ),


                        defaultFormField(
                            controller: passwordController,
                            inputType: TextInputType.visiblePassword,
                            suffixIcon:cubit.suffix,
                            isPassword: cubit.isPasswordShow,
                            onSubmit: (value){
                            },
                            suffixPressed: (){
                              cubit.changePasswordVisibility();
                            },
                            validate: (String value){
                              if(value.isEmpty){
                                return 'password is too short';
                              }
                            },
                            labelText: "Password",
                            prefixIcon: Icons.lock_outline
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder:(context)=>defaultButton(
                            function: (){

                              if(formKey.currentState.validate()){
                                cubit.userRegister(
                                  name: nameController.text,
                                    email: emailController.text,
                                    phone:phoneController.text ,
                                    password: passwordController.text
                                );

                              }
                            },
                            text: "Register",
                            isUpperCase: true,
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
