class CommonValidators {
  static String? validateMobile(String? value) {
    const String pattern = '^[0-9]{10}\$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static String? validateName(String? value, String? label) {
    if (value!.isEmpty) {
      return '$label cannot be empty';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    const String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (!regExp.hasMatch(value)) {
      return 'Must be 8+ chars, with upper, lower, number & special char';
    }
    return null;
  }
}
