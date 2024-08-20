import 'package:flutter/material.dart';

Text textLarge(
  String text,
  BuildContext context, {
  double? fontSize,
  Color? textColor,
}) {
  double appFontSize =
      fontSize ?? Theme.of(context).textTheme.titleLarge!.fontSize!;
  Color appTextColor =
      textColor ?? Theme.of(context).textTheme.titleLarge!.color!;
  return Text(
    text,
    style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: appFontSize,
          color: appTextColor,
        ),
  );
}

Text textSmall(String text, BuildContext context,
    {TextOverflow textOverflow = TextOverflow.visible,
    int maxLines = 1000,
    double? fontSize,
    Color? textColor}) {
  double appFontSize =
      fontSize ?? Theme.of(context).textTheme.titleSmall!.fontSize!;
  Color appTextColor =
      textColor ?? Theme.of(context).textTheme.titleSmall!.color!;
  return Text(
    text,
    style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: appFontSize,
          color: appTextColor,
        ),
    overflow: textOverflow,
    maxLines: maxLines,
  );
}

Text textAppBar(String text, BuildContext context) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleLarge!.copyWith(
        color: Colors.white, fontWeight: FontWeight.normal, fontSize: 25),
  );
}
