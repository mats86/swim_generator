import 'package:formz/formz.dart';

enum ZipCodeValidationError {
  required('Eine Postleitzahl ist erforderlich.'),
  invalid('Die Postleitzahl muss aus 5 Zahlen bestehen.');

  final String message;
  const ZipCodeValidationError(this.message);
}

class ZipCode extends FormzInput<String, ZipCodeValidationError> {
  const ZipCode.pure() : super.pure('');
  const ZipCode.dirty([super.value = '']) : super.dirty();

  @override
  ZipCodeValidationError? validator(String value) {
    if (value.isEmpty) {
      return ZipCodeValidationError.required;
    }
    // Überprüfen, ob die Postleitzahl genau 5 Zahlen enthält
    if (!RegExp(r'^\d{5}$').hasMatch(value)) {
      return ZipCodeValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
