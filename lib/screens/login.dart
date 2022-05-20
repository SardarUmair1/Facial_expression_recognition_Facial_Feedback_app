import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:velocity_x/velocity_x.dart';
import 'package:e_leaning/utils/routes.dart';

class Loginscreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String password = "";

  signin(BuildContext context) async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: password);
        Navigator.pushNamed(context, MyRoutes.registerprogramRoute);
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
                height: 30,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email",
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      } else if (value.length < 9) {
                        return "Email length should be greater than 9";
                      } else {
                        _email = value;
                      }
                    }),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password cannot be empty";
                      } else if (value.length < 6) {
                        return "Password length should be greater than 6";
                      } else {
                        password = value;
                      }
                    }),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => signin(context),
                child: Container(
                  height: 30,
                  width: 112,
                  decoration: BoxDecoration(
                    color: Colors.purple[800],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: "Login".text.white.makeCentered(),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
