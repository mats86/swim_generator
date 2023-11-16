import 'package:formz/formz.dart';

enum EmailValidationError {
  required('E-Mail darf nicht leer sein.'),
  invalid('Die eingegebene E-Mail-Adresse ist ungültig.');

  final String message;
  const EmailValidationError(this.message);
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.required;
    }
    if (!_emailRegex.hasMatch(value)) {
      return EmailValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
