
import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const PhoneNumberValidationError(this.message);
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  static final _phoneNumberRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  PhoneNumberValidationError? validator(String value) {
    return value.isEmpty
        ? PhoneNumberValidationError.required
        : _phoneNumberRegex.hasMatch(value)
        ? null
        : PhoneNumberValidationError.invalid;
  }
}