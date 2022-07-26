import 'package:flutter/material.dart';
import '/constants/colours.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String? subTitle;
  final TextStyle? subTitleStyle;
  final bool? isBackButton;
  const ScreenTitle(
      {Key? key,
      required this.title,
      this.subTitle,
      this.titleStyle,
      this.subTitleStyle,
      this.isBackButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            isBackButton!
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back,
                          size: 20, color: blackColor),
                    ),
                  )
                : const SizedBox(
                    width: 0,
                  ),
            // CustomLayout.lPad.sizedBoxW,
            TweenAnimationBuilder(
              child: Text(
                title,
                style: titleStyle ??
                    const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: blackColor),
              ),
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1000),
              builder: (context, double _val, Widget? child) {
                return Opacity(
                    opacity: _val,
                    child: Padding(
                      padding: EdgeInsets.only(left: _val * 10),
                      child: child,
                    ));
              },
            ),
          ],
        ),
        TweenAnimationBuilder(
          child: Text(
            subTitle ?? '',
            style: subTitleStyle ??
                const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: blackColor),
          ),
          duration: const Duration(milliseconds: 1000),
          tween:
              AlignmentTween(begin: Alignment.topRight, end: Alignment.topLeft),
          builder: (context, Alignment _val, Widget? child) {
            return Align(
              child: child,
              alignment: _val,
            );
          },
        ),
      ],
    );
  }
}
