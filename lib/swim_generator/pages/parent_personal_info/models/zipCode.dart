
import 'package:formz/formz.dart';

enum ZipCodeValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const ZipCodeValidationError(this.message);
}

class ZipCode extends FormzInput<String, ZipCodeValidationError> {
  const ZipCode.pure() : super.pure('');
  const ZipCode.dirty([String value = '']) : super.dirty(value);

  static final _zipCodeRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  ZipCodeValidationError? validator(String value) {
    return value.isEmpty
        ? ZipCodeValidationError.required
        : _zipCodeRegex.hasMatch(value)
        ? null
        : ZipCodeValidationError.invalid;
  }
}