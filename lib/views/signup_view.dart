import 'package:flutter/material.dart';
import 'package:newzzie/helper/password_validation_form.dart';
import 'package:newzzie/helper/widgets.dart';
import 'package:newzzie/services/auth_service.dart';
import 'package:newzzie/views/login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  AuthService _authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(true),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // logo of the app
              Image.asset(
                'assets/icons/news_icon.png',
                height: 200,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: repPassController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
              Row(children: [
                Expanded(
                  child: Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Signup'),
                        onPressed: () async {
                          if (passwordController.text ==
                              repPassController.text) {
                            var user =
                                await _authService.registerWithEmailAndPassword(
                                    emailController.text.trim(),
                                    passwordController.text.trim());
                            print(user);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()));
                          } else {
                            print('password does not match');
                          }
                        },
                      )),
                ),
              ]),
              PasswordForm(),
              Row(
                children: <Widget>[
                  const Text('Already have account?'),
                  TextButton(
                    child: const Text(
                      'signin now!',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ));
  }
}
