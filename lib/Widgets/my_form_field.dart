import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final controller;
  final labelText;
  final validationMassage;
  final onChange;
  final obscureText;
  final isPass;
  final color;
  const MyTextFormField(
      {Key key,
      @required this.controller,
      @required this.labelText,
      @required this.validationMassage,
      @required this.onChange,
      @required this.obscureText,
      @required this.isPass,
      this.color})
      : super(key: key);
  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool suff = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Theme(
        data: new ThemeData(
          primaryColor: (widget.color == null) ? Colors.white : widget.color,
          primaryColorDark: Colors.green,
        ),
        child: TextFormField(
          autofocus: true,
          style: TextStyle(
            color: (widget.color == null) ? Colors.white : widget.color,
            fontFamily: 'Courgette',
          ),
          controller: widget.controller,
          obscureText: (widget.isPass == false) ? false : suff,
          decoration: InputDecoration(
            fillColor: (widget.color == null) ? Colors.white : widget.color,
            focusColor: (widget.color == null) ? Colors.white : widget.color,
            hoverColor: (widget.color == null) ? Colors.white : widget.color,
            suffixIcon: (widget.isPass == true)
                ? Padding(
                    padding: const EdgeInsetsDirectional.only(end: 12.0),
                    child: IconButton(
                      icon: (suff)
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          suff = !suff;
                        });
                      },
                    ), // myIcon is a 48px-wide widget.
                  )
                : null,
            labelText: widget.labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return widget.validationMassage;
            }
            return null;
          },
          onChanged: widget.onChange,
        ),
      ),
    );
  }
}
