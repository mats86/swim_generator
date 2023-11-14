
import 'package:formz/formz.dart';

enum EmailConfirmValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const EmailConfirmValidationError(this.message);
}

class EmailConfirm extends FormzInput<String, EmailConfirmValidationError> {
  const EmailConfirm.pure() : super.pure('');
  const EmailConfirm.dirty([String value = '']) : super.dirty(value);

  static final _emailConfirmRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  EmailConfirmValidationError? validator(String value) {
    return value.isEmpty
        ? EmailConfirmValidationError.required
        : _emailConfirmRegex.hasMatch(value)
        ? null
        : EmailConfirmValidationError.invalid;
  }
}