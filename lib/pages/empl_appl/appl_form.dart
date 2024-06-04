import 'package:flutter/material.dart';
import 'package:hris/model/health_condition_model.dart';
import 'package:hris/pages/empl_appl/components.dart';
import 'package:hris/pages/empl_appl/name_details.dart';

class ApplicationForm extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  final nameForm = NameForm();

  final bdayDatePicker = Datepicker(
    start: DateTime(0),
    end: DateTime.now()
  );

  final genderDropdown = CustomDropdown(
    items: const [
      DropdownMenuItem(
        value: "Male",
        child: Text("Male")
      ),
      DropdownMenuItem(
        value: "Female",
        child: Text("Female")
      ),
    ], 
    onChanged: (dynamic val) {
      return val;
    }
  );

  final List<HealthConditionModel> healthConditions = [];
  final healthConditionVec = VectorForm(
    emptyLabel: "Add Health Condtions you currently have.", 
    itemBuilder: (list, fn) {
      return (ctx, digit) {
        return const Text("2");
      };
    }, 
    addFn: () {}, 
    removeFn: (digit) {}
  );

  ApplicationForm({super.key});

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Form(
          key: widget._formKey,
          child: ListView(
            children: [
              const Label(labelName: "Name Details", widgetWidth: double.maxFinite),
              widget.nameForm,

              const SizedBox(height: 20.0),

              const Label(labelName: "Birthday", widgetWidth: double.maxFinite),
              widget.bdayDatePicker,

              const SizedBox(height: 20.0),

              const Label(labelName: "Gender", widgetWidth: double.maxFinite),
              widget.genderDropdown,

              const SizedBox(height: 20.0),

              const Label(labelName: "Health Conditions", widgetWidth: double.maxFinite),
              widget.healthConditionVec,
            ],
          )
        )
      )
    );
  }
}