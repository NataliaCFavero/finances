import 'package:finances/screens/list_expense.dart';
import 'package:flutter/material.dart';

void main() => runApp(FinancesApp());

class FinancesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListExpenses(),
    );
  }
}
