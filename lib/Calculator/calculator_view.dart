// calculator_view.dart
import 'package:bloc_sample/Calculator/button_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculator_functions.dart';

class CalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final num1Controller = TextEditingController();
    final num2Controller = TextEditingController();

    // return Column(
    //   children: [
    //     TextField(
    //       controller: num1Controller,
    //       decoration: InputDecoration(labelText: 'Number 1'),
    //       keyboardType: TextInputType.number,
    //     ),
    //     TextField(
    //       controller: num2Controller,
    //       decoration: InputDecoration(labelText: 'Number 2'),
    //       keyboardType: TextInputType.number,
    //     ),
    //     ElevatedButton(
    //       onPressed: () {
    //         final num1 = int.parse(num1Controller.text);
    //         final num2 = int.parse(num2Controller.text);

    //         // Dispatch event to BLoC
    //         context.read<CalculatorBloc>().add(AddNumbers(num1, num2));
    //       },
    //       child: Text('Add Numbers'),
    //     ),
        
        
    //     ElevatedButton(
    //       onPressed: () {
    //         final num1 = int.parse(num1Controller.text);
    //         final num2 = int.parse(num2Controller.text);

    //         // Minus
    //         context.read<CalculatorBloc>().add(MinusNumbers(num1, num2));
    //       },
    //       child: Text('Minus Numbers'),
    //     ),

    //     ElevatedButton(
    //       onPressed: () {
    //         final num1 = int.parse(num1Controller.text);
    //         final num2 = int.parse(num2Controller.text);

    //         // Minus
    //         context.read<CalculatorBloc>().add(DivideNumbers(num1, num2));
    //       },
    //       child: Text('Divide Numbers'),
    //     ),

    //     ElevatedButton(
    //       onPressed: () {
    //         final num1 = int.parse(num1Controller.text);
    //         final num2 = int.parse(num2Controller.text);

    //         // Minus
    //         context.read<CalculatorBloc>().add(MultiplyNumbers(num1, num2));
    //       },
    //       child: Text('Multiply the fun'),
    //     ),


    //     BlocBuilder<CalculatorBloc, CalculatorState>(
    //       builder: (context, state) {
    //         if (state is CalculatorResult) {
    //           return Text('Result: ${state.result}');
    //         }
    //         return Text('Enter numbers to calculate');
    //       },
    //     ),
    //   ],
    // );

    return CalculatorScreen();
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = "";

  bool isSnackVisible = false;


  void _showSnackbar(String title, Color) {
    if (isSnackVisible) {
     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            title,
            style: TextStyle(
              color: Color,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      );

      // Optionally, reset the boolean to false after showing the Snackbar
      setState(() {
        isSnackVisible = false;
      });
    }
  }

@override
Widget build(BuildContext context) {
  // get screen size
  final screenSize = MediaQuery.of(context).size;

  return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      backgroundColor: Colors.black,
      title: Icon(Icons.menu, color: Colors.orange, size: 30),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // buttons
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                if (state is CalculatorResult) {
                  equation = state.result;
                  return Text(
                    state.result,
                    style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.end,
                  );
                }
                equation = "0";
                return const Text(
                  '0',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.end,
                );
              },
            ),
          ),
        ),

        Container(
            child: Wrap(
              runSpacing: 4.0,
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                      width: screenSize.width / 4,
                      height: 100,
                      child: buildButton(value),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    ),
  );
}

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.antiAlias,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: modifiedBtnValue(value),
          ),
        ),
      ),
    );
  }

  Color getBtnColor(value) {
    return [Btn.xop, Btn.clr, Btn.per].contains(value)
        ? const Color.fromARGB(255, 107, 107, 107)
        : [
          Btn.multiply,
          Btn.add,
          Btn.subtract,
          Btn.divide,
          Btn.calculate,
        ].contains(value)
        ? const Color.fromARGB(255, 253, 154, 5)
        : Color.fromARGB(255, 60, 60, 60);
  }

  modifiedBtnValue(value) {
    if (value == "@") {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset('assets/calculator.png'),
      );
    } else if(value == "*") {
      return Text(
        'x',
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
      );
    } else if(value == "/") {
      return Text(
        '÷',
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
      );
    } else {
      return Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
      );
    }
  }

    void onBtnTap(String value) {
    // if (value == Btn.del) {
    //   delete();
    //   return;
    // }

    if (value == Btn.xop) {
      context.read<CalculatorBloc>().add(OppositeSign(equation));
      return;
    }

    if (value == Btn.clr) {
      context.read<CalculatorBloc>().add(ClearAll(equation));
      return;
    }

    if (value == Btn.per) {
      // convertToPercentage();
      context.read<CalculatorBloc>().add(ConvertToPercentage(equation));
      return;
    }

    if (value == Btn.calculate) {
      print("Equation: " + equation);
      context.read<CalculatorBloc>().add(CalculateEquation(equation));
      return;
    }

    if (value == Btn.at) {
      isSnackVisible = true;
      _showSnackbar("Rawr! SnackBar Triggered", Colors.white);
      return;
    }

    
    context.read<CalculatorBloc>().add(StoreValues(value));
  }



}
