/*

COUNTER VIEW: responsible for UI

- use BlocBuilder 

para ito sa mga UI, dito minamanage ang mga UI

*/


import 'package:bloc_sample/Counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          return Center(
            child: Text(
              state.toString(),
              style: const TextStyle(
                fontSize: 50
              ),
            ),
          );
        }
      ),

      // Buttons
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // increment button
          FloatingActionButton(
            onPressed: ()
            // Accessing the CounterCubit and select the functions
              => context.read<CounterCubit>().increment()
            ,
            child: const Icon(Icons.add),
          ),

          const SizedBox(height: 10,),

          // decrement button
          FloatingActionButton(
            onPressed: ()
            // Accessing the CounterCubit and select the functions
              => context.read<CounterCubit>().decrement()
            ,
            child: const Icon(Icons.remove),
          )
        ],
      ),

    );
  }
}
