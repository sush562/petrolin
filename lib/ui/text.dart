import 'package:flutter/material.dart';

Widget textLarge(String text, BuildContext context) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
  );
}

Widget textSmall(String text, BuildContext context) {
  return Text(text, style: Theme.of(context).textTheme.titleSmall);
}

Widget textAppBar(String text, BuildContext context) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleLarge!.copyWith(
        color: Colors.white, fontWeight: FontWeight.normal, fontSize: 25),
  );
}
