import 'package:flutter/material.dart';

abstract class CustomRaisedButton extends StatelessWidget {
  final Color? color;

  final Function onPressed;
  final Widget child;

  CustomRaisedButton({
    required this.color,
    required this.onPressed,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      onPressed: onPressed as void Function()?,
      color: color,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        child: child,
      ),
    );
  }
}

class OnlyTextButton extends CustomRaisedButton {
  OnlyTextButton(
      {required Color? color,
      Color textColor = Colors.black,
      required String text,
      required Function onPressed})
      : super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 25),
          ),
          color: color,
          onPressed: onPressed,
        );
}

class ImageButton extends CustomRaisedButton {
  ImageButton({
    required Widget image,
    required String text,
    Color textColor = Colors.black,
    required Function onPressed,
    required Color color,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              image,
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                ),
              ),
              Opacity(opacity: 0, child: image),
            ],
          ),
          onPressed: onPressed,
          color: color,
        );
}
