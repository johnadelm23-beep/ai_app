import 'package:flutter/material.dart';

class CustomTextFoemField extends StatefulWidget {
  const CustomTextFoemField({
    super.key,
    required this.text,
    this.obscureText = false,
    this.controller,
    this.validator,
  });

  final String text;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  @override
  State<CustomTextFoemField> createState() => _CustomTextFoemFieldState();
}

class _CustomTextFoemFieldState extends State<CustomTextFoemField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: .onUserInteraction,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.obscureText && isObscured,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                icon: isObscured
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : null,
        hintText: widget.text,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          // borderSide: const BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
