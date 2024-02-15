import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {super.key,
      this.labelText,
      this.icon,
      this.onSave,
      this.iconColor,
      this.onChanged,
      this.obsecureText = false,
      this.maxlines
      });
  String? labelText;
  IconData? icon;
  bool obsecureText;
  Function(String? Value)? onSave;
  Color? iconColor = Colors.grey.shade700;
  String? Function(String? text)? onChanged;
  final int? maxlines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onChanged,
      onSaved: onSave,
      obscureText: obsecureText,
      maxLines: maxlines,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16)
          ),
          textAlign: TextAlign.start,
    );
  }
}
