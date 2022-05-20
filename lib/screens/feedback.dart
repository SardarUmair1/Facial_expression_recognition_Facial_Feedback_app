import 'package:e_leaning/screens/facialfeedback.dart';
import 'package:e_leaning/screens/tempcam.dart';
import 'package:e_leaning/utils/routes.dart';
import "package:flutter/material.dart";
import 'package:velocity_x/velocity_x.dart';

class Feedbackscreen extends StatelessWidget {
  final doc;
  Feedbackscreen(this.doc);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        height: 80,
      ),
      "Discover Feedback".text.purple900.xl.bold.makeCentered(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        "Select ".text.xl3.bold.bold.black.makeCentered(),
        "One".text.xl3.bold.purple900.bold.makeCentered(),
      ]),
      SizedBox(
        height: 20,
      ),
      Stack(
        children: [
          InkWell(
            onTap: () => {
              //print(value),
              Navigator.pushNamed(
                  context, MyRoutes.TempfaicalfeedabackRouteCheck),
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 90, vertical: 30),
              padding: EdgeInsets.only(top: 33, left: 20),
              width: 300,
              height: 87,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Camera".text.black.bold.xl.make(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "Feed ".text.xl.bold.purple900.make(),
                      "back".text.xl.bold.purple900.bold.make(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 28,
              left: 240,
            ),
            height: 87,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage("assets/images/facialfeedbackoption.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    ]));
  }
}
