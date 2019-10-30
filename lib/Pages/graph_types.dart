import 'dart:math';
import 'dart:core';
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
          color: Colors.blue[300],),
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
      drawHorizontalGrid: true,
      getDrawingHorizontalGridLine: (value) {
        Color color = value % 30 == 0 ? Colors.blue[700] : Colors.transparent;
        return FlLine(
          color: color,
          strokeWidth: 0.5,
        );
      },
      getDrawingVerticalGridLine: (value) {
        Color color = value % 5 == 0 ? Colors.blue[700] : Colors.transparent;
        return FlLine(
          color: color,
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
            color: Colors.blue[700],
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
          color: Colors.blue[700],
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '0';
            case 85:
              return '1/3';
            case 171:
              return '2/3';
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
        show: false,
        border: Border.all(color: Colors.blue[700], width: 1),),
    minX: 0,
    maxX: bigList[0].length - 1.0,
    minY: 0,
    maxY: 255,
    lineBarsData: getActualLineData(bigList),
  );
}

List<LineChartBarData> getActualLineData(List<List<int>> bigList) {
  List<Color> colors = [Colors.yellow[400], Colors.orange[300], Colors.orange[600]];
  List<List<FlSpot>> spotList = new List<List<FlSpot>>();
  for (List<int> list in bigList) {
    spotList.add(createFlSpots(list));
  }
  List<LineChartBarData> barDataList = new List<LineChartBarData>();
  for (int i = 0; i < spotList.length; i++) {
    barDataList.add(new LineChartBarData(
      spots: spotList[i],
      isCurved: true,
      colors: [colors[i % colors.length]],
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
Widget genPieGraph(List<int> dataList) {
  if(dataList.length>0)
  return AspectRatio(
    aspectRatio: 1.3,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
          color: Colors.blue[300],),
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
                      sections: getActualPieData(dataList)),
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
  else
  return  SizedBox(
    width: 28,
  );
}

List<PieChartSectionData> getActualPieData(List<int> dataList) {
  List<int> countData = new List<int>();
  countData.add(0);
  countData.add(0);
  countData.add(0);
  for (int i = 0; i < dataList.length; i++) {
    if (dataList[i] > 171)
      countData[0]++;
    else if (dataList[i] > 86)
      countData[1]++;
    else
      countData[2]++;
  }
  if(dataList.length>0)
  return List.generate(countData.length, (i) {
    final double fontSize = 16;
    final double radius = 50;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xff0293ee),
          value: countData[0] + 0.0,
          title: ((countData[0] / dataList.length * 1000).round() / 10).toString() + "%",
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xfff8b250),
          value: countData[1] + 0.0,
          title: ((countData[1] / dataList.length * 1000).round() / 10).toString() + "%",
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: const Color(0xff845bef),
          value: countData[2] + 0.0,
          title: ((countData[2] / dataList.length * 1000).round() / 10).toString() + "%",
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
  return null;
}
