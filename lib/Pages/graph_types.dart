import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'indicator.dart';
import 'dart:async';

Widget genLineGraph(List<List<int>> bigList) {
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
          chart: LineChart(
            lineData(bigList),
          ),
        ),
      ),
    ),
  );
}

LineChartData lineData(List<List<int>> bigList) {
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
          if (value == bigList[0].length ~/ 4)
            return (bigList[0].length ~/ 4).toString();
          else if (value == bigList[0].length ~/ 2)
            return (bigList[0].length ~/ 2).toString();
          else if (value == bigList[0].length * 3 ~/ 4)
            return (bigList[0].length * 3 ~/ 4).toString();
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
            case 0:
              return '0 hr';
            case 43:
              return '4 hr';
            case 85:
              return '8 hr';
            case 128:
              return '12 hr';
            case 171:
              return '16 hr';
            case 213:
              return '20 hr';
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
    maxX: bigList[0].length - 1.0,
    minY: 0,
    maxY: 255,
    lineBarsData: getActualLineData(bigList),
  );
}

List<LineChartBarData> getActualLineData(List<List<int>> bigList) {
  List<List<FlSpot>> spotList = new List<List<FlSpot>>();
  for (List<int> list in bigList) {
    spotList.add(createFlSpots(list));
  }
  List<LineChartBarData> barDataList = new List<LineChartBarData>();
  for (List<FlSpot> list in spotList) {
    barDataList.add(new LineChartBarData(
      spots: list,
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
    ));
  }
  return barDataList;
}

List<FlSpot> createFlSpots(List<int> list) {
  print(list.length);
  List<FlSpot> ret = new List<FlSpot>();
  if (list == null || list.length == 0) {
    ret.add(new FlSpot(0, 0));
    return ret;
  }
  for (int i = 0; i < list.length; i++) {
    ret.add(new FlSpot(i + 0.0, list[i] + 0.0));
  }
  return ret;
}

@override
Widget genPieGraph() {
  return AspectRatio(
    aspectRatio: 1.3,
    child: Card(
      color: Color(0xff232d37),
      child: Row(
        children: <Widget>[
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
    ),
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
