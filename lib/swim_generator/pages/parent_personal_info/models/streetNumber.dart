
import 'package:formz/formz.dart';

enum StreetNumberValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const StreetNumberValidationError(this.message);
}

class StreetNumber extends FormzInput<String, StreetNumberValidationError> {
  const StreetNumber.pure() : super.pure('');
  const StreetNumber.dirty([String value = '']) : super.dirty(value);

  static final _streetNumberRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  StreetNumberValidationError? validator(String value) {
    return value.isEmpty
        ? StreetNumberValidationError.required
        : _streetNumberRegex.hasMatch(value)
        ? null
        : StreetNumberValidationError.invalid;
  }
}