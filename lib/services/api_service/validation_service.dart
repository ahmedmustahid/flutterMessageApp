class Validations {
  static String? validateUsername(String value) {
    if (value.isEmpty) return 'Username is required.';
    final RegExp nameExp = new RegExp(
        r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');
    //final RegExp nameExp = new RegExp(
    //    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value)) return 'Invalid email address';
  }

  static String? valdiatePassword(String value) {
    if (value.trim().isEmpty) return "Enter password";
    if (value.trim().length < 8)
      return "Password should be greater then 8 character.";
  }
}
