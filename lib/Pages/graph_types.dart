import 'dart:math';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'indicator.dart';
import 'dart:async';

Widget genLineGraph(List<int> dates, List<List<int>> bigList, List<String> names) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(18),
      ),
      color: Colors.blue[300],
    ),
    child: Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 24.0, left: 10.0, top: 24, bottom: 12),
            child: FlChart(
              chart: LineChart(
                lineData(dates, bigList),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: genWidgetList(names),
          ),
        ),
      ],
    ),
  );
}

List<Widget> genWidgetList(List<String> names) {
  List<Color> colors = [
    Colors.yellow[400],
    Colors.orange[300],
    Colors.orange[600]
  ];
  List<Widget> ret = new List<Widget>();
  for (int i = 0; i < names.length; i++)
    ret.add(Indicator(
      color: colors[i],
      text: names[i],
      isSquare: true,
    ));
  return ret;
}

LineChartData lineData(List<int> dates, List<List<int>> bigList) {
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
            color: Colors.blue[700], fontWeight: FontWeight.bold, fontSize: 16),
        getTitles: (value) {
          if (value == bigList[0].length ~/ 4)
            return DateTime.fromMillisecondsSinceEpoch(dates[value ~/ 1]).month.toString() + "/" + DateTime.fromMillisecondsSinceEpoch(dates[value ~/ 1]).day.toString();
          else if (value == bigList[0].length ~/ 2)
            return DateTime.fromMillisecondsSinceEpoch(dates[value ~/ 1]).month.toString() + "/" + DateTime.fromMillisecondsSinceEpoch(dates[value ~/ 1]).day.toString();
          else if (value == bigList[0].length * 3 ~/ 4)
            return DateTime.fromMillisecondsSinceEpoch(dates[value ~/ 1]).month.toString() + "/" + DateTime.fromMillisecondsSinceEpoch(dates[value ~/ 1]).day.toString();
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
      border: Border.all(color: Colors.blue[700], width: 1),
    ),
    minX: 0,
    maxX: bigList[0].length - 1.0,
    minY: 0,
    maxY: 255,
    lineBarsData: getActualLineData(bigList),
  );
}

List<LineChartBarData> getActualLineData(List<List<int>> bigList) {
  List<Color> colors = [
    Colors.yellow[400],
    Colors.orange[300],
    Colors.orange[600]
  ];
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
  if (dataList.length > 0)
    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
          color: Colors.blue[300],
        ),
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
    return SizedBox(
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
  if (dataList.length > 0)
    return List.generate(countData.length, (i) {
      final double fontSize = 16;
      final double radius = 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: countData[0] + 0.0,
            title: ((countData[0] / dataList.length * 1000).round() / 10)
                    .toString() +
                "%",
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
            title: ((countData[1] / dataList.length * 1000).round() / 10)
                    .toString() +
                "%",
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
            title: ((countData[2] / dataList.length * 1000).round() / 10)
                    .toString() +
                "%",
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

class BarChartSample1 extends StatefulWidget {
  List<int> data;

  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  BarChartSample1({this.data});

  @override
  State<StatefulWidget> createState() => BarChartSample1State(data: data);
}

class BarChartSample1State extends State<BarChartSample1> {
  List<int> data;
  final Color barBackgroundColor = Colors.grey[400];
  final Duration animDuration = Duration(milliseconds: 250);

  StreamController<BarTouchResponse> barTouchedResultStreamController;

  int touchedIndex;

  BarChartSample1State({this.data});

  @override
  void initState() {
    super.initState();
    barTouchedResultStreamController = StreamController();
    barTouchedResultStreamController.stream
        .distinct()
        .listen((BarTouchResponse response) {
      if (response == null) {
        return;
      }

      if (response.spot == null) {
        setState(() {
          touchedIndex = -1;
        });
        return;
      }

      setState(() {
        if (response.touchInput is FlLongPressEnd) {
          touchedIndex = -1;
        } else {
          touchedIndex = response.spot.touchedBarGroupPosition;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(data.toString());
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.blue[300],
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: FlChart(
                        swapAnimationDuration: animDuration,
                        chart: BarChart(mainBarData()),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    barTouchedResultStreamController.close();
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: TouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                String activity;
                switch (touchedSpot.spot.x.toInt()) {
                  case 0:
                    activity = 'Work';
                    break;
                  case 1:
                    activity = 'Education';
                    break;
                  case 2:
                    activity = 'Relax';
                    break;
                  case 3:
                    activity = 'Family';
                    break;
                  case 4:
                    activity = 'Food';
                    break;
                  case 5:
                    activity = 'Friends';
                    break;
                  case 6:
                    activity = 'Extra-Curricular';
                    break;
                  case 7:
                    activity = 'Other';
                    break;
                }
                return TooltipItem(
                    activity + '\n' + (touchedSpot.spot.y - 1).toString(),
                    TextStyle(color: Colors.yellow));
              }).toList();
            }),
        touchResponseSink: barTouchedResultStreamController.sink,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'Work';
                case 1:
                  return 'Edu';
                case 2:
                  return 'Relax';
                case 3:
                  return 'Family';
                case 4:
                  return 'Food';
                case 5:
                  return 'Friends';
                case 6:
                  return 'EXC';
                case 7:
                  return 'Other';
                default:
                  return '';
              }
            }),
        leftTitles: const SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> groups = new List<BarChartGroupData>();
    List<double> counter = [0, 0, 0, 0, 0, 0, 0, 0];
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        if (data[i] < 0 || data[i] > 7) continue;
        counter[data[i]]++;
      }
    }
    print(data);
    print(counter);
    for (int i = 0; i < counter.length; i++) {
      groups.add(makeGroupData(i, counter[i], isTouched: i == touchedIndex));
    }
    return groups;
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
  }) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        y: isTouched && y != -1? y + 1 : y,
        color: isTouched ? Colors.yellow : barColor,
        width: width,
        isRound: true,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: 20,
          color: Color.fromARGB(50, 33, 28, 8),
        ),
      ),
    ]);
  }
}
