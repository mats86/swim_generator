import 'package:flutter/material.dart';
import 'package:swim_generator/swim_generator/pages/result/view/result_form.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ResultPage());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: const ResultForm(
      ),
    );
  }
}
