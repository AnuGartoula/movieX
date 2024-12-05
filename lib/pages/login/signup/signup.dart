import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/firebase_auth.dart';
import 'package:movie_app/pages/login/signup/login.dart';

final _formkey = GlobalKey<FormState>();

class MySignup extends StatefulWidget {
  const MySignup({super.key});

  @override
  State<MySignup> createState() => _MySignupState();
}

bool passwordVisible = true;
// bool confirmPasswordVisible = true;

String? validateEmail(String? email) {
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final isEmailValidate = emailRegex.hasMatch(email ?? '');
  if (!isEmailValidate) {
    return "Please enter a valid E- mail";
  }
  return null;
}

class _MySignupState extends State<MySignup> {
  final FirebaeAuthServices auth = FirebaeAuthServices();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //overflow error
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "SIGN UP",
                style: TextStyle(
                    color: Colors.red[300],
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formkey,
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    hintText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: passwordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
              const SizedBox(
                height: 15,
              ),
              // TextField(
              //   obscureText: confirmPasswordVisible,
              //   decoration: InputDecoration(
              //       contentPadding: const EdgeInsets.all(15),
              //       hintText: "Confirm Password",
              //       suffixIcon: IconButton(
              //           onPressed: () {
              //             setState(() {
              //               confirmPasswordVisible = !confirmPasswordVisible;
              //             });
              //           },
              //           icon: confirmPasswordVisible
              //               ? const Icon(Icons.visibility_off)
              //               : const Icon(Icons.visibility)),
              //       border: const OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(15)))),
              // ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          signup();
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ))),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account?",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: Text("Login",
                          style: TextStyle(color: Colors.blue[500])))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void signup() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    try {
      User? user = await auth.signupwithEmailAndPassword(email, password);

      if (user != null) {
        print("User is Successfully Created : ${user.email}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Signup Successful! Please log in."),
          ),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Show a snackbar for email already in use
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This email is already in use. Please try another."),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print("error creating user");
      }
    }
  }
}
