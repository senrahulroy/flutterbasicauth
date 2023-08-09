import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyBoardType;
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputTextFormater;
  final ValueChanged<String>? onChanged;

  const CustomInputTextField(
      {Key? key,
      this.controller,
      this.focusNode,
      required this.labelText,
      this.prefixIcon,
      this.obscureText = false,
      this.keyBoardType,
      this.inputTextFormater,
      this.validator,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyBoardType,
      validator: validator,
      inputFormatters: inputTextFormater,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: const OutlineInputBorder(),

        ///When error is shown
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),

        ///When error is shown and text field is selected
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
