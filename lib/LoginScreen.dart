import 'package:first_app/shared/componenets/Components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  bool isPassword=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key:formKey ,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  Text("Login",style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 40,),
                  defaultFormField(
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      validate: (String value){
                        if(value.isEmpty){
                          return "email is empty";
                        }
                        return null;
                      },
                      labelText: "Email",
                      prefixIcon: Icons.email
                  ),
                  SizedBox(height: 15,),
                  defaultFormField(
                      controller: passwordController,
                      inputType: TextInputType.visiblePassword,
                      validate: (String value){
                        if(value.isEmpty){
                          return "password is empty";
                        }
                        return null;
                      },
                      labelText: "password",
                      prefixIcon: Icons.lock,
                    isPassword: isPassword,
                    suffixIcon: isPassword? Icons.visibility:Icons.visibility_off,
                    suffixPressed: (){
                        setState(() {
                          isPassword=!isPassword;
                        });
                    },
                  )
                  ,
                  SizedBox(height: 20,),
                  defaultButton(
                      function: (){
                     if(formKey.currentState.validate()) {
                       print(emailController.text);
                       print(passwordController.text);
                     }
                      },
                      text: "login",

                  ),
                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don\'t have an account?"),
                      TextButton(
                          onPressed: (){

                          },
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                      )

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

