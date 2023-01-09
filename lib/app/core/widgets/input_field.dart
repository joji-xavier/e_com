import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final bool isHidden;
  final Widget? icon;
  final String? title;
  final Color? hintColor;
  final Color? color;
  final int? maxline;
  final String hint;
  final bool isRequired;
  final double? border;
  final bool? autofocus;
  final TextEditingController controller;
  final bool readOnly;
  final int? maxlength;
  final TextInputType keyboardType;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  const InputField({
    Key? key,
    required this.isHidden,
    this.icon,
    this.title,
    this.hintColor,
    this.color,
    this.maxline,
    required this.hint,
    required this.isRequired,
    this.border,
    this.autofocus,
    required this.controller,
    required this.readOnly,
    this.maxlength,
    required this.keyboardType,
    this.onSaved,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: title != null
              ? Row(
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    isRequired
                        ? Text(
                            '*',
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox()
                  ],
                )
              : Text(''),
        ),
        title != null
            ? SizedBox(
                height: 5,
              )
            : SizedBox(),
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          height: maxline != null ? 150 : 75,
          child: TextFormField(
            autofocus: autofocus ?? false,
            validator: validator,
            onChanged: onChanged,
            onSaved: onSaved,
            maxLength: maxlength,
            obscureText: isHidden,
            controller: controller,
            readOnly: readOnly,
            maxLines: maxline ?? 1,
            keyboardType: keyboardType,
            cursorColor: Color(0xff222222),
            decoration: InputDecoration(
              helperText: '',
              fillColor: const Color(0xfff2f2f2),
              filled: true,
              prefixIcon: icon,
              prefixIconColor: Color(0xff655F74),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: color ?? const Color.fromARGB(255, 236, 20, 20),
                      width: 1.0),
                  borderRadius: BorderRadius.circular(border ?? 25)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: color ?? const Color.fromARGB(255, 236, 20, 20),
                      width: 1.0),
                  borderRadius: BorderRadius.circular(border ?? 25)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: color ?? const Color(0xff222222), width: 1.0),
                  borderRadius: BorderRadius.circular(border ?? 25)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(border ?? 25),
                borderSide: BorderSide(
                    color: color ?? const Color(0xff222222), width: 1.0),
              ),
              hintText: hint,
              hintStyle:
                  TextStyle(color: hintColor ?? Colors.black.withOpacity(0.3)),
            ),
          ),
        ),
      ],
    );
  }
}
