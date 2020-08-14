import 'package:flutter/material.dart';

class HomeTopInfo extends StatelessWidget {
  final textStyle = TextStyle(
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new AspectRatio(
        aspectRatio: 140/ 100,
        child: Container(
         
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: new SizedBox(height: 10)),
                    Text("What would ", style: textStyle),
                    Text(
                      "You Like To Plant ?",
                      style: textStyle,
                    ),
                    Image.asset(
                      "images/veg.png",
                      height: 170,
                      width: 295,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
