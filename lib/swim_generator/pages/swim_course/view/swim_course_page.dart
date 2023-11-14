import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../../swim_course/view/swim_course_form.dart';

import '../bloc/swim_course_bloc.dart';

class SwimCoursePage extends StatelessWidget {
  const SwimCoursePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SwimCoursePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SwimCourseBloc(SwimCourseService(), context.read<UserRepository>(),),
        child: const SwimCourseForm(),
      ),
    );
  }
}
