import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/swim_pool_bloc.dart';
import 'swim_pool_form.dart';

class SwimPoolPage extends StatelessWidget {
  const SwimPoolPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SwimPoolPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SwimPoolBloc(SwimPoolService()),
        child: const SwimPoolForm(),
      ),
    );
  }
}
