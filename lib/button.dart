import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final buttonColor;
  final textColor;
  final String buttonText;
  final tapped;

  const Button({
    Key key,
    this.buttonColor,
    this.textColor,
    this.buttonText,
    this.tapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(
              2.0,
              2.0,
            ),
            blurRadius: 8.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(
              -2.0,
              -2.0,
            ),
            blurRadius: 8.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: MaterialButton(
        padding: EdgeInsets.all(30.0),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 22.0,
            color: textColor,
          ),
        ),
        onPressed: () {
          tapped();
        },
      ),
    );
  }
}
