// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite/tflite.dart';
// import "package:flutter/material.dart";
// import 'package:image_picker/image_picker.dart';
// import 'package:velocity_x/velocity_x.dart';

// class TempFacialFeedbackScreen extends StatefulWidget {
//   const TempFacialFeedbackScreen({Key? key}) : super(key: key);

//   @override
//   State<TempFacialFeedbackScreen> createState() => _TempFacialFeedbackScreen();
// }

// class _TempFacialFeedbackScreen extends State<TempFacialFeedbackScreen> {
//   File? _pickedimage;
//   var _recognitions;

//   loadModel() async {
//     Tflite.close();
//     try {
//       String res;
//       res = (await Tflite.loadModel(
//         model: "assets/model.tflite",
//         labels: "assets/labels.txt",
//       ))!;
//       print(res);
//     } on PlatformException {
//       print("Failed to load model");
//     }
//   }

//   Future predict(File image) async {
//     var recognition = await Tflite.runModelOnImage(
//         path: image.path,
//         imageMean: 0.0,
//         imageStd: 255.0,
//         numResults: 2,
//         threshold: 0.2,
//         asynch: true);
//     print(recognition);

//     setState(() {
//       _recognitions = recognition;
//     });
//   }

//   final picker = ImagePicker();
//   Future _cameraimage() async {
//     final pickedimage = await picker.pickImage(source: ImageSource.camera);
//     setState(() {
//       if (pickedimage != null) {
//         _pickedimage = File(pickedimage.path);
//       } else {
//         print("No image Selected");
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadModel().then((val) {
//       setState(() {});
//     });
//   }

//   Widget printValue(var rcg) {
//     if (rcg == null) {
//       return "".text.xl.make();
//     } else if (rcg.isEmpty) {
//       return "Could not recognize".text.xs.makeCentered();
//     }
//     return Padding(
//       padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//       child: Center(
//         child: Text(
//           "Prediction :" + _recognitions[0]['label'].toString().toUpperCase(),
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Column(children: [
//         SizedBox(
//           height: 40,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             "CAM ".text.black.bold.xl3.make(),
//             "Feed".text.xl3.bold.black.make(),
//             "back".text.xl3.bold.green300.bold.make(),
//           ],
//         ),
//         SizedBox(
//           height: 40,
//         ),
//         CircleAvatar(
//           radius: 90.0,
//           backgroundColor: Colors.white,
//           backgroundImage: _pickedimage == null
//               ? AssetImage("assets/images/faceicon.png")
//               : FileImage(_pickedimage!) as ImageProvider,
//         ),
//         SizedBox(height: 40),
//         Container(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             height: 34,
//             width: 250,
//             decoration: BoxDecoration(
//                 color: Colors.grey[350],
//                 borderRadius: BorderRadius.circular(20.0)),
//             child: TextFormField(
//               readOnly: true,
//             )),
//         SizedBox(height: 40),
//         InkWell(
//           onTap: () {
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     // printValue(_recognitions),
//                     title: "Select Camera".text.black.make(),
//                     content: SingleChildScrollView(
//                       child: ListBody(
//                         children: [
//                           printValue(_recognitions),
                          
//                           InkWell(
//                             onTap: _cameraimage,
//                             child: Row(children: [
//                               Icon(
//                                 Icons.camera,
//                               ),
//                               "Camera".text.bold.make(),
//                             ]),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//           },
          
//           child: Container(
//             height: 30,
//             width: 112,
//             decoration: BoxDecoration(
//               color: Colors.green[200],
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: "Scan my face".text.makeCentered(),
//           ),
//         )
//       ]),
//     );
//   }
// }