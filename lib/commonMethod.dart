import 'package:flutter/material.dart';
import 'package:weight_meter_animation/constants.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}


class OptionButton extends StatelessWidget {
  bool isActive = false;
  final VoidCallback onTap;
  final String title;
  final double? fontSize;
  bool isHasCheckBox = false;
  bool isCenterText = false;

  OptionButton(
      {Key? key,
        required this.isActive,
        required this.onTap,
        required this.title,
        this.fontSize,
        this.isCenterText = false,
        this.isHasCheckBox=false,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$title button is $isActive');
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? buttonBgLightColor : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(width: isActive ? 2 : 1, color: isActive ? buttonBgColor : borderColor),
        ),
        child: Row(
          mainAxisAlignment: isCenterText ? MainAxisAlignment.center :  MainAxisAlignment.start,
          children: [
            Visibility(
              visible: isHasCheckBox,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Icon(isActive ? Icons.check_box : Icons.check_box_outline_blank,color: isActive ? colorOrange : secondaryTextColor,),
              ),
            ),Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryTextColor,
                fontWeight: FontWeight.w600,
                fontSize: fontSize == null ? 14 : fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}