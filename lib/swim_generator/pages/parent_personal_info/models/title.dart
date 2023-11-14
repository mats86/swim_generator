import 'package:formz/formz.dart';

enum TitleValidationError {
  required('Bitte wählen Sie einen Schwimmkurs aus'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const TitleValidationError(this.message);
}

class TitleModels extends FormzInput<String, TitleValidationError> {
  const TitleModels.pure() : super.pure('');
  const TitleModels.dirty([String value = '']) : super.dirty(value);

  @override
  TitleValidationError? validator(String value) {
    return value.isEmpty ? TitleValidationError.required : null;
  }
}
