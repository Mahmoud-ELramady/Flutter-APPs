import 'package:first_app/modules/counter/cubit/cubit.dart';
import 'package:first_app/modules/counter/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  int counter=1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener:(context,state){
          // if(state is CounterInitialState) print("Initial State");
          // if(state is CounterPlusState) print("${state.counter} Plus State");
          // if(state is CounterMinusState) print("${state.counter} Minus State");
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "Counter"
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).munis();
                    },
                    child: Text(
                        "MINUS"
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      "${CounterCubit.get(context).counter}",
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).plus();
                    },
                    child: Text(
                        "PLUS"
                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
