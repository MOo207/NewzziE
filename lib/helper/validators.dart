class Validators {
  Validators();
  static bool isEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
  static bool isPassword(String password) {
    return password.length >= 6;
  }
  emailValidation(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  passwordValidation(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!isPassword(value)) {
      return 'Please enter a valid password';
    }
    return null;
  }
}