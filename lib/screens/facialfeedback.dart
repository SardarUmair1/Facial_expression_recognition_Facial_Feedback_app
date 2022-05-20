import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class FacialFeedbackScreen extends StatefulWidget {
  //const FacialFeedbackScreen({Key? key}) : super(key: key);
  final doc;
  FacialFeedbackScreen(this.doc);
  @override
  State<FacialFeedbackScreen> createState() => _FacialFeedbackScreenState();
}

class _FacialFeedbackScreenState extends State<FacialFeedbackScreen> {
  File? _pickedimage;

  final picker = ImagePicker();
  Future _cameraimage() async {
    final pickedimage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedimage != null) {
        _pickedimage = File(pickedimage.path);
      } else {
        print("No image Selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        SizedBox(
          height: 40,
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: 34,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(20.0)),
            child: TextField(
              readOnly: true,
            )),
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
              color: Colors.green[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: "Scan my face".text.makeCentered(),
          ),
        )
      ]),
    );
  }
}
