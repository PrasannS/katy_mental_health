import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'indicator.dart';
import 'dart:async';

Widget genLineGraph() {
  return AspectRatio(
    aspectRatio: 1.70,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
          color: const Color(0xff232d37)),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
        child: FlChart(
          chart: LineChart(lineData()),
        ),
      ),
    ),
  );
}

LineChartData lineData() {
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalGrid: true,
      getDrawingHorizontalGridLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 0.5,
        );
      },
      getDrawingVerticalGridLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 0.5,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        textStyle: TextStyle(
            color: const Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return 'JAN';
            case 2:
              return 'MAR';
            case 4:
              return 'APR';
            case 6:
              return 'JUN';
            case 8:
              return 'SEP';
            case 10:
              return 'NOV';
            case 20:
              return 'TEST';
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: TextStyle(
          color: const Color(0xff67727d),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '10k';
            case 3:
              return '30k';
            case 5:
              return '50k';
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: getActualLineData(),
  );
}

List<LineChartBarData> getActualLineData() {
  return [
    LineChartBarData(
      spots: [
        FlSpot(0, 3),
        FlSpot(6, 1),
        FlSpot(10, 4),
      ],
      isCurved: true,
      colors: [Color(0xff23b6e6)],
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: const FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    ),
    LineChartBarData(
      spots: [
        FlSpot(0, 5),
        FlSpot(5, 2),
        FlSpot(10, 4),
      ],
      isCurved: true,
      colors: [Color(0xff02d39a)],
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: const FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    ),
  ];
}

@override
Widget genPieGraph() {
  return Material(
    type: MaterialType.transparency,
    child: new Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
            color: const Color(0xff232d37)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20
            ),
            Text(
              "My Moods",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FlChart(
                      chart: PieChart(
                        PieChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: getActualPieData()),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Indicator(
                      color: Color(0xff0293ee),
                      text: 'Good',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color(0xfff8b250),
                      text: 'Meh',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color(0xff845bef),
                      text: 'Bad',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ],
        )),
  );
}

List<PieChartSectionData> getActualPieData() {
  return List.generate(3, (i) {
    final double fontSize = 16;
    final double radius = 50;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xff0293ee),
          value: 60,
          title: '40%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xfff8b250),
          value: 30,
          title: '30%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: const Color(0xff845bef),
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      default:
        return null;
    }
  });
}
