import 'package:flutter/material.dart';
import 'package:hris/pages/empl_appl/components.dart';

class ApplForm extends StatefulWidget {
  final groupedTextField = GroupedTextField.fromFields(const ["Last Name", "First Name", "Middle Name", "Name Extension"]);
  final bDatePicker = CustomDatePicker();
  final customDropdown = CustomDropdown(list: const [
    DropdownMenuItem(
      value: "Male",
      child: Text("Male")
    ),
    DropdownMenuItem(
      value: "Female",
      child: Text("Female")
    ),
  ]);
  final lastChkUpDatePicker = CustomDatePicker();
  final healthConditions = VecList(emptyLabel: "sample label");


  ApplForm({super.key});

  @override
  State<ApplForm> createState() => _ApplFormState();
}

class _ApplFormState extends State<ApplForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        color: Colors.orangeAccent,
        child: ListView(
          children: [
            const Label(labelName: "Name Details", widgetWidth: double.maxFinite),
            widget.groupedTextField,     
            const SizedBox(height: 60.0),
            const Label(labelName: "Birthdate", widgetWidth: double.maxFinite),
            widget.bDatePicker,
            const SizedBox(height: 60.0),
            const Label(labelName: "Gender", widgetWidth: double.maxFinite),
            widget.customDropdown,
            const SizedBox(height: 60.0),
            const Label(labelName: "Last Check Up", widgetWidth: double.maxFinite),
            widget.lastChkUpDatePicker,
            const SizedBox(height: 60.0),
            const Label(labelName: "Health Conditions", widgetWidth: double.maxFinite),
            widget.healthConditions,
            const SizedBox(height: 60.0),
          ],
        )
      ),
    );
  }
}