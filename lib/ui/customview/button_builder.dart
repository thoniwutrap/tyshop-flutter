import 'package:flutter/material.dart';

  @immutable
  class SignInButtonBuilder extends StatelessWidget {

  final Icon icon;
  final bool mini;
  final String text;
  final Color textColor, backgroundColor, splashColor;
  final Function onPressed;
  final EdgeInsets padding;
  final double elevation;
  final double width;


  SignInButtonBuilder({
    Key key,
    @required this.icon,
    @required this.backgroundColor,
    @required this.onPressed,
    @required this.text,
    this.textColor = Colors.white,
    this.splashColor = Colors.white30,
    this.padding = const EdgeInsets.all(3.0),
    this.mini = false,
    this.elevation = 2.0,
    this.width = null,
  })  : assert(text != null),
        assert(icon != null),
        assert(textColor != null),
        assert(backgroundColor != null),
        assert(onPressed != null),
        assert(mini != null),
        assert(elevation != null);


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: key,
      minWidth: mini ? 35.0 : null,
      elevation: elevation,
      padding: padding,
      color: backgroundColor,
      onPressed: onPressed,
      splashColor: splashColor,
      child: mini
          ? Container(
               decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)),
              width: 35.0,
              height: 35.0,
              child: Icon(
                Icons.access_alarm,
                color: Colors.white,
              ),
            )
          : Container(
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)),
              constraints: BoxConstraints(
                maxWidth: width ?? MediaQuery.of(context).size.width / 1.5,
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
                      child: Image.asset('assets/images/ic_facebook.png',scale: 2,)
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}