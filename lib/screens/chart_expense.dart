/// Simple pie chart with outside labels example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:finances/models/expense.dart';
import 'package:finances/screens/list_expense.dart';
import 'package:flutter/material.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withSampleData(Map<int, Chart> chartExpense) {
    return new PieOutsideLabelChart(
      _createSampleData(chartExpense),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gráfico mensal"),
      ),
      body: createChart(),
    );
  }

  Widget createChart() {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside)
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Chart, int>> _createSampleData(
      Map<int, Chart> chartExpense) {
    List<Chart> chartsList = convertList(chartExpense);

    return [
      new charts.Series<Chart, int>(
        id: 'Sales',
        domainFn: (Chart typeExpense, _) => typeExpense.description.index,
        measureFn: (Chart typeExpense, _) => typeExpense.total,
        data: chartsList,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (Chart row, _) => '${row.description.description}',
      )
    ];
  }

  static List<Chart> convertList(Map<int, Chart> chartExpense) {
    List<Chart> chart = [];
    chartExpense.forEach((key, value) => chart.add(value));
    return chart;
  }
}
