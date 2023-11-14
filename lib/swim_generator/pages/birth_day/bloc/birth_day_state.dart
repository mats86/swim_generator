part of 'birth_day_bloc.dart';

class BirthDayState extends Equatable {
  const BirthDayState({
    this.birthDay = const BirthDayModel.pure(),
    this.submissionStatus = FormzSubmissionStatus.canceled,
  });

  final BirthDayModel birthDay;
  final FormzSubmissionStatus submissionStatus;

  BirthDayState copyWith({
    BirthDayModel? birthDay,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return BirthDayState(
      birthDay: birthDay ?? this.birthDay,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [birthDay, submissionStatus];
}