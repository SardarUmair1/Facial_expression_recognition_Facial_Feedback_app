import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_leaning/provider/courseprovider.dart';
import 'package:e_leaning/screens/feedback.dart';
import 'package:e_leaning/utils/routes.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Coursescreen extends StatelessWidget {
  String value;
  Coursescreen({required this.value});
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        SizedBox(
          height: 80,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          "Select ".text.xl3.bold.black.makeCentered(),
          "Course".text.xl3.bold.purple900.bold.makeCentered(),
        ]),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: SizedBox(
            height: 300,
            child: StreamBuilder(
                stream: value == "ComputerScience"
                    ? FirebaseFirestore.instance
                        .collection('computerscience')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('cybersecurity')
                        .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: const Text("Loading..."));

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String course = snapshot.data!.docs[index]["coursename"];
                      String credit = snapshot.data!.docs[index]["credithour"];

                      return InkWell(
                        onTap: () => {
                          // OnTap.uiSetter(id),

                          print(value),
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           Feedbackscreen(value: value)),
                          // )
                          Navigator.pushNamed(context, MyRoutes.feedabackRoute),
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 90, vertical: 30),
                            padding:
                                EdgeInsets.only(top: 25, left: 15, right: 15),
                            width: 300,
                            height: 87,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "$course".text.black.xs.bold.make(),
                                  "$credit Credit hour"
                                      .text
                                      .fuchsia800
                                      .xs
                                      .bold
                                      .make(),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 100),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle),
                                        ],
                                      ),
                                    ),
                                  )
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

// StreamBuilder(
//                 stream: stream,
//                 builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) return const Text("Loading...");
                  
//                   return ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         String coursename =
//                             snapshot.data!.documents[index]["Course Name"];
//                         String credithour =
//                             snapshot.data!.docs[index]["Credit Hour"];
//                         return Container(
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: 90, vertical: 30),
//                             padding: EdgeInsets.only(top: 33),
//                             width: 242,
//                             height: 87,
//                             color: Colors.none,
//                             child: ListTile(
//                               contentPadding: EdgeInsets.only(
//                                   left: 32, right: 32, top: 8, bottom: 8),
//                               title: "$coursename".text.xl.make(),
//                               subtitle: "$credithour".text.xs.make(),
//                               trailing: Icon(Icons.check_circle),
//                             ));
//                       });
//                 })