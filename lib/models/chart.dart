import 'package:charts_flutter/flutter.dart';
import 'package:finances/models/expense_types.dart';

class ChartCategory {
  double total;
  Category description;
  Color color;

  ChartCategory(this.total, this.description, this.color);
}
