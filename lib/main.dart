import 'package:finances/screens/list_expense.dart';
import 'package:flutter/material.dart';

void main() => runApp(FinancesApp());

class FinancesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF0336FF), accentColor: Color(0xFFFFDE03)),
      home: ListExpenses(),
    );
  }
}
