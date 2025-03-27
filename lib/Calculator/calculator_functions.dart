// calculator_functions.dart
import 'package:bloc_sample/Calculator/button_values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define events
abstract class CalculatorEvent {}

// class AddNumbers extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   AddNumbers(this.num1, this.num2);
// }

// class MinusNumbers extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   MinusNumbers(this.num1, this.num2);
// }

// class MultiplyNumbers extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   MultiplyNumbers(this.num1, this.num2);
// }

// class DivideNumbers extends CalculatorEvent {
//   final int num1;
//   final int num2;

//   DivideNumbers(this.num1, this.num2);
// }

// eto yung mga list of events
class ClearAll extends CalculatorEvent {
  final String equation;

  ClearAll(this.equation);
}

class StoreValues extends CalculatorEvent {
  final String value;

  StoreValues(this.value);
}

class CalculateEquation extends CalculatorEvent {
  final String equation;

  CalculateEquation(this.equation);
}

class ConvertToPercentage extends CalculatorEvent{
  final String equation;

  ConvertToPercentage(this.equation);
}

class OppositeSign extends CalculatorEvent{
  final String equation;

  OppositeSign(this.equation);
}


// Define states
abstract class CalculatorState {}

// dito naman naka declare ang state at yung value na isesend sa UI
class CalculatorInitial extends CalculatorState {}

class CalculatorResult extends CalculatorState {
  final String result;

  CalculatorResult(this.result);
}


// BLoC class
class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  //CalculatorBloc() : super(CalculatorInitial()) {
    // on<AddNumbers>((event, emit) {
    //   final result = (event.num1 + event.num2).toString(); // Perform addition
    //   emit(CalculatorResult(result)); // Emit the result
    // });

    // on<MinusNumbers>((event, emit) {
    //   final result = (event.num1 - event.num2).toString();
    //   emit(CalculatorResult(result));
    // });

    // on<MultiplyNumbers>((event, emit) {
    //   final result = (event.num1 * event.num2).toString();
    //   emit(CalculatorResult(result));
    // });

    // on<DivideNumbers>((event, emit) {
    //   final result;
    //   if (event.num2 == 0) {
    //     result  = "Undefined";
    //   } else {
    //     result = (event.num1 / event.num2).toString();
    //   }
     
    //   emit(CalculatorResult(result));
    // });

  //   on<ClearAll>((event, state) {
  //     String equation = event.equation;
  //     equation = "";
  //     emit(CalculatorResult(equation));
  //   });

  //   on<StoreValues>((event, emit) {
  //     String lastVal = "";
  //     String equation = event.equation;
  //     String value = event.value;

  //     var storedVal = "";

  //     if (equation.isEmpty && RegExp(r'[+\-*/]').hasMatch(value)) {
  //       value = "";
  //     }
  //     if (equation.isEmpty && value == Btn.n0) {
  //       value = "";
  //     }

  //     if (equation.length > 1) {
  //       lastVal = equation[equation.length - 1];

      
  //       if (RegExp(r'[+\-*/]').hasMatch(lastVal) && RegExp(r'[+\-*/]').hasMatch(value)) {
  //         value = ""; 
  //       } else if(equation == "." && value == ".") {
  //         value = ""; 
  //       }
  //     }

  //     print("Last Equation: " + lastVal);

  //     // Replacing "/" with "÷"
  //     if (value == "/") {
  //       value = "÷";
  //     }

  //     equation += value;  
  //     storedVal += value;
  //     print("Display: " + storedVal);

  //     emit(CalculatorResult(equation));
  //   });
    
  // }

  // }

  // 
  String equation = "";

  CalculatorBloc() : super(CalculatorInitial()) {
    on<ClearAll>((event, emit) {
      // clear the equation
      equation = "";
      emit(CalculatorResult(equation));
    });

    on<StoreValues>((event, emit) {
      // re assign the value variable for ano ganun
      String value = event.value;

      // kapag invalid yung first input return nothing lang
      if (equation.isEmpty && RegExp(r'[+\-*/]').hasMatch(value)) {
        value = ""; 
      }
      if (equation.isEmpty && value == Btn.n0) {
        value = ""; 
      }

      if (equation.isEmpty && value == Btn.dot) {
        value = ""; 
      }

      if (equation.isNotEmpty) {
        String lastVal = equation[equation.length - 1];

        // regex lang yan ng mga operators
        if (RegExp(r'[+\-*/]').hasMatch(lastVal) && RegExp(r'[+\-*/]').hasMatch(value)) {
          value = ""; 
        }

        if (lastVal == "." && value == Btn.dot) {
          value = ""; 
        }
      }

      // ohhh papalitan lang ng value ng divide sign
      if (value == "/") {
        value = "÷";
      }

      // tapos asign yung equation variable sa na store na values
      equation += value;

      // emit para ma update value ni equation
      emit(CalculatorResult(equation));
    });

    on<CalculateEquation>((event, emit) {
      calculateResult(emit);
    });

    on<ConvertToPercentage>((event, emit) {
      if (equation.isNotEmpty && equation.contains(RegExp(r'[+\-*/]'))) {
        // pag na limutan i calculate, system na gagawa. kahiya e
        calculateResult(emit); 
      }

      // try and catch para hindi mag crash yung app
      try {
        final number = double.parse(equation);
        equation = "${number / 100}";
        if (equation.endsWith(".0")) {
          equation = equation.substring(0, equation.length - 2);
        }
      } catch (e) {
        print("Error parsing equation: $e");
      }

      emit(CalculatorResult(equation));
    });

    on<OppositeSign>((event, emit) {
      if (equation.isNotEmpty && equation.contains(RegExp(r'[+\-*/]'))) {
        // calculate na naman bago mag proceed
        calculateResult(emit); 
      }

      // another try and catch
      try {
        final number = double.parse(equation);
        final result = number * -1;
        equation = result.toString();
        if (equation.endsWith(".0")) {
          // ano lang to, kapg .0 yung dulo, tanggalin na 
          equation = equation.substring(0, equation.length - 2);
        }
      } catch (e) {
        equation = "Error";
        print("Error parsing equation: $e");
      }

      // emit na ulit para updated na si equation
      emit(CalculatorResult(equation));
    });
  }

  // tawagin si calculate kapag may i cacalculate
  void calculateResult(Emitter<CalculatorState> emit) {
    try {
      var result = 0.0;
      var currNumber = 0.0;
      var currOperator = '+';
      var i = 0;

      // Out while loop, irun yung loop kung gaano karami yung character ng equation natin
      while (i < equation.length) {
        // tapos gawing character kasi galing string
        var ch = equation[i];
        
        // check kung number or operator or dot
        if (int.tryParse(ch) != null || ch == '.') {
          // kapag number, lagay sa temporary variable
          var temp = ch.toString();
          // tapos usad sa loop, next character naman
          i++;

          // loop ulit, walang katupasan na loop
          // ano lang to, hanggat number yung character, ilagay sa temporary variable
          while (i < equation.length &&
              (int.tryParse(equation[i]) != null || equation[i] == '.')) {
            temp += equation[i];
            i++;
          }

          // tapos convert yung naipon na value sa temporary variable into double
          currNumber = double.parse(temp);
          // minus 1 na count kasi sobra, dahil sa loop.
          i--;
        }

        // kapag operator naman na-detect
        // calculate lang yung mga numbers
        // ang inital na operator natin ay '+'
        // kaya mang yayare ganto
        // inpput: 4 + 5
        // result += 4 kasi plus inital na sign kaya add lang yung unang number sa result
        // tapos next, since '+' ulit yung next operator add ulit bale may 4 na tapos then add 5
        // result = 4 + 5 = 9
        if (ch == '+' || ch == '-' || ch == '*' || ch == '÷' || i == equation.length - 1) {
          switch (currOperator) {
            case '+':
              result += currNumber;
              break;
            case '-':
              result -= currNumber;
              break;
            case '*':
              result *= currNumber;
              break;
            case '÷':
              if (currNumber == 0.0) {
                equation = "Undefined";
                emit(CalculatorResult(equation));
                return;
              } else {
                result /= currNumber;
              }
              break;
          }
          
          // check lang kung empty yung operator, kung empty edi walang ilalagay
          if (ch != ' ') {
            currOperator = ch;
          }
          // after ng calculation, reset yung currNumber kasi nga nakaloop nganiiiii
          currNumber = 0.0;
        }

        // usad sa loop, at paulit ulit lang yan.
        i++;
      }

      // kapag napagod na mag loop, tanggalin yung sobrang zero na hindi naman kailangan.
      equation = result % 1 == 0.0 ? result.toInt().toString() : result.toString();
      emit(CalculatorResult(equation));
    } catch (e) {
      // dito kapag may erro, bahala ka diyan
      equation = "Error";
      // emit(CalculatorResult(equation));
    }
  }
}

