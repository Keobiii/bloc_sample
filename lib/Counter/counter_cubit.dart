/*

CUBIT: Simplified version of BLoc for easy state management

dito nilalagay yung mga functions natin

*/

import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  // constructor: get inital state
  CounterCubit(super.initialState);

  // increment function
  void increment() => emit(state + 1);

  // decrement function
  void decrement() => emit(state - 1);

}