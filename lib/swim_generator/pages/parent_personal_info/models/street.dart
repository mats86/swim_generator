
import 'package:formz/formz.dart';

enum StreetValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const StreetValidationError(this.message);
}

class Street extends FormzInput<String, StreetValidationError> {
  const Street.pure() : super.pure('');
  const Street.dirty([String value = '']) : super.dirty(value);

  static final _streetRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  StreetValidationError? validator(String value) {
    return value.isEmpty
        ? StreetValidationError.required
        : _streetRegex.hasMatch(value)
        ? null
        : StreetValidationError.invalid;
  }
}