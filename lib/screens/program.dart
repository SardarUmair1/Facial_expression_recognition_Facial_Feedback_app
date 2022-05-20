import 'package:e_leaning/provider/courseprovider.dart';
import 'package:e_leaning/screens/course.dart';
import 'package:e_leaning/utils/routes.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Programscreen extends StatelessWidget {
  String value = "";
  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
        child: Column(
      children: [
        SizedBox(
          height: 80,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          "Select ".text.xl3.bold.black.makeCentered(),
          "Degree".text.xl3.bold.purple900.makeCentered(),
        ]),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: SizedBox(
            height: 300,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('programs')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: const Text("Loading..."));
                  // var OnTap =
                  //     Provider.of<Courseprovider>(context, listen: false);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String programfname =
                          snapshot.data!.docs[index]["ProgramFname"];
                      String programlname =
                          snapshot.data!.docs[index]["ProgramLname"];

                      String id = snapshot.data!.docs[index].id;
                      print(id);
                      return InkWell(
                        onTap: () => {
                          value = programfname + programlname,
                          print(value),
                          // OnTap.uiSetter(id),
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    Coursescreen(value: value)),
                          )
                          // Navigator.pushNamed(
                          //     context, MyRoutes.registercourseRoute),
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 90, vertical: 30),
                            padding: EdgeInsets.only(top: 33),
                            width: 242,
                            height: 87,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(children: [
                              "$programfname".text.black.bold.xl.makeCentered(),
                              "$programlname"
                                  .text
                                  .purple900
                                  .bold
                                  .xl
                                  .makeCentered(),
                            ])),
                      );
                    },
                  );
                }),
          ),
        ),
      ],
    ));
  }
}
