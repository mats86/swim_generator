import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import '../../../cubit/swim_generator_cubit.dart';

import '../bloc/kind_personal_info_bloc.dart';

class KindPersonalInfoForm extends StatefulWidget {
  const KindPersonalInfoForm({super.key});

  @override
  State<KindPersonalInfoForm> createState() => _KindPersonalInfoForm();
}

class _KindPersonalInfoForm extends State<KindPersonalInfoForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final FocusNode _firstNameFocusNod = FocusNode();
  final FocusNode _lastNameFocusNod = FocusNode();
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = context.read<KindPersonalInfoBloc>().userRepository.getUser();
    _firstNameFocusNod.addListener(() {
      if (!_firstNameFocusNod.hasFocus) {
        context.read<KindPersonalInfoBloc>().add(FirstNameUnfocused());
        FocusScope.of(context).requestFocus(_lastNameFocusNod);
      }
    });
    _lastNameFocusNod.addListener(() {
      if (!_lastNameFocusNod.hasFocus) {
        context.read<KindPersonalInfoBloc>().add(LastNameUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocusNod.dispose();
    _lastNameFocusNod.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data!.kidsPersonalInfo.firstName != '') {
            _firstNameController.text =
                snapshot.data!.kidsPersonalInfo.firstName;
            context
                .read<KindPersonalInfoBloc>()
                .add(FirstNameChanged(snapshot.data!.kidsPersonalInfo.firstName));
          }
          if (snapshot.data!.kidsPersonalInfo.lastName != '') {
            _lastNameController.text = snapshot.data!.kidsPersonalInfo.lastName;
            context
                .read<KindPersonalInfoBloc>()
                .add(LastNameChanged(snapshot.data!.kidsPersonalInfo.lastName));
          }

          return BlocListener<KindPersonalInfoBloc, KindPersonalInfoState>(
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _FirstNameInput(
                  controller: _firstNameController,
                  focusNode: _firstNameFocusNod,
                ),
                _LastNameInput(
                  controller: _lastNameController,
                  focusNode: _lastNameFocusNod,
                ),
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
        });
  }
}

class _FirstNameInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const _FirstNameInput({
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          key: const Key('KindPersonalInfoForm_firstNameInput_textField'),
          onChanged: (firstName) => context
              .read<KindPersonalInfoBloc>()
              .add(FirstNameChanged(firstName)),
          decoration: InputDecoration(
            label: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Text(
                    'Vorname des Schwimmschülers',
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
            // Verwenden Sie displayError für die Fehleranzeige
            errorText: state.firstName.displayError != null
                ? state.firstName.error?.message
                : null,
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const _LastNameInput({
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        buildWhen: (previous, current) => previous.lastName != current.lastName,
        builder: (context, state) {
          return TextField(
            focusNode: focusNode,
            key: const Key('KindPersonalInfoForm_lastNameInput_textField'),
            onChanged: (lastName) => context
                .read<KindPersonalInfoBloc>()
                .add(LastNameChanged(lastName)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      'Nachname des Schwimmschülers',
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
              errorText: state.lastName.displayError != null
                  ? state.lastName.error?.message
                  : null,
            ),
            controller: controller,
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindPersonalInfoBloc, KindPersonalInfoState>(
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
        final isValid =
            context.select((KindPersonalInfoBloc bloc) => bloc.state.isValid);
        return state.submissionStatus.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key(
                    'kindPersonalInfoForm_submitButton_elevatedButton'),
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: isValid
                    ? () => context
                        .read<KindPersonalInfoBloc>()
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
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.submissionStatus != current.submissionStatus,
        builder: (context, state) {
          return state.submissionStatus.isInProgress
              ? const SizedBox.shrink()
              : TextButton(
                  key: const Key(
                      'kindPersonalInfoForm_cancelButton_elevatedButton'),
                  onPressed: () =>
                      context.read<SwimGeneratorCubit>().stepCancelled(),
                  child: const Text('Weiter'),
                );
        });
  }
}
