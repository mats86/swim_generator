import 'package:formz/formz.dart';

enum SwimCourseValidationError {
  required('Bitte wählen Sie einen Schwimmkurs aus'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const SwimCourseValidationError(this.message);
}

class SwimCourseModels extends FormzInput<String, SwimCourseValidationError> {
  const SwimCourseModels.pure() : super.pure('');
  const SwimCourseModels.dirty([String value = '']) : super.dirty(value);

  @override
  SwimCourseValidationError? validator(String value) {
    return value.isEmpty ? SwimCourseValidationError.required : null;
  }
}
