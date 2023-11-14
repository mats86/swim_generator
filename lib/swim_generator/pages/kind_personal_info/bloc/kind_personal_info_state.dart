part of 'kind_personal_info_bloc.dart';

class KindPersonalInfoState extends Equatable {
  const KindPersonalInfoState({
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final FirstName firstName;
  final LastName lastName;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  KindPersonalInfoState copyWith({
    FirstName? firstName,
    LastName? lastName,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return KindPersonalInfoState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, submissionStatus];
}