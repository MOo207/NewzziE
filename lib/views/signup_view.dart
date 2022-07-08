import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
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
  final passwordController = FancyPasswordController();
  String password;
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
                child: FancyPasswordField(
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  hasValidationRules: true,
                  hasStrengthIndicator: true,
                  validationRules: {
                    UppercaseValidationRule(),
                    MinCharactersValidationRule(8),
                    LowercaseValidationRule(),
                    DigitValidationRule(),
                  },
                  validationRuleBuilder: (rules, value) {
                    if (value.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Wrap(
                      children: rules
                          .map(
                            (e) => e.validate(value)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check,
                                          size: 10.0,
                                          color: Colors.green.shade800,
                                        ),
                                        const SizedBox(width: 10.0),
                                        Text(
                                          e.name,
                                          style: TextStyle(
                                              color: Colors.green.shade800),
                                        )
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.close,
                                          size: 10.0,
                                          color: Colors.red.shade800,
                                        ),
                                        const SizedBox(width: 10.0),
                                        Text(
                                          e.name,
                                          style: TextStyle(
                                              color: Colors.red.shade800),
                                        )
                                      ],
                                    ),
                                  ),
                          )
                          .toList(),
                    );
                  },
                  onChanged: (String text) {
                    password = text;
                    if (passwordController.areAllRulesValidated) {}
                  },
                  style: TextStyle(),
                  obscureText: true,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: repPassController,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (String passwordConfirmation) {
                    if (passwordConfirmation == null ||
                        passwordConfirmation.isEmpty) {
                      return "Please re-enter the same password as above";
                    }
                    bool passwordConfirmed = password == passwordConfirmation;
                    return (passwordConfirmed)
                        ? null
                        : 'Passwords do not match';
                  },
                  style: TextStyle(),
                  obscureText: true,
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
                          print(password);
                          print(repPassController.text);
                          if (password.trim() == repPassController.text.trim()) {
                            var user =
                                await _authService.registerWithEmailAndPassword(
                                    emailController.text.trim(),
                                    password.trim());
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
