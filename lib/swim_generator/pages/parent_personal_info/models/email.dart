
import 'package:formz/formz.dart';

enum EmailValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const EmailValidationError(this.message);
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  EmailValidationError? validator(String value) {
    return value.isEmpty
        ? EmailValidationError.required
        : _emailRegex.hasMatch(value)
        ? null
        : EmailValidationError.invalid;
  }
}