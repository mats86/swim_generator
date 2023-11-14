
import 'package:formz/formz.dart';

enum LastNameValidationError {
  required('Nachname can\'t be empty'),
  invalid('Nachname you have entered is not valid.');

  final String message;
  const LastNameValidationError(this.message);
}

class LastName extends FormzInput<String, LastNameValidationError> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([String value = '']) : super.dirty(value);

  static final _lastNameRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  LastNameValidationError? validator(String value) {
    return value.isEmpty
        ? LastNameValidationError.required
        : _lastNameRegex.hasMatch(value)
        ? null
        : LastNameValidationError.invalid;
  }
}