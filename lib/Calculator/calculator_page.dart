// calculator_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculator_functions.dart';
import 'calculator_view.dart';

class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: BlocProvider(
        create: (_) => CalculatorBloc(),
        child: CalculatorView(),
      ),
    );
  }
}
