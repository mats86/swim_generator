import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

import '../models/first_name.dart';
import '../models/last_name.dart';

part 'kind_personal_info_event.dart';

part 'kind_personal_info_state.dart';

class KindPersonalInfoBloc
    extends Bloc<KindPersonalInfoEvent, KindPersonalInfoState> {
  final UserRepository userRepository;

  KindPersonalInfoBloc({required this.userRepository})
      : super(const KindPersonalInfoState()) {

    on<Initialize>(_onInitialize);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<FirstNameUnfocused>(_onFirstNameUnfocused);
    on<LastNameChanged>(_onLastNameChanged);
    on<LastNameUnfocused>(_onLastNameUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  Future<void> _onInitialize(
    Initialize event,
    Emitter<KindPersonalInfoState> emit,
  ) async {
    try {
      final user = await userRepository.getUser();
      emit(state.copyWith(
        firstName: FirstName.dirty(user!.kidsPersonalInfo.firstName),
        lastName: LastName.dirty(user.kidsPersonalInfo.lastName),
      ));
    } catch (_) {}
  }

  void _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final firstName = FirstName.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([firstName, state.lastName]),
      ),
    );
  }

  void _onFirstNameUnfocused(
    FirstNameUnfocused event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final firstName = FirstName.dirty(state.firstName.value);
    emit(state.copyWith(
      firstName: firstName,
      isValid: Formz.validate([firstName, state.lastName]),
    ));
  }

  void _onLastNameChanged(
    LastNameChanged event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final lastName = LastName.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([state.firstName, lastName]),
      ),
    );
  }

  void _onLastNameUnfocused(
    LastNameUnfocused event,
    Emitter<KindPersonalInfoState> emit,
  ) {
    final lastName = LastName.dirty(state.lastName.value);
    emit(state.copyWith(
      lastName: lastName,
      isValid: Formz.validate([state.firstName, lastName]),
    ));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<KindPersonalInfoState> emit,
  ) async {
    final firstName = FirstName.dirty(state.firstName.value);
    final lastName = LastName.dirty(state.lastName.value);
    emit(
      state.copyWith(
        firstName: firstName,
        lastName: lastName,
        isValid: Formz.validate([firstName, lastName]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        await userRepository.updateKidsPersonalInfo(
          firstName: state.firstName.value,
          lastName: state.lastName.value,
        );
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
