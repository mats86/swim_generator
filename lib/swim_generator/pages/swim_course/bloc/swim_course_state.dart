part of 'swim_course_bloc.dart';

class SwimCourseState extends Equatable {
  const SwimCourseState({
    this.swimSeasons = const [],
    this.swimSeason = const SwimSeasonModels.pure(),
    this.swimCourseOptions = const [],
    this.swimCourse = const SwimCourseModels.pure(),
    this.selectedCourse = const Course.empty(),
    this.loadingSeasonStatus = FormzSubmissionStatus.canceled,
    this.loadingCourseStatus = FormzSubmissionStatus.canceled,
    this.submissionStatus = FormzSubmissionStatus.canceled,
  });

  final List<String> swimSeasons;
  final SwimSeasonModels swimSeason;
  final List<Course> swimCourseOptions;
  final SwimCourseModels swimCourse;
  final Course selectedCourse;
  final FormzSubmissionStatus loadingSeasonStatus;
  final FormzSubmissionStatus loadingCourseStatus;
  final FormzSubmissionStatus submissionStatus;

  SwimCourseState copyWith({
    List<String>? swimSeasons,
    SwimSeasonModels? swimSeason,
    List<Course>? swimCourseOptions,
    SwimCourseModels? swimCourse,
    Course? selectedCourse,
    FormzSubmissionStatus? loadingSeasonStatus,
    FormzSubmissionStatus? loadingCourseStatus,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimCourseState(
      swimSeasons: swimSeasons ?? this.swimSeasons,
      swimSeason: swimSeason ?? this.swimSeason,
      swimCourseOptions: swimCourseOptions ?? this.swimCourseOptions,
      swimCourse: swimCourse ?? this.swimCourse,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      loadingSeasonStatus: loadingSeasonStatus ?? this.loadingSeasonStatus,
      loadingCourseStatus: loadingCourseStatus ?? this.loadingCourseStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props =>
      [
        swimSeasons,
        swimSeason,
        swimCourseOptions,
        swimCourse,
        loadingSeasonStatus,
        loadingCourseStatus,
        submissionStatus,
      ];
}
