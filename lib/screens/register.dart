import 'package:e_leaning/utils/routes.dart';
import "package:flutter/material.dart";
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registerscreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String registration_id = "";
  //String email = "";
  signup(BuildContext context) async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email, password: registration_id);
        Navigator.pushNamed(context, MyRoutes.loginRoute);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              "Ready To Get ".text.xl2.purple900.bold.make(),
              "Started?".text.xl2.purple900.bold.make(),
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/RegistrationImage.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 40,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: "Air University".text.xl.blue900.bold.make()),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "University Email",
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    validator: (value) {
                      _email = value!;
                      if (value.isEmpty) {
                        return "Email cannot be empty";
                      } else if (value.length < 3) {
                        return "Email length should be greater than 2";
                      } else {
                        return null;
                      }
                    }),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Registration Id",
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    registration_id = value!;
                    if (value.isEmpty) {
                      return "Registration Id cannot be empty";
                    } else if (value.length < 6) {
                      return "Registration Id length should be  6";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => signup(context),
                child: Container(
                  height: 30,
                  width: 112,
                  decoration: BoxDecoration(
                    color: Colors.purple[800],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: "Register".text.white.makeCentered(),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ));
  }
}
