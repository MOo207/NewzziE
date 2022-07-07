import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';

class PasswordForm extends StatelessWidget {
  PasswordForm({Key key, this.showValidation = true}) : super(key: key);
  final passwordController = FancyPasswordController();
  String password;
  final confPassController = TextEditingController();
  final bool showValidation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          FancyPasswordField(
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
            ),
            hasValidationRules: showValidation,
            hasStrengthIndicator: showValidation,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                    style:
                                        TextStyle(color: Colors.green.shade800),
                                  )
                                ],
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                    style:
                                        TextStyle(color: Colors.red.shade800),
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
              if (passwordController.areAllRulesValidated) {
                  
              }
            },
            style: TextStyle(),
            obscureText: true,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: "",
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
              return (passwordConfirmed) ? null : 'Passwords do not match';
            },
            style: TextStyle(),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
