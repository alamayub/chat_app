import 'package:flutter/material.dart';

class TextFormInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget prefixIcon;
  const TextFormInputField({ Key? key, required this.controller, required this.hint, this.obscure = false, this.prefixIcon = const SizedBox()}) : super(key: key);

  @override
  State<TextFormInputField> createState() => _TextFormInputFieldState();
}

class _TextFormInputFieldState extends State<TextFormInputField> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscure == true ? visible : false,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscure == true ? GestureDetector(
            onTap: () {
              setState(() => visible = !visible);
            },
            child: Icon(visible == true ? Icons.visibility_off : Icons.visibility, size: 18, color: Colors.grey),
          ) : const SizedBox(),
          hintText: widget.hint,
          isDense: true,
          filled: true,
          border: formOutlineInputBorder(),
          focusedBorder: formOutlineInputBorder(),
          enabledBorder: formOutlineInputBorder(),
          disabledBorder: formOutlineInputBorder(),
          errorBorder: formOutlineInputBorder(),
          focusedErrorBorder: formOutlineInputBorder()),
    );
  }
}

formOutlineInputBorder() {
  return const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(30)));
}