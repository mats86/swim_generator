import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_generator/swim_generator/view/swim_generator_stepper.dart';
import 'package:user_repository/user_repository.dart';

import '../cubit/swim_generator_cubit.dart';

class SwimGeneratorPage extends StatelessWidget {
  const SwimGeneratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>(
      create: (_) => UserRepository(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Schwimmkurs Generator'),
          centerTitle: true,
        ),
        body: BlocProvider<SwimGeneratorCubit>(
          create: (_) => SwimGeneratorCubit(6),
          child: const SwimGeneratorStepper(),
        ),
      ),
    );
  }
}