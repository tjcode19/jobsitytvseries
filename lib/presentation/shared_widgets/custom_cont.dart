import 'package:flutter/material.dart';
import '/constants/colours.dart';

class CustomCont extends StatelessWidget {
  final Color? bgColor;
  final Widget? child;
  final double radTopLeft;
  final double radTopRight;
  final double radBottomLeft;
  final double radBottomRight;
  final double vPadding;
  final double hPadding;
  final double vMargin;
  final double hMargin;
  final double? width;
  final double? height;
  final shadow;
  final border;
  final bgImage;
  final action;

  const CustomCont(
      {Key? key,
      this.bgColor = appPrimaryColor,
      this.child,
      this.radTopLeft = 3.0,
      this.radTopRight = 3.0,
      this.radBottomLeft = 3.0,
      this.radBottomRight = 3.0,
      this.width,
      this.height,
      this.border,
      this.bgImage,
      this.shadow = true,
      this.vPadding = 5.0,
      this.hPadding = 10.0,
      this.vMargin = 0.0,
      this.hMargin = 0.0,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: width ,
        height:  height ,
        padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
        margin: EdgeInsets.symmetric(vertical: vMargin, horizontal: hMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radTopLeft),
            topRight: Radius.circular(radTopRight),
            bottomLeft:  Radius.circular(radBottomLeft),
            bottomRight:  Radius.circular(radBottomRight),
          ),
          image: (bgImage != null) ? bgImage : null,
          color: bgColor,
          border: (border != null) ? border : null,
          boxShadow: (shadow)
              ? [
                  const BoxShadow(
                    color: Color(0xFFC0C9DA),
                    blurRadius: 15,
                    offset: Offset(-2, 4), // Shadow position
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }
}
