import 'package:flutter/material.dart';

roundedSubmitButtonWithIconAndText(IconData iconData, String text, Function function) {
  return MaterialButton(
      height: 45,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      color: Colors.teal,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData, size: 20, color: Colors.white),
            const SizedBox(width: 6),
            Text(text,
                style: const TextStyle(fontWeight: FontWeight.w500, letterSpacing: .5, color: Colors.white))
          ]),
      onPressed: () {
        function();
      }
  );
}

roundedSubmitButtonWithText(String text, Function function) {
  return MaterialButton(
      height: 45,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      color: Colors.teal,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500, letterSpacing: .5, color: Colors.white)),
      onPressed: () {
        function();
      }
  );
}