import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_stepper/stepper.dart';
import 'package:swim_generator/swim_generator/pages/kind_personal_info/kind_personal_info.dart';
import 'package:swim_generator/swim_generator/pages/parent_personal_info/view/parent_personal_info_page.dart';

import '../cubit/swim_generator_cubit.dart';
import '../pages/pages.dart';

class SwimGeneratorStepper extends StatelessWidget {
  const SwimGeneratorStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimGeneratorCubit, SwimGeneratorState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              NumberStepper(
                enableNextPreviousButtons: true,
                numbers: const [
                  1,
                  2,
                  3,
                  4,
                  5,
                  6,
                ],
                activeStep: state.activeStepperIndex,
                onStepReached: (index) {
                  context.read<SwimGeneratorCubit>().stepTapped(index);
                },
              ),
              header(state.activeStepperIndex),
              body(state.activeStepperIndex),
            ],
          ),
        );
      },
    );
  }

  /// Returns the header wrapping the header text.
  Widget header(int activeStepperIndex) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          headerText(activeStepperIndex),
          style: const TextStyle(
            // color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText(int activeStepperIndex) {
    switch (activeStepperIndex) {
      case 0:
        return 'GeburstDatum';

      case 1:
        return 'Schwimm Kurs';

      case 2:
        return 'Schwimmbad';

      case 3:
        return 'Kind Information';

      case 4:
        return 'Erziehungsberechtigten Information';

      case 5:
        return 'Zusammenfassen';

      default:
        return '';
    }
  }

  /// Returns the body.
  Widget body(int activeStepperIndex) {
    switch (activeStepperIndex) {
      case 0:
        return const BirthDayPage();

      case 1:
        return const SwimCoursePage();

      case 2:
        return const SwimPoolPage();

      case 3:
        return const KindPersonalInfoPage();

      case 4:
        return const ParentPersonalInfoPage();

      case 5:
        return const ResultPage();

      default:
        return Container();
    }
  }
}