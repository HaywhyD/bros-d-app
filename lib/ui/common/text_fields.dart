import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ElectraTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? prefixText;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final int? maxLines;
  final AutovalidateMode? autovalidateMode;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String? helperText;
  final void Function()? onClickSuffixIcon;
  final bool obscureText;
  final String? labelText;
  final int? minLines;
  final TextAlign? textAlign;
  final TextStyle? errorStyle;
  final InputBorder? border;
  final String? initialValue;
  final EdgeInsetsGeometry? contentPadding;
  const ElectraTextField({
    this.controller,
    this.hint,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.prefixText,
    this.readOnly,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.onTap,
    this.maxLines,
    this.autovalidateMode,
    this.enabled,
    this.inputFormatters,
    this.errorText,
    this.helperText,
    this.onClickSuffixIcon,
    super.key,
    this.obscureText = false,
    this.labelText,
    this.minLines,
    this.textAlign,
    this.errorStyle,
    this.border,
    this.contentPadding,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) async {
        await SystemChannels.textInput.invokeMethod('TextInput.hide');
        if (context.mounted) {
          FocusScope.of(context).unfocus();
        }
      },
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.next,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hint,
        helperMaxLines: 2,
        helperStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.red,
              fontSize: 12,
            ),
        prefixText: prefixText,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15.0), // Adjusting padding to match the design
        filled: true,
        fillColor: Colors.white,
        enabledBorder: border ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 0.79992),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
        focusedBorder: border ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 0.79992),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
        border: border ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 0.79992),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
              fontSize: 14,
            ),
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 15,
            ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: suffixIcon!,
                onPressed: onClickSuffixIcon,
              )
            : null,
        suffix: suffix,
        errorStyle: errorStyle,
        prefixIcon: prefixIcon,
        errorText: errorText,
        helperText: helperText,
      ),
      obscureText: obscureText,
      inputFormatters: inputFormatters == null
          ? [LengthLimitingTextInputFormatter(maxLength)]
          : [LengthLimitingTextInputFormatter(maxLength), ...inputFormatters!],
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF002F49),
            fontSize: 14,
          ),
      readOnly: readOnly ?? false,
      onTap: onTap,
      maxLines: maxLines,
      minLines: minLines,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
