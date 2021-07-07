import 'package:flutter/material.dart';

class MyCondition extends StatefulWidget {
  final condition;
  final child;
  final elseChild;

  const MyCondition(
      {Key key, @required this.child, @required this.condition, this.elseChild})
      : super(key: key);
  @override
  _MyConditionState createState() => _MyConditionState();
}

class _MyConditionState extends State<MyCondition> {
  @override
  Widget build(BuildContext context) {
    Widget elseChild;
    if (widget.elseChild == null) {
      elseChild = Container();
    } else {
      elseChild = widget.elseChild;
    }
    return (widget.condition) ? widget.child : elseChild;
  }
}
