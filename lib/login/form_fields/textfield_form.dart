import 'package:flutter/material.dart';

class TextFieldForm extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String label;
  final IconData icon;
  final TextEditingController textEditingController;
  final int? maxLines;
  final bool isSocial;

  const TextFieldForm(
      {Key? key,
      required this.label,
      required this.icon,
      required this.textEditingController,
      this.validator,
      this.keyboardType,
      this.isSocial = false,
      this.maxLines = 1})
      : super(key: key);

  @override
  State<TextFieldForm> createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      validator: widget.validator,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(fontWeight: FontWeight.w500),
      keyboardType: widget.keyboardType,
      maxLength: widget.keyboardType == TextInputType.phone ? 10 : null,
      controller: widget.textEditingController,
      decoration: InputDecoration(
          filled: true,
          counter: SizedBox(),
          prefixText: widget.keyboardType == TextInputType.phone
              ? "+91 "
              : widget.isSocial
                  ? "@"
                  : null,
          labelText: widget.label,
          prefixIcon: Icon(
            widget.icon,
            size: Theme.of(context).textTheme.subtitle1?.fontSize,
          )),
    );
  }
}
