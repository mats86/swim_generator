part of 'swim_pool_bloc.dart';

class SwimPoolState extends Equatable {
  final List<SwimPool> swimPools;
  final FormzSubmissionStatus loadingStatus;
  final FormzSubmissionStatus toggleStatus;
  final SwimPoolModels swimPoolModels;
  final FormzSubmissionStatus submissionStatus;

  const SwimPoolState({
    this.swimPools = const [],
    this.loadingStatus = FormzSubmissionStatus.canceled,
    this.toggleStatus = FormzSubmissionStatus.canceled,
    this.swimPoolModels = const SwimPoolModels.pure(),
    this.submissionStatus = FormzSubmissionStatus.canceled,
  });

  SwimPoolState copyWith({
    List<SwimPool>? swimPools,
    FormzSubmissionStatus? loadingStatus,
    FormzSubmissionStatus? toggleStatus,
    SwimPoolModels? swimPoolModels,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimPoolState(
      swimPools: swimPools ?? this.swimPools,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus,
      swimPoolModels: swimPoolModels ?? this.swimPoolModels,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        swimPools,
        loadingStatus,
        toggleStatus,
        swimPoolModels,
        submissionStatus
      ];
}
