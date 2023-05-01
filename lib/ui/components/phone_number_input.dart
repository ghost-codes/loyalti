import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loyalty/utils/colors.dart';
import 'package:loyalty/utils/typography.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    required this.onChanged,
  });

  final Function(PhoneNumber number) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InternationalPhoneNumberInput(
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        useEmoji: true,
      ),
      selectorTextStyle: theme.textTheme.labelLarge,
      formatInput: true,
      onInputValidated: (v) {},
      spaceBetweenSelectorAndTextField: 5,
      initialValue: PhoneNumber(isoCode: "GH"),
      inputDecoration: InputDecoration(
        hintText: "eg. 244444444",
        hintStyle: theme.textTheme.bodyMedium,
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        filled: true,
        fillColor: LoyaltiColor.offWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      ),

      textStyle: LoyaltiTypography.bodyText(color: LoyaltiColor.primary),
      // initialValue: PhoneNumber(dialCode: "+233", isoCode: "+233"),
      onInputChanged: onChanged,
      onSaved: (value) => onChanged(value),
    );
  }
}
