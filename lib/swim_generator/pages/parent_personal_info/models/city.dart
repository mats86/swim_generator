
import 'package:formz/formz.dart';

enum CityValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const CityValidationError(this.message);
}

class City extends FormzInput<String, CityValidationError> {
  const City.pure() : super.pure('');
  const City.dirty([super.value = '']) : super.dirty();

  static final _cityRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  CityValidationError? validator(String value) {
    return value.isEmpty
        ? CityValidationError.required
        : _cityRegex.hasMatch(value)
        ? null
        : CityValidationError.invalid;
  }
}