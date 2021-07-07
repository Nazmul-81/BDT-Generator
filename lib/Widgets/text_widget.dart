import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final label;
  final size;
  final color;
  final fontWeight;
  final textAlignment;
  final textDecoration;

  const MyText(
      {Key key,
      this.label,
      this.size,
      this.color,
      this.fontWeight,
      this.textAlignment,
      this.textDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "$label",
        style: TextStyle(
          decoration: textDecoration,
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
          fontFamily: 'Courgette',
        ),
        overflow: TextOverflow.clip,
        textAlign: (textAlignment == null) ? TextAlign.center : textAlignment,
      ),
    );
  }
}
