import 'package:formz/formz.dart';

enum LastNameValidationError {
  required('Nachname darf nicht leer sein.'),
  invalid('Der eingegebene Nachname ist ungültig.');

  final String message;
  const LastNameValidationError(this.message);
}

class LastName extends FormzInput<String, LastNameValidationError> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([super.value = '']) : super.dirty();

  static final _lastNameRegex = RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  LastNameValidationError? validator(String value) {
    if (value.isEmpty) {
      return LastNameValidationError.required;
    }
    if (!_lastNameRegex.hasMatch(value)) {
      return LastNameValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
