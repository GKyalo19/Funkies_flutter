import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget<T> extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.prefixIcon,
    required this.textController,
    required this.obscureText,
    this.keyboardType,
    required this.hintText, 
    this.length,
    this.inputFormat,
    required this.validator,
    
  });

  final TextEditingController textController;
  final TextInputType? keyboardType;
  final String hintText;
  final int? length;
  final List <TextInputFormatter>?inputFormat;
  final FormFieldValidator<String?> validator;
  final Icon? prefixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        child: TextFormField(
          obscureText: obscureText,
          maxLength: length,
          controller: textController,
          keyboardType: keyboardType,
          inputFormatters: inputFormat,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: const OutlineInputBorder(
              
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
          ),
          validator: validator,
          onSaved: (value){
            textController.text = value!;
          },
        ),
      ),
    );
  }
}



class DropdownButtonFormFieldWidget<T> extends StatelessWidget {
  const DropdownButtonFormFieldWidget({
    super.key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.validationText,
  });

  final String hintText;
  final T? value;
  final String validationText;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T?>>? items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T?>(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
      ),
      value: value,
      items: items,
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return validationText;
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}

// class DateTimePickerWidget extends StatefulWidget {
//   const DateTimePickerWidget({super.key, required this.childWidget});

//   @override
//   State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
// }

// class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {

  
//   final Widget childWidget;
//   DateTime dateTime = DateTime(3000, 2, 1, 10, 20);

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoButton(
//       onPressed: onPressed,
//       child: childWidget, 
//     );
//   }
// }