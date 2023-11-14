
import 'package:formz/formz.dart';

enum PhoneNumberConfirmValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const PhoneNumberConfirmValidationError(this.message);
}

class PhoneNumberConfirm extends FormzInput<String, PhoneNumberConfirmValidationError> {
  const PhoneNumberConfirm.pure() : super.pure('');
  const PhoneNumberConfirm.dirty([String value = '']) : super.dirty(value);

  static final _phoneNumberConfirmRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  PhoneNumberConfirmValidationError? validator(String value) {
    return value.isEmpty
        ? PhoneNumberConfirmValidationError.required
        : _phoneNumberConfirmRegex.hasMatch(value)
        ? null
        : PhoneNumberConfirmValidationError.invalid;
  }
}