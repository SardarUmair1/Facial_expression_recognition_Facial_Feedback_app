import 'package:e_leaning/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import "package:flutter/material.dart";

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  "HELLO THERE!".text.bold.xl5.purple900.makeCentered(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Automatic facial feedback  which enable you to generate your feedback",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.purple[800], fontSize: 12),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/homee.jpg'))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.pushNamed(context, MyRoutes.registerRoute)
                          },
                      child: ("Register").text.makeCentered(),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)))),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          {Navigator.pushNamed(context, MyRoutes.loginRoute)},
                      child: ("Login").text.makeCentered(),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))))
                ])));
  }
}
