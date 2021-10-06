class Validations {
  static String? validateEmail(String value) {
    if (value.isEmpty) return 'Username is required.';
    //final RegExp nameExp = new RegExp(r'^[A-Za-z][A-Za-z0-9_]{7,29}$');

    final RegExp nameExp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value)) return 'Invalid username';
    return null;
    //return null;
    //return 'null';
  }

  static String? valdiatePassword(String value) {
    if (value.trim().isEmpty) return "Enter password";
    if (value.trim().length < 6)
      return "Password should be greater then 6 character.";
    return null;
    //return null;
    //return 'null';
  }

  static String? validateFullName(String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
    //return null;
    //return 'null';
  }

  // static String validateOTP(String value) {
  //   if (value.isEmpty) return 'OTP is required.';
  //   if (value.length != 6) return 'OTP has to be 6 digits';
  //   //return null;
  //   //return 'null';
  // }
}
