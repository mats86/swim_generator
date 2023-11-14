import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:swim_generator/swim_generator/pages/birth_day/models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'birth_day_event.dart';
part 'birth_day_state.dart';

class BirthDayBloc extends Bloc<BirthDayEvent, BirthDayState> {
  final UserRepository userRepository;

  BirthDayBloc({required this.userRepository}) : super(const BirthDayState()) {
    on<BirthDayChanged>(_onBirthDayChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onBirthDayChanged(
      BirthDayChanged event,
      Emitter<BirthDayState> emit,
      ) {
    final birthDay = BirthDayModel.dirty(event.birthDay);
    final isValid = birthDay.isValid;

    // Aktualisieren Sie den Status basierend auf der Gültigkeit des Formulars
    emit(state.copyWith(
      birthDay: birthDay,
      submissionStatus: isValid ? FormzSubmissionStatus.initial : FormzSubmissionStatus.failure,
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event,
      Emitter<BirthDayState> emit,
      ) async {
    if (Formz.validate([state.birthDay])) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        await userRepository.updateBirthDay(birthDay: state.birthDay.value!);
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
