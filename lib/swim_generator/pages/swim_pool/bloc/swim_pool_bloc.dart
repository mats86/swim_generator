import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;

import '../../../../logic/models/models.dart';
import '../models/swim_pool_models.dart';

part 'swim_pool_event.dart';

part 'swim_pool_state.dart';

part 'swim_pool_service.dart';

class SwimPoolBloc extends Bloc<SwimPoolEvent, SwimPoolState> {
  final SwimPoolService _service;

  SwimPoolBloc(this._service) : super(const SwimPoolState()) {
    on<LoadSwimPools>(_onLoadSwimPools);
    on<SwimPoolOptionToggled>(_onSwimPoolOptionToggled);
    on<SwimPoolModelsChanged>(_onSwimPoolModelsChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onLoadSwimPools(
    LoadSwimPools event,
    Emitter<SwimPoolState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: FormzSubmissionStatus.inProgress));
    try {
      var pools = await _service.getSwimPools();
      emit(state.copyWith(
          swimPools: pools, loadingStatus: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(loadingStatus: FormzSubmissionStatus.failure));
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _onSwimPoolOptionToggled(
    SwimPoolOptionToggled event,
    Emitter<SwimPoolState> emit,
  ) {
    var newPools = List<SwimPool>.from(state.swimPools);
    var pool = newPools[event.index];
    newPools[event.index] = SwimPool(
        pool.swimPoolID,
        pool.swimPoolName,
        pool.swimPoolAddress,
        pool.swimPoolPhoneNumber,
        pool.openingTimes,
        event.isSelected);
    final inValid = Formz.validate([SwimPoolModels.dirty(newPools)])
        ? FormzSubmissionStatus.initial
        : FormzSubmissionStatus.failure;
    emit(state.copyWith(swimPools: newPools, submissionStatus: inValid));
  }

  void _onSwimPoolModelsChanged(
    SwimPoolModelsChanged event,
    Emitter<SwimPoolState> emit,
  ) {
    final swimPoolModels = SwimPoolModels.dirty(event.swimPools);
    emit(state.copyWith(
      swimPoolModels: swimPoolModels,
      toggleStatus: Formz.validate([swimPoolModels])
          ? FormzSubmissionStatus.initial
          : FormzSubmissionStatus.failure,
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<SwimPoolState> emit) async {
    final inValid = Formz.validate([SwimPoolModels.dirty(state.swimPools)]);
    if (inValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      // Implement the actual form submission logic here
      // For now, just simulating a successful form submission
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
