import 'package:finances/view/screens/list_expense.dart';
import 'package:flutter/material.dart';

void main() => runApp(FinancesApp());

class FinancesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF0336FF),
          accentColor: Colors.blueGrey,
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueGrey,
              shape: RoundedRectangleBorder(),
              textTheme: ButtonTextTheme.primary)),
      home: ListExpenses(),
    );
  }
}
