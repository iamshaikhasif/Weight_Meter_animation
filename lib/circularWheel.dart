import 'dart:math';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:flutter/material.dart';
import 'package:weight_meter_animation/constants.dart';

class CircularWheel extends StatefulWidget {
  final Function(int) onChanged;
  final int initVal;
  final String type;
  const CircularWheel({Key? key, required this.onChanged, required this.initVal, required this.type}):super(key: key);

  @override
  State<CircularWheel> createState() => CircularWheelState();
}

class CircularWheelState extends State<CircularWheel>
    with TickerProviderStateMixin {
  List<int> data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<int> dataShow = [10, 20, 30, 40, 50, 60, 70, 80, 90];
  double radius = 118.0;
  late int min, max;

  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();

    /*animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();*/

    setKGData(widget.initVal, widget.type.toLowerCase());
  }

  setMinAndMax(String type){
    if(type == "kg"){
      min = 20;
      max = 200;
    }else{
      min = 44;
      max = 441;
    }
  }

  setKGData(int initVal, String type){
    setMinAndMax(type);
    if(initVal >= max){
      initVal = max;
    }
    if(type == "lb"){
      int v = (initVal / 0.45359237).round();
      if(v >= max){
        initVal = max;
      }
    }
    int leftTemp = initVal;
    int rightTemp = initVal;
    List<int> leftData = [];
    List<int> rightData = [];
    for(int  i = 0; i < 4; i++){
      leftTemp = leftTemp - 10;
      leftData.add(leftTemp);
    }
    for(int  i = 0; i < 4; i++){
      rightTemp = rightTemp + 10;
      rightData.add(rightTemp);
    }
    dataShow.clear();
    dataShow.addAll(leftData.reversed);
    dataShow.add(initVal);
    dataShow.addAll(rightData);
    setState(() {});
  }

  setLBData(int initVal, String type){
    setMinAndMax(type);
    if(initVal >= max){
      initVal = max;
    }
    int leftTemp = initVal;
    int rightTemp = initVal;
    List<int> leftData = [];
    List<int> rightData = [];
    for(int  i = 0; i < 4; i++){
      leftTemp = leftTemp - 10;
      leftData.add(leftTemp);
    }
    for(int  i = 0; i < 4; i++){
      rightTemp = rightTemp + 10;
      rightData.add(rightTemp);
    }
    dataShow.clear();
    dataShow.addAll(leftData.reversed);
    dataShow.add(initVal);
    dataShow.addAll(rightData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    radius = MediaQuery.of(context).size.width / 3;
    return wheel();
  }

  Widget wheel() {
    return Stack(
      children: [
        Stack(children: list(true)),
        Stack(children: list(false)),
        SwipeDetector(
          onSwipeRight: (details) {
            // Swiping in right direction.
            if(dataShow[4] != min){
              List<int> newData = [];
              for (int i = 0; i < dataShow.length; i++) {
                newData.add(dataShow[i] - 10);
              }
              dataShow.clear();
              dataShow.addAll(newData);
              widget.onChanged(dataShow[4]);
              setState(() {});
            }
          },
          onSwipeLeft: (details) {
            // Swiping in left direction.
            if(dataShow[4] != max) {
              List<int> newData = [];
              for (int i = 0; i < dataShow.length; i++) {
                newData.add(dataShow[i] + 10);
              }
              dataShow.clear();
              dataShow.addAll(newData);
              widget.onChanged(dataShow[4]);
              setState(() {});
            }
          },
          child: Container(
            color: Colors.transparent,
            width: double.maxFinite,
            height: 130,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 10,
                        child: Container(
                          width: 10.0,
                          height: 80.0,
                          decoration: new BoxDecoration(
                            color: colorOrange,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10),),),
                        ),
                      ),

                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorOrange, // Set the border color here
                        width: 3, // Set the border width here
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> list(isRotated) {
    final double firstItemAngle = pi;
    final double lastItemAngle = pi;
    final double angleDiff = (firstItemAngle + lastItemAngle) / 19.9;
    double currentAngle = firstItemAngle + (isRotated ? .15 : 0);
    return data.map((int index) {
      currentAngle += angleDiff;
      return _radialListItem(
        currentAngle,
        index,
        isRotated,
        dataShow[index - 1],
      );
    }).toList();
  }

  Widget _radialListItem(double angle, int index, bool isRotated, int data) {
    var x = cos(angle) * radius;
    var y = sin(angle) * radius;

    return Center(
      child: Transform(
          transform: Matrix4.translationValues(x, y, 0.0),
          child: Column(
            children: [
              SizedBox(height: 130),
              Column(
                children: [
                  isRotated
                      ? Visibility(
                          visible: index != 9,
                          child: Transform.rotate(
                              angle: getAngle(index),
                              child: Container(
                                width: 1,
                                height: 13,
                                color: Colors.grey,
                              )))
                      : Text(
                          "$data",
                          style: TextStyle(
                            color: index == 5 ? Colors.black : Colors.grey,
                            fontSize: index == 5 ? 16 : 14,
                            fontWeight:
                                index == 5 ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                ],
              ),
            ],
          ),),
    );
  }

  getAngle(index) {
    switch (index) {
      case 1:
        return -70.0;
      case 2:
        return -85.5;
      case 3:
        return -50.8;
      case 4:
        return 50.0;
      case 5:
        return 50.5;
      case 6:
        return 60.0;
      case 7:
        return -84.0;
      case 8:
        return 70.0;
      case 9:
        return 60.0;
    }
  }
}
