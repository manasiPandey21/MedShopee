import 'package:epharmacyapp/pages/loading.dart';
import 'package:epharmacyapp/pages/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../controllers/authcontroller.dart';
import '../services/authservice.dart';
class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  signUpWithEmailAndPassword(
      BuildContext context, WidgetRef ref, String email, String password) {
    ref
        .read(authControllerProvider.notifier)
        .signUpWithEmailAndPassword(context, email, password);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return isLoading
        ? const LoadingScreen()
        : Scaffold(
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
                  child: Lottie.network(
                    "https://assets8.lottiefiles.com/packages/lf20_9rqvb0dk.json",
                     height: 200,
                      width: 200, 
                      fit: BoxFit.fill,

                  )
                )),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
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
                        color: Colors.teal.shade300,
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
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
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
                       color: Colors.teal.shade300,
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
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: GestureDetector(
                      
                        onTap: () {
                          
                           Navigator.push(context, MaterialPageRoute(builder: (context) =>SignIn()));
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(onPressed: () {
                     signUpWithEmailAndPassword(
                                context, ref, _email.trim(), _password.trim());
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>SignIn()));
                  },
                  style:ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade300,shadowColor: Colors.grey,elevation: 5),
                   child: Text("Register")),
                ),
              ])),
        ),
      ),
    );
  }
}
