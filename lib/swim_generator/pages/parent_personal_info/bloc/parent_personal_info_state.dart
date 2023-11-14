part of 'parent_personal_info_bloc.dart';

class ParentPersonalInfoState extends Equatable {
  const ParentPersonalInfoState({
    this.titleList = const [],
    this.title = const TitleModels.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.street = const Street.pure(),
    this.streetNumber = const StreetNumber.pure(),
    this.zipCode = const ZipCode.pure(),
    this.city = const City.pure(),
    this.email = const Email.pure(),
    this.emailConfirm = const EmailConfirm.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.phoneNumberConfirm = const PhoneNumberConfirm.pure(),
    this.loadingTitleStatus = FormzSubmissionStatus.canceled,
    this.submissionStatus = FormzSubmissionStatus.canceled,
  });

  final List<String> titleList;
  final TitleModels title;
  final FirstName firstName;
  final LastName lastName;
  final Street street;
  final StreetNumber streetNumber;
  final ZipCode zipCode;
  final City city;
  final Email email;
  final EmailConfirm emailConfirm;
  final PhoneNumber phoneNumber;
  final PhoneNumberConfirm phoneNumberConfirm;
  final FormzSubmissionStatus loadingTitleStatus;
  final FormzSubmissionStatus submissionStatus;

  ParentPersonalInfoState copyWith({
    List<String>? titleList,
    TitleModels? title,
    FirstName? firstName,
    LastName? lastName,
    Street? street,
    StreetNumber? streetNumber,
    ZipCode? zipCode,
    City? city,
    Email? email,
    EmailConfirm? emailConfirm,
    PhoneNumber? phoneNumber,
    PhoneNumberConfirm? phoneNumberConfirm,
    FormzSubmissionStatus? loadingTitleStatus,
    FormzSubmissionStatus? submissionStatus}) {
    return ParentPersonalInfoState(
        titleList: titleList ?? this.titleList,
        title: title ?? this.title,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        street: street ?? this.street,
        streetNumber: streetNumber ?? this.streetNumber,
        zipCode: zipCode ?? this.zipCode,
        city: city ?? this.city,
        email: email ?? this.email,
        emailConfirm: emailConfirm ?? this.emailConfirm,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneNumberConfirm: phoneNumberConfirm ?? this.phoneNumberConfirm,
        loadingTitleStatus: loadingTitleStatus ?? this.loadingTitleStatus,
        submissionStatus: submissionStatus ?? this.submissionStatus);
  }

  @override
  List<Object?> get props =>
      [
        titleList,
        title,
        firstName,
        lastName,
        street,
        streetNumber,
        zipCode,
        city,
        email,
        emailConfirm,
        phoneNumber,
        phoneNumberConfirm,
        loadingTitleStatus,
        submissionStatus,
      ];
}
