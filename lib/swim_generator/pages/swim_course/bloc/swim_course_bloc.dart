import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

import '../models/models.dart';

part 'swim_course_event.dart';

part 'swim_course_service.dart';

part 'swim_course_state.dart';

class SwimCourseBloc extends Bloc<SwimCourseEvent, SwimCourseState> {
  final SwimCourseService service;
  final UserRepository userRepository;

  SwimCourseBloc(this.service, this.userRepository)
      : super(const SwimCourseState()) {
    on<SwimSeasonChanged>(_onSwimSeasonChanged);
    on<SwimCourseChanged>(_onSwimCourseChanged);
    on<LoadSwimSeasonOptions>(_onLoadSwimSeasonOptions);
    on<LoadSwimCourseOptions>(_onLoadSwimCourseOptions);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onSwimSeasonChanged(
      SwimSeasonChanged event, Emitter<SwimCourseState> emit) {
    final swimSeason = SwimSeasonModels.dirty(event.swimSeason);
    emit(state.copyWith(
        swimSeason: swimSeason,
        submissionStatus: Formz.validate([swimSeason, state.swimCourse])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.failure));
  }

  void _onSwimCourseChanged(
      SwimCourseChanged event, Emitter<SwimCourseState> emit) {
    final swimCourse = SwimCourseModels.dirty(event.swimCourse);
    emit(state.copyWith(
        swimCourse: swimCourse,
        selectedCourse: event.course,
        submissionStatus: Formz.validate([state.swimSeason, swimCourse])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.failure));
  }

  void _onLoadSwimSeasonOptions(
      LoadSwimSeasonOptions event, Emitter<SwimCourseState> emit) async {
    emit(state.copyWith(loadingSeasonStatus: FormzSubmissionStatus.inProgress));
    try {
      final swimSeason = await service._fetchSwimSeason();
      emit(state.copyWith(
          swimSeasons: swimSeason,
          swimSeason: SwimSeasonModels.dirty(swimSeason[0]),
          loadingSeasonStatus: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(loadingSeasonStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onLoadSwimCourseOptions(
      LoadSwimCourseOptions event, Emitter<SwimCourseState> emit) async {
    emit(state.copyWith(loadingCourseStatus: FormzSubmissionStatus.inProgress));
    try {
      User? user = await userRepository.getUser();
      // final swimCourses =
      //     await service._fetchSwimCourses();
      List<Course> swimCourses =
          await service.getCoursesByBirthDate(user?.birthDay.birthDay);
      emit(state.copyWith(
          swimCourseOptions: swimCourses,
          loadingCourseStatus: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(loadingCourseStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<SwimCourseState> emit) async {
    final inValid = Formz.validate([state.swimSeason, state.swimCourse]);
    if (inValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        await userRepository.updateSwimCourseInfo(
          season: state.swimSeason.value,
          swimCourseID: state.selectedCourse.id,
          swimCourseName: state.selectedCourse.name,
          swimCoursePrice: state.selectedCourse.price,
        );
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
