import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_leaning/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class TempFacialFeedbackScreenLast extends StatefulWidget {
  TempFacialFeedbackScreenLast();

  @override
  State<TempFacialFeedbackScreenLast> createState() =>
      _TempFacialFeedbackScreenLast();
}

class _TempFacialFeedbackScreenLast
    extends State<TempFacialFeedbackScreenLast> {
  File? _pickedimage;
  Map result = Map();
  var _recognitions;
  late double _imageWidth;
  late double _imageHeight;
  int fear_rate = -3;
  int angry_rate = -5;
  int sad_rate = -1;
  int happy_rate = 3;
  int surprise_rate = 5;
  int disgust_rate = -4;
  int neutral_rate = 0;

  String surprisefeedback = "My experience so far has been fantastic!";
  String neutralfeedback = "The course is ok I guess";
  String angryfeedback = "The course team is very useless ";
  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = (await Tflite.loadModel(
        model: "assets/model_01.tflite",
        labels: "assets/labels.txt",
      ))!;
      print(res);
    } on PlatformException {
      print("Failed to load model");
    }
  }

  Future predict(File image) async {
    var recognition = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    print(recognition);

    setState(() {
      _recognitions = recognition;
    });
  }

  sendImage(File image) async {
    if (image == null) return;
    await predict(image);

    // get the width and height of selected image
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
            _pickedimage = image;
          });
        })));
  }

  // void updatecount() {
  //   FirebaseFirestore.instance
  //       .collection('programcollection')
  //       .doc()
  //       .collection('coursecollection')
  //       .doc()
  //       .update(
  //     {"likecount": like_counter, "dislikecount": dis_counter},
  //   ).then((value) {
  //     print("Feedback successfull");
  //   });
  //   Navigator.pushNamed(context, MyRoutes.TempProgram);
  // }

  final picker = ImagePicker();
  Future _cameraimage() async {
    final pickedimage = (await picker.pickImage(source: ImageSource.camera));

    setState(() {
      if (pickedimage != null) {
        _pickedimage = File(pickedimage.path);
      } else {
        print("No image Selected");
      }
    });
    File fileimage = File(pickedimage!.path);
    sendImage(fileimage);
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((val) {
      setState(() {});
    });
  }

  Widget printValue(var rcg) {
    if (rcg == null) {
      return "".text.xl.make();
    } else if (rcg.isEmpty) {
      return "Could not recognize".text.xs.makeCentered();
    } else if (_recognitions[0]['label'] == "fear") {
      return Column(children: [
        "$fear_rate".text.bold.red700.xl4.makeCentered(),
        SizedBox(height: 5),
        "$angryfeedback".text.xl2.bold.makeCentered(),
        SizedBox(height: 5),
        Container(
          height: 30,
          width: 85,
          // decoration: BoxDecoration(color: Colors.red[50]),
          child: "NEGATIVE".text.bold.red700.xl.makeCentered(),
        )
      ]);
    } else if (_recognitions[0]['label'] == "surprise") {
      return Column(children: [
        "$surprise_rate".text.red700.bold.xl4.makeCentered(),
        SizedBox(height: 5),
        "$surprisefeedback".text.bold.xl2.makeCentered(),
        SizedBox(height: 5),
        Container(
          height: 30,
          width: 85,
          // decoration: BoxDecoration(color: Colors.red[50]),
          child: "POSITIVE".text.bold.red700.xl.makeCentered(),
        ),
      ]);
    } else if (_recognitions[0]['label'] == "happy") {
      return Column(children: [
        "$happy_rate".text.bold.green700.xl4.makeCentered(),
        SizedBox(height: 5),
        "$surprisefeedback".text.bold.xl2.makeCentered(),
        SizedBox(height: 5),
        Container(
          height: 30,
          width: 85,
          //decoration: BoxDecoration(color: Colors.green[50]),
          child: "POSTIVE".text.bold.green700.xl.makeCentered(),
        ),
      ]);
    } else if (_recognitions[0]['label'] == "neutral") {
      return Column(children: [
        "$neutral_rate".text.bold.yellow700.xl4.makeCentered(),
        SizedBox(height: 5),
        "$neutralfeedback".text.bold.xl2.makeCentered(),
        SizedBox(height: 5),
        Container(
          height: 35,
          width: 80,
          //decoration: BoxDecoration(color: Colors.red[50]),
          child: "NEUTRAL".text.bold.yellow200.xl.makeCentered(),
        ),
      ]);
    } else if (_recognitions[0]['label'] == "disgust") {
      return Column(children: [
        "$disgust_rate".text.red700.bold.xl4.makeCentered(),
        SizedBox(height: 5),
        "$angryfeedback".text.bold.xl2.makeCentered(),
        SizedBox(height: 5),
        Container(
          height: 30,
          width: 85,
          //decoration: BoxDecoration(color: Colors.red[50]),
          child: "NEGATIVE".text.bold.red700.xl.makeCentered(),
        ),
      ]);
    } else if (_recognitions[0]['label'] == "angry") {
      return Column(children: [
        "$angry_rate".text.red700.bold.xl4.makeCentered(),
        SizedBox(height: 5),
        "$angryfeedback".text.xl2.bold.makeCentered(),
        SizedBox(height: 5),
        Container(
          height: 30,
          width: 85,
          //decoration: BoxDecoration(color: Colors.red[50]),
          child: "NEGATIVE".text.bold.red700.xl.makeCentered(),
        ),
      ]);
    } else if (_recognitions[0]['label'] == "sad") {
      return Column(children: [
        "$sad_rate".text.red700.bold.xl4.makeCentered(),
        SizedBox(height: 5),
        "$angryfeedback".text.bold.xl2.makeCentered(),
        SizedBox(height: 5),
        Container(
          height: 30,
          width: 85,
          // decoration: BoxDecoration(color: Colors.red[50]),
          child: "NEGATIVE".text.bold.red700.xl.makeCentered(),
        ),
      ]);
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Center(
        child: Text(
          "Prediction :" + _recognitions[0]['label'].toString().toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        SizedBox(
          height: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "CAM ".text.black.bold.xl3.make(),
            "Feed".text.xl3.bold.black.make(),
            "back".text.xl3.bold.green300.bold.make(),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        CircleAvatar(
          radius: 90.0,
          backgroundColor: Colors.white,
          backgroundImage: _pickedimage == null
              ? AssetImage("assets/images/faceicon.png")
              : FileImage(_pickedimage!) as ImageProvider,
        ),
        SizedBox(height: 40),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: 180,
            width: 190,
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(children: [
              printValue(_recognitions),
            ])),
        SizedBox(height: 40),
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: "Select Camera".text.black.make(),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          InkWell(
                            onTap: _cameraimage,
                            child: Row(children: [
                              Icon(
                                Icons.camera,
                              ),
                              "Camera".text.bold.make(),
                            ]),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
            height: 30,
            width: 112,
            decoration: BoxDecoration(
              color: Colors.purple[800],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: "Scan my face".text.makeCentered(),
          ),
        ),
        SizedBox(height: 40),
        InkWell(
          onTap: () => {
            Navigator.pushNamed(context, MyRoutes.registerprogramRoute),
          },
          child: Container(
            height: 30,
            width: 112,
            decoration: BoxDecoration(
              color: Colors.purple[800],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: "Done".text.makeCentered(),
          ),
        ),
      ]),
    );
  }
}
