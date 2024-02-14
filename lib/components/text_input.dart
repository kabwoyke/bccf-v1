import 'package:flutter/material.dart';
class TextInput extends StatelessWidget {
  TextInput({super.key , this.labelText , this.icon , this.onSave ,this.iconColor , this.onChanged , this.obsecureText = false });
  String? labelText;
  IconData? icon;
  bool obsecureText;
  Function(String? Value)? onSave;
  Color? iconColor = Colors.grey.shade700;
  String? Function(String? text)? onChanged;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: onChanged,
      onSaved: onSave,
      obscureText: obsecureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
          labelText: labelText,
          prefixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Icon(icon , color: iconColor,),
          )
      ),

    );
  }
}
