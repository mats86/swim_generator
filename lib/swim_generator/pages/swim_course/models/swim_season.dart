import 'package:formz/formz.dart';

enum SwimSeasonValidationError {
  required('Bitte wählen Sie einen Schwimmkurs aus'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const SwimSeasonValidationError(this.message);
}

class SwimSeasonModels extends FormzInput<String, SwimSeasonValidationError> {
  const SwimSeasonModels.pure() : super.pure('');
  const SwimSeasonModels.dirty([String value = '']) : super.dirty(value);

  @override
  SwimSeasonValidationError? validator(String value) {
    return value.isEmpty ? SwimSeasonValidationError.required : null;
  }
}
