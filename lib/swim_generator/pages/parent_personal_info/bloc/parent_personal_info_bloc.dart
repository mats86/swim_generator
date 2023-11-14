import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import '../models/models.dart';

part 'parent_personal_info_event.dart';

part 'parent_personal_info_service.dart';

part 'parent_personal_info_state.dart';

class ParentPersonalInfoBloc
    extends Bloc<ParentPersonalInfoEvent, ParentPersonalInfoState> {
  final ParentPersonalInfoService service;
  final UserRepository userRepository;

  ParentPersonalInfoBloc(this.service, this.userRepository)
      : super(const ParentPersonalInfoState()) {
    on<LoadParentTitleOptions>(_onLoadParentTitleOptions);
    on<TitleChanged>(_onTitleChanged);
    on<ParentFirstNameChanged>(_onParentFirstNameChanged);
    on<ParentLastNameChanged>(_onParentLastNameChanged);
    on<ParentStreetChanged>(_onParentStreetChanged);
    on<ParentStreetNumberChanged>(_onParentStreetNumberChanged);
    on<ParentZipCodeChanged>(_onParentZipCodeChanged);
    on<ParentCityChanged>(_onParentCityChanged);
    on<ParentEmailChanged>(_onParentEmailChanged);
    on<ParentEmailConfirmChanged>(_onParentEmailConfirmChanged);
    on<ParentPhoneNumberChanged>(_onParentPhoneNumberChanged);
    on<ParentPhoneNumberConfirmChanged>(_onParentPhoneNumberConfirmChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onLoadParentTitleOptions(LoadParentTitleOptions event,
      Emitter<ParentPersonalInfoState> emit) async {
    emit(state.copyWith(loadingTitleStatus: FormzSubmissionStatus.inProgress));
    try {
      final titleList = await service._fetchTitle();
      emit(state.copyWith(
          titleList: titleList,
          title: TitleModels.dirty(titleList[0]),
          loadingTitleStatus: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(loadingTitleStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onTitleChanged(
    TitleChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final title = TitleModels.dirty(event.title);
    emit(
      state.copyWith(
        title: title,
        submissionStatus: Formz.validate([
          title,
          state.firstName,
          state.lastName,
          state.street,
          state.streetNumber,
          state.zipCode,
          state.city,
          state.email,
          state.emailConfirm,
          state.phoneNumber,
          state.phoneNumberConfirm
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentFirstNameChanged(
    ParentFirstNameChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final firstName = FirstName.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName,
        submissionStatus: Formz.validate(
          [
            state.title,
            firstName,
            state.lastName,
            state.street,
            state.streetNumber,
            state.zipCode,
            state.city,
            state.email,
            state.emailConfirm,
            state.phoneNumber,
            state.phoneNumberConfirm
          ],
        )
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentLastNameChanged(
    ParentLastNameChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final lastName = LastName.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName,
        submissionStatus: Formz.validate([
          state.title,
          state.firstName,
          lastName,
          state.street,
          state.streetNumber,
          state.zipCode,
          state.city,
          state.email,
          state.emailConfirm,
          state.phoneNumber,
          state.phoneNumberConfirm,
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentStreetChanged(
    ParentStreetChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final street = Street.dirty(event.street);
    emit(
      state.copyWith(
        street: street,
        submissionStatus: Formz.validate([
          state.title,
          state.firstName,
          state.lastName,
          street,
          state.streetNumber,
          state.zipCode,
          state.city,
          state.email,
          state.emailConfirm,
          state.phoneNumber,
          state.phoneNumberConfirm
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentStreetNumberChanged(
    ParentStreetNumberChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final streetNumber = StreetNumber.dirty(event.streetNumber);
    emit(
      state.copyWith(
        streetNumber: streetNumber,
        submissionStatus: Formz.validate([
          state.title,
          state.firstName,
          state.lastName,
          state.street,
          streetNumber,
          state.zipCode,
          state.city,
          state.email,
          state.emailConfirm,
          state.phoneNumber,
          state.phoneNumberConfirm
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentZipCodeChanged(
    ParentZipCodeChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final zipCode = ZipCode.dirty(event.zipCode);
    emit(
      state.copyWith(
        zipCode: zipCode,
        submissionStatus: Formz.validate([
          state.title,
          state.firstName,
          state.lastName,
          state.street,
          state.streetNumber,
          zipCode,
          state.city,
          state.email,
          state.emailConfirm,
          state.phoneNumber,
          state.phoneNumberConfirm
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentCityChanged(
    ParentCityChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final city = City.dirty(event.city);
    emit(
      state.copyWith(
        city: city,
        submissionStatus: Formz.validate([
          state.title,
          state.firstName,
          state.lastName,
          state.street,
          state.streetNumber,
          state.zipCode,
          city,
          state.email,
          state.emailConfirm,
          state.phoneNumber,
          state.phoneNumberConfirm
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentEmailChanged(
    ParentEmailChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        submissionStatus: Formz.validate([
          state.title,
          state.firstName,
          state.lastName,
          state.street,
          state.streetNumber,
          state.zipCode,
          state.city,
          email,
          state.emailConfirm,
          state.phoneNumber,
          state.phoneNumberConfirm
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentEmailConfirmChanged(
    ParentEmailConfirmChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final emailConfirm = EmailConfirm.dirty(event.emailConfirm);
    emit(
      state.copyWith(
        emailConfirm: emailConfirm,
        submissionStatus: Formz.validate([
          state.title,
          state.firstName,
          state.lastName,
          state.street,
          state.streetNumber,
          state.zipCode,
          state.city,
          state.email,
          emailConfirm,
          state.phoneNumber,
          state.phoneNumberConfirm
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentPhoneNumberChanged(
    ParentPhoneNumberChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        submissionStatus: Formz.validate([
          state.title,
          state.firstName,
          state.lastName,
          state.street,
          state.streetNumber,
          state.zipCode,
          state.city,
          state.email,
          state.emailConfirm,
          phoneNumber,
          state.phoneNumberConfirm
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onParentPhoneNumberConfirmChanged(
    ParentPhoneNumberConfirmChanged event,
    Emitter<ParentPersonalInfoState> emit,
  ) {
    final phoneNumberConfirm =
        PhoneNumberConfirm.dirty(event.phoneNumberConfirm);
    emit(
      state.copyWith(
        phoneNumberConfirm: phoneNumberConfirm,
        submissionStatus: Formz.validate([
          state.title,
          state.firstName,
          state.lastName,
          state.street,
          state.streetNumber,
          state.zipCode,
          state.city,
          state.email,
          state.emailConfirm,
          state.phoneNumber,
          phoneNumberConfirm,
        ])
            ? FormzSubmissionStatus.initial
            : FormzSubmissionStatus.canceled,
      ),
    );
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<ParentPersonalInfoState> emit,
  ) async {
    final isValid = Formz.validate([
      state.title,
      state.firstName,
      state.lastName,
      state.street,
      state.streetNumber,
      state.zipCode,
      state.city,
      state.email,
      state.emailConfirm,
      state.phoneNumber,
      state.phoneNumberConfirm
    ]);
    if (isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        await userRepository.updatePersonalInfo(
          title: state.title.value,
          firstName: state.firstName.value,
          lastName: state.lastName.value,
          street: state.street.value,
          streetNumber: state.streetNumber.value,
          zipCode: state.zipCode.value,
          city: state.city.value,
          email: state.email.value,
          emailConfirm: state.emailConfirm.value,
          phoneNumber: state.phoneNumber.value,
          phoneNumberConfirm: state.phoneNumberConfirm.value,
        );
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
