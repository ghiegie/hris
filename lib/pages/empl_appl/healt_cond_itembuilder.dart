import 'package:flutter/material.dart';
import 'package:hris/model/health_condition_model.dart';
import 'package:hris/pages/empl_appl/components.dart';

// function that takes a list
// that returns a function that takes a context and int index and returns a widget


Widget Function(BuildContext, int) healthCondItemBuilder(
  List<HealthConditionModel> list,
  void Function(int index) removeFn
) {
  return (BuildContext context, int index) {
    var controller = TextEditingController(
      text: list[index].healthCondition ?? ""
    );

    controller.addListener(() {
      list[index].healthCondition = controller.text;
    });

    void removeFnHelper() {
      return removeFn(index);
    }

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: TextFieldDesign.build(),
            controller: controller,
          )
        ),
        const SizedBox(width: 5.0),
        ElevatedButton(
          onPressed: removeFnHelper, 
          child: const Text('Remove')
        )
      ],
    );
  };
}