import 'package:formz/formz.dart';

enum FirstNameValidationError {
  required('Vorname darf nicht leer sein.'),
  invalid('Der eingegebene Vorname ist ungültig.');

  final String message;
  const FirstNameValidationError(this.message);
}

class FirstName extends FormzInput<String, FirstNameValidationError> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty([super.value = '']) : super.dirty();

  static final _firstNameRegex = RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  FirstNameValidationError? validator(String value) {
    if (value.isEmpty) {
      return FirstNameValidationError.required;
    }
    if (!_firstNameRegex.hasMatch(value)) {
      return FirstNameValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
