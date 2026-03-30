import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/values_manager.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final bool isHidden;
  final bool isPhone;
  final VoidCallback? toggleVisibility;
  final TextEditingController controller;

  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPhone = false,
    this.isPassword = false,
    this.isHidden = false,
    this.toggleVisibility,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isHidden : false,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isHidden ? Icons.visibility_off : Icons.visibility,
                  color: ColorManager.iconColor,
                ),
                onPressed: toggleVisibility,
              )
            : null,
        prefixIcon: isPhone
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddings.p4,
                ),
                child: CountryCodePicker(
                  mode: CountryCodePickerMode.dialog,
                  onChanged: (country) {
                    print('Country code selected: ${country.code}');
                  },
                  initialSelection: 'US',
                  showFlag: true,
                  showDropDownButton: true,
                ),
              )
            : null,
      ),
    );
  }
}
