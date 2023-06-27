import 'package:epharmacyapp/pages/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../services/authservice.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
     AuthServices _authServices = AuthServices();
    final GlobalKey _formKey = GlobalKey<FormState>();
    String _email = "";
    String _password = "";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(
                  height: 32,
                ),
                Center(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  // child: Image.asset("assets/pills.jpg"),
                )),
                SizedBox(
                  height: 32,
                ),
                TextFormField(
                  enableSuggestions: true,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => _email = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'email:',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                    ),
                    alignLabelWithHint: true,
                  ),
                  validator: ((value) {
                    if (value!.isEmpty || !value.contains("@")) {
                      return "Invalid email address";
                    }
                    return null;
                  }),
                ),
                SizedBox(
                  height: 32,
                ),
                TextFormField(
                  enableSuggestions: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => _password = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Password:',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(
                      Icons.password_outlined,
                      color: Colors.black,
                    ),
                    alignLabelWithHint: true,
                  ),
                  validator: ((value) {
                    if (value!.isEmpty || value.length < 6) {
                      return "Password too short";
                    }
                    return null;
                  }),
                ),
                Divider(
                  thickness: 2,
                ),
                Center(
                    child: GestureDetector(
                      
                        onTap: () {
                          
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                              (route) => false);
                        },
                        child: Text(
                          "Already have Account? signIn",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ))),
                SizedBox(
                  height: 50,
                  width: 300,
                ),
                ElevatedButton(onPressed: () {
                  _authServices.signUpWithEmailAndPassword(
                              _email.trim(), _password.trim(), context);
                  Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                              (route) => false);
                }, child: Text("Register")),
              ])),
        ),
      ),
    );
  }
}
