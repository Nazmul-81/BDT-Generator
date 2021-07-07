import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  final label;
  final value;
  final labelSize;
  final labelColor;
  final labelFontWeight;
  final valueSize;
  final valueColor;
  final valueFontWeight;
  final textAlignment;

  const MyRichText(
      {Key key,
      this.label,
      this.value,
      this.labelSize,
      this.labelColor,
      this.labelFontWeight,
      this.valueSize,
      this.valueColor,
      this.valueFontWeight,
      @required this.textAlignment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlignment,
      overflow: TextOverflow.clip,
      text: TextSpan(
        text: '$label',
        style: TextStyle(
          fontFamily: 'Courgette',
          fontSize: labelSize,
          color: labelColor,
          fontWeight: labelFontWeight,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '$value',
            style: TextStyle(
              fontSize: valueSize,
              color: valueColor,
              fontWeight: valueFontWeight,
              fontFamily: 'Courgette',
            ),
          ),
        ],
      ),
    );
  }
}
