
import 'package:formz/formz.dart';

enum FirstNameValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const FirstNameValidationError(this.message);
}

class FirstName extends FormzInput<String, FirstNameValidationError> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty([String value = '']) : super.dirty(value);

  static final _firstNameRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  FirstNameValidationError? validator(String value) {
    return value.isEmpty
        ? FirstNameValidationError.required
        : _firstNameRegex.hasMatch(value)
        ? null
        : FirstNameValidationError.invalid;
  }
}