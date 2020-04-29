/// Simple pie chart with outside labels example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:finances/models/chart.dart';
import 'package:finances/view/screens/list_expense.dart';
import 'package:flutter/material.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withSampleData(Map<int, ChartCategory> chartExpense) {
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
  static List<charts.Series<ChartCategory, int>> _createSampleData(
      Map<int, ChartCategory> chartExpense) {
    List<ChartCategory> chartsList = convertList(chartExpense);

    return [
      new charts.Series<ChartCategory, int>(
        id: 'Sales',
        domainFn: (ChartCategory typeExpense, _) => typeExpense.description.index,
        measureFn: (ChartCategory typeExpense, _) => typeExpense.total,
        colorFn: (ChartCategory typeExpense, _) => typeExpense.color,
        data: chartsList,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (ChartCategory row, _) => '${row.description.description}',
      )
    ];
  }

  static List<ChartCategory> convertList(Map<int, ChartCategory> chartExpense) {
    List<ChartCategory> chart = [];
    chartExpense.forEach((key, value) => chart.add(value));
    return chart;
  }
}
