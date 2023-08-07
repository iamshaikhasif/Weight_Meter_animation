import 'package:flutter/material.dart';

import '../constants.dart';

class SwitchButton extends StatefulWidget {
  final Function(bool) onChanged;

  const SwitchButton({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton>
    with SingleTickerProviderStateMixin {

  bool _switched = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSwitch,
      child: customAnimatedSwitch(),
    );
  }

  void toggleSwitch() {
    setState(() {
      _switched = !_switched;
    });

    widget.onChanged(_switched);
  }

  customAnimatedSwitch() {
    return AnimatedContainer(
          duration: const Duration (seconds: 2),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: _switched ? colorOrange : colorBlue),
          width: 100.0,
          height: 40.0,
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 2.0,
                  ),
                  child: AnimatedAlign(
                    alignment: _switched
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle),
                      width: 30.0,
                      child: Center(
                        child: Text(
                          _switched?"Yes":"No",
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _switched ? colorOrange : colorBlue),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}