import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/shop_app/shop_layout.dart';
import 'package:first_app/modules/shop_app/login/cubit/states.dart';
import 'package:first_app/modules/shop_app/register/shop_register.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/componenets/Constants.dart';
import 'package:first_app/shared/network/local/cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cubit/cubit.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  var formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context,state){

          if(state is ShopLoginSuccessState){
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
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please enter your email';
                              }
                            },
                            labelText: "Email Address",
                            prefixIcon: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15.0,
                        ),

                        defaultFormField(
                            controller: passwordController,
                            inputType: TextInputType.visiblePassword,
                            suffixIcon:ShopLoginCubit.get(context).suffix,
                            isPassword: ShopLoginCubit.get(context).isPasswordShow,
                            onSubmit: (value){
                              if(formKey.currentState.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );

                              }
                            },
                            suffixPressed: (){
                              ShopLoginCubit.get(context).changePasswordVisibility();
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
                          condition: state is! ShopLoginLoadingState,
                          builder:(context)=>defaultButton(
                            function: (){

                              if(formKey.currentState.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );

                              }
                            },
                            text: "login",
                            isUpperCase: true,
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            defaultTextButton(
                                function: (){
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: "signup"
                            )
                          ],
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
