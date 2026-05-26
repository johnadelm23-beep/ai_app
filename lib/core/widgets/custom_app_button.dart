import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        minimumSize: Size(double.infinity, 70),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: .bold),
      ),
    );
  }
}
