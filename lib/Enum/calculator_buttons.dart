/*

ENUM: defines a fixed set of constant values,
      its often use when having predefined list of options (hindi na magbabago ng values kumbaga)

*/

enum Buttons {

  // yung clr xop, per, at iba pa
  // sila ay enum values (or constants) inside the Buttons
  clr("AC"),
  xop("+/-"),
  per("%"),
  divide("/"),
  n7("7"),
  n8("8"),
  n9("9"),
  multiply("*"),
  n4("4"),
  n5("5"),
  n6("6"),
  subtract("-"),
  n1("1"),
  n2("2"),
  n3("3"),
  add("+"),
  at("@"),
  n0("0"),
  dot("."),
  calculate("=");

  // define a variable type inside of name
  // sa ginawa ko, string ang laman kaya string hehe
  // kasi each of these enum values has an associated value
  final String value;

  // This is a constructor for the Buttons enum.
  const Buttons(this.value);
  // It allows each enum value to have an associated value field when the enum is created.
}