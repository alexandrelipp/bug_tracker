import 'package:flutter/material.dart';

abstract class CustomRaisedButton extends StatelessWidget {
  final Color color;

  final Function onPressed;
  final Widget child;

  CustomRaisedButton({
    @required this.color,
    @required this.onPressed,
    @required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      onPressed: onPressed,
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
      {@required Color color,
      Color textColor = Colors.black,
      @required String text,
      @required Function onPressed})
      : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          color: color,
          onPressed: onPressed,
        );
}

class ImageButton extends CustomRaisedButton {
  ImageButton({
    @required Image image,
    @required String text,
    Color textColor = Colors.black,
    @required Function onPressed,
    @required Color color,
  })  : assert(image != null),
        assert(text != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              image,
              Text(
                text,
                style: TextStyle(color: textColor),
              ),
              Opacity(opacity: 0, child: image),
            ],
          ),
          onPressed: onPressed,
          color: color,
        );
}
