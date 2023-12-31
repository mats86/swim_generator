import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:swim_generator/swim_generator/cubit/swim_generator_cubit.dart';
import 'package:user_repository/user_repository.dart';

import '../bloc/parent_personal_info_bloc.dart';

class ParentPersonalInfoForm extends StatefulWidget {
  const ParentPersonalInfoForm({super.key});

  @override
  State<ParentPersonalInfoForm> createState() => _ParentPersonalInfoForm();
}

class _ParentPersonalInfoForm extends State<ParentPersonalInfoForm> {
  late Future<User?> _userFuture;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _streetNumberController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailConfirmController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _phoneNumberConfirmController =
      TextEditingController();

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _streetFocusNode = FocusNode();
  final FocusNode _streetNumberFocusNode = FocusNode();
  final FocusNode _zipCodeFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _emailConfirmFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _phoneNumberConfirmFocusNode = FocusNode();

  void _addFocusNodeListener(
    FocusNode currentNode,
    FocusNode? nextNode,
    void Function()? onUnfocused,
  ) {
    currentNode.addListener(() {
      if (!currentNode.hasFocus) {
        if (onUnfocused != null) {
          onUnfocused();
        }
        if (nextNode != null) {
          FocusScope.of(context).requestFocus(nextNode);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ParentPersonalInfoBloc>().add(LoadParentTitleOptions());
    _userFuture =
        context.read<ParentPersonalInfoBloc>().userRepository.getUser();

    _addFocusNodeListener(_titleFocusNode, _firstNameFocusNode, null);
    _addFocusNodeListener(_firstNameFocusNode, _lastNameFocusNode, null);
    _addFocusNodeListener(_lastNameFocusNode, _streetFocusNode, null);
    _addFocusNodeListener(_streetFocusNode, _streetNumberFocusNode, null);
    _addFocusNodeListener(_streetNumberFocusNode, _zipCodeFocusNode, null);
    _addFocusNodeListener(_zipCodeFocusNode, _cityFocusNode, null);
    _addFocusNodeListener(_cityFocusNode, _emailFocusNode, null);
    _addFocusNodeListener(_emailFocusNode, _emailConfirmFocusNode, null);
    _addFocusNodeListener(_emailConfirmFocusNode, _phoneNumberFocusNode, null);
    _addFocusNodeListener(
        _phoneNumberFocusNode, _phoneNumberConfirmFocusNode, null);
    _addFocusNodeListener(_phoneNumberConfirmFocusNode, null, null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParentPersonalInfoBloc, ParentPersonalInfoState>(
      listener: (context, state) {
        if (state.submissionStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: Column(
        children: [
          _ParentTitle(),
          _FirstNameInput(),
          _LastNameInput(),
          _StreetInput(),
          _StreetNumberInput(),
          _ZipCodeInput(),
          _CityInput(),
          _EmailInput(),
          _EmailConfirmInput(),
          _PhoneNumberInput(),
          _PhoneNumberConfirmInput(),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _CancelButton()),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(child: _SubmitButton())
            ],
          )
        ],
      ),
    );
  }
}

class _ParentTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
      builder: (context, state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            labelText: 'Anrede',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          child: DropdownButtonHideUnderline(
            child: !state.loadingTitleStatus.isSuccess
                ? const SpinKitWaveSpinner(
                    color: Colors.lightBlueAccent,
                    size: 50.0,
                  )
                : DropdownButton<String>(
                    isExpanded: true,
                    value: state
                        .title.value, // Hier sollte der ausgewählte Wert sein
                    items: state.titleList.map((String title) {
                      return DropdownMenuItem<String>(
                        value: title,
                        child: Text(title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Dies wird aufgerufen, wenn der Benutzer ein Element auswählt.
                      BlocProvider.of<ParentPersonalInfoBloc>(context)
                          .add(TitleChanged(value!));
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.firstName != current.firstName,
        builder: (context, state) {
          return TextField(
            key: const Key('ParentPersonalInfoForm_firstNameInput_textField'),
            onChanged: (firstName) => context
                .read<ParentPersonalInfoBloc>()
                .add(ParentFirstNameChanged(firstName)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Vorname des Erziehungsberechtigten',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              errorText: state.firstName.isValid
                  ? state.firstName.error?.message
                  : null,
            ),
          );
        });
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) => previous.lastName != current.lastName,
        builder: (context, state) {
          return TextField(
            key: const Key('ParentPersonalInfoForm_lastNameInput_textField'),
            onChanged: (lastName) => context
                .read<ParentPersonalInfoBloc>()
                .add(ParentLastNameChanged(lastName)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Nachname des Erziehungsberechtigten',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              errorText:
                  state.lastName.isValid ? state.lastName.error?.message : null,
            ),
          );
        });
  }
}

class _StreetInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) => previous.street != current.street,
        builder: (context, state) {
          return TextField(
            key: const Key('ParentPersonalInfoForm_StreetInput_textField'),
            onChanged: (street) => context
                .read<ParentPersonalInfoBloc>()
                .add(ParentStreetChanged(street)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Straße',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              errorText:
                  state.street.isValid ? state.street.error?.message : null,
            ),
          );
        });
  }
}

class _StreetNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.streetNumber != current.streetNumber,
        builder: (context, state) {
          return TextField(
            key:
                const Key('ParentPersonalInfoForm_StreetNumberInput_textField'),
            onChanged: (streetNumber) => context
                .read<ParentPersonalInfoBloc>()
                .add(ParentStreetNumberChanged(streetNumber)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Hausnummer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              errorText: state.streetNumber.isValid
                  ? state.streetNumber.error?.message
                  : null,
            ),
          );
        });
  }
}

class _ZipCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
      buildWhen: (previous, current) => previous.zipCode != current.zipCode,
      builder: (context, state) {
        return TextField(
          key: const Key('ParentPersonalInfoForm_ZipCodeInput_textField'),
          onChanged: (zipCode) => context
              .read<ParentPersonalInfoBloc>()
              .add(ParentZipCodeChanged(zipCode)),
          keyboardType: TextInputType.number,
          maxLength: 5,
          // Begrenzt die Eingabe auf 5 Zeichen
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          // Erlaubt nur Zahlen
          decoration: InputDecoration(
            counterText: "",
            label: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Text(
                    'PLZ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Text('*',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            errorText: !state.zipCode.isPure && state.zipCode.isNotValid
                ? state.zipCode.error?.message
                : null,
          ),
        );
      },
    );
  }
}

class _CityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) => previous.city != current.city,
        builder: (context, state) {
          return TextField(
            key: const Key('ParentPersonalInfoForm_CityInput_textField'),
            onChanged: (city) => context
                .read<ParentPersonalInfoBloc>()
                .add(ParentCityChanged(city)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Ort',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              errorText: state.city.isValid ? state.city.error?.message : null,
            ),
          );
        });
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            key: const Key('ParentPersonalInfoForm_EmailInput_textField'),
            onChanged: (email) => context
                .read<ParentPersonalInfoBloc>()
                .add(ParentEmailChanged(email)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Deine BESTE E-Mail',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              errorText:
                  state.email.isValid ? state.email.error?.message : null,
            ),
          );
        });
  }
}

class _EmailConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.emailConfirm != current.emailConfirm,
        builder: (context, state) {
          return TextField(
            key:
                const Key('ParentPersonalInfoForm_EmailConfirmInput_textField'),
            onChanged: (emailConfirm) => context
                .read<ParentPersonalInfoBloc>()
                .add(ParentEmailConfirmChanged(emailConfirm)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Wiederhole bitte deine E-Mail',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              errorText: state.emailConfirm.isValid
                  ? state.emailConfirm.error?.message
                  : null,
            ),
          );
        });
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.phoneNumber != current.phoneNumber,
        builder: (context, state) {
          return TextField(
            key: const Key('ParentPersonalInfoForm_PhoneNumberInput_textField'),
            onChanged: (phoneNumber) => context
                .read<ParentPersonalInfoBloc>()
                .add(ParentPhoneNumberChanged(phoneNumber)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Handynummer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              errorText: state.phoneNumber.isValid
                  ? state.phoneNumber.error?.message
                  : null,
            ),
          );
        });
  }
}

class _PhoneNumberConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.phoneNumberConfirm != current.phoneNumberConfirm,
        builder: (context, state) {
          return TextField(
            key: const Key(
                'ParentPersonalInfoForm_PhoneNumberConfirmInput_textField'),
            onChanged: (phoneNumberConfirm) => context
                .read<ParentPersonalInfoBloc>()
                .add(ParentPhoneNumberConfirmChanged(phoneNumberConfirm)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Wiederhole bitte deine Handynummer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              errorText: state.phoneNumberConfirm.isValid
                  ? state.phoneNumberConfirm.error?.message
                  : null,
            ),
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParentPersonalInfoBloc, ParentPersonalInfoState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
        }
      },
      buildWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
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
        return state.submissionStatus.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key(
                    'ParentPersonalInfoForm_submitButton_elevatedButton'),
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: isValid
                    ? () => context
                        .read<ParentPersonalInfoBloc>()
                        .add(FormSubmitted())
                    : null,
                child: const Text('Weiter'),
              );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.submissionStatus != current.submissionStatus,
        builder: (context, state) {
          return state.submissionStatus.isInProgress
              ? const SizedBox.shrink()
              : TextButton(
                  key: const Key(
                      'ParentPersonalInfoForm_cancelButton_elevatedButton'),
                  onPressed: () =>
                      context.read<SwimGeneratorCubit>().stepCancelled(),
                  child: const Text('Zurück'),
                );
        });
  }
}
