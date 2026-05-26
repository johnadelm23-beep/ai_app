class AppValidator {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Must be at least 8 characters";
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Add at least 1 uppercase letter";
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Add at least 1 lowercase letter";
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Add at least 1 number";
    }

    if (!RegExp(r'[!@#\$&*~%^()_\-+=<>?]').hasMatch(value)) {
      return "Add at least 1 special character";
    }

    const weakPasswords = [
      "12345678",
      "password",
      "qwerty",
      "11111111",
      "00000000",
    ];

    if (weakPasswords.contains(value.toLowerCase())) {
      return "Password is too weak";
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm your password";
    }

    if (value != password) {
      return "Passwords do not match";
    }

    return null;
  }

  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }

    if (value.trim().length < 3) {
      return "Name is too short";
    }

    return null;
  }
}
