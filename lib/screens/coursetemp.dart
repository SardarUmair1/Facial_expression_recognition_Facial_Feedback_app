import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_leaning/provider/courseprovider.dart';
import 'package:e_leaning/screens/feedback.dart';
import 'package:e_leaning/screens/tempcam.dart';
import 'package:e_leaning/utils/routes.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Coursetemp extends StatelessWidget {
  final doc;
  Coursetemp(this.doc);
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        SizedBox(
          height: 80,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          "Select ".text.xl3.bold.bold.black.makeCentered(),
          "Course".text.xl3.bold.fuchsia800.bold.makeCentered(),
        ]),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: SizedBox(
            height: 300,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('programcollection')
                    .doc(doc)
                    .collection('coursecollection')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: const Text("Loading..."));

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String course = snapshot.data!.docs[index]["coursename"];
                      String credit = snapshot.data!.docs[index]["credithour"];
                      int like_counter =
                          snapshot.data!.docs[index]["likecount"];
                      int dis_counter =
                          snapshot.data!.docs[index]["dislikecount"];
                      return InkWell(
                        onTap: () => {
                          // OnTap.uiSetter(id),

                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => TempFacialFeedbackScreen(
                                    snapshot.data!.docs[index].id,
                                    like_counter,
                                    dis_counter)),
                          )
                          
                        
                          // Navigator.pushNamed(context, MyRoutes.feedabackRoute),
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 90, vertical: 30),
                            padding:
                                EdgeInsets.only(top: 25, left: 15, right: 1),
                            width: 350,
                            height: 100,
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
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 1),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          "$like_counter"
                                              .text
                                              .xl
                                              .black
                                              .bold
                                              .make(),

                                          Icon(Icons.thumb_up),
                                          SizedBox(width: 10),
                                          "$dis_counter"
                                              .text
                                              .xl
                                              .black
                                              .bold
                                              .make(),
                                          Icon(Icons.thumb_down),
                                          SizedBox(width: 10),
                                          // Icon(Icons.check_circle),
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