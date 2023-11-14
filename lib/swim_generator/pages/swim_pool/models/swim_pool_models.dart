import 'package:formz/formz.dart';

import '../../../../logic/models/models.dart';

enum SwimPoolModelsValidationError { required, invalid }

extension Explanation on SwimPoolModelsValidationError {
  String get message {
    switch (this) {
      case SwimPoolModelsValidationError.required:
        return 'Bitte wählen Sie mindestens eine Option aus';
      case SwimPoolModelsValidationError.invalid:
        return 'Die eingegebene Option ist ungültig';
      default:
        return '';
    }
  }
}

class SwimPoolModels extends FormzInput<List<SwimPool>, SwimPoolModelsValidationError> {
  const SwimPoolModels.pure() : super.pure(const []);
  const SwimPoolModels.dirty([List<SwimPool> value = const []]) : super.dirty(value);

  @override
  SwimPoolModelsValidationError? validator(List<SwimPool> value) {
    if (value.isEmpty || value.every((pool) => !pool.isSelected)) {
      return SwimPoolModelsValidationError.required;
    }
    return null;
  }
}
