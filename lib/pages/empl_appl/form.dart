import 'package:flutter/material.dart';
import 'package:hris/model/health_condition_model.dart';
import 'package:hris/pages/empl_appl/components.dart';

class ApplForm extends StatefulWidget {
  final groupedTextField = GroupedTextField.fromFields(const ["Last Name", "First Name", "Middle Name", "Name Extension"]);
  final bDatePicker = CustomDatePicker();
  final genderDropdown = CustomDropdown(list: const [
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
  final healthConditions = VecList.customBuild(
    "Enter Health Condition if you have any", 
    () => HealthConditionModel()
  );
  final citizenship = CustomTextField();
  final civilStat = CustomDropdown(list: const [
    DropdownMenuItem(
      value: "Single",
      child: Text("Single")
    ),
    DropdownMenuItem(
      value: "Married",
      child: Text("Married")
    ),
    DropdownMenuItem(
      value: "Separated",
      child: Text("Separated")
    ),
    DropdownMenuItem(
      value: "Widowed",
      child: Text("Widowed")
    ),
  ]);

  ApplForm({super.key});

  @override
  State<ApplForm> createState() => _ApplFormState();
}

class _ApplFormState extends State<ApplForm> {
  @override
  void initState() {
    super.initState();

    widget.healthConditions.format = (index) {
      var controller = TextEditingController(text: widget.healthConditions.list[index].healthCondition);
      controller.addListener(() {
        setState(() {
          widget.healthConditions.list[index].healthCondition = controller.text;
        });
      });
      return TextFormField(
        decoration: TextFieldDesign.build(""),
        controller: controller,
      );
    };

    widget.civilStat.additionalAction = () {
      print(widget.civilStat.val);
    };
  }
  
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
            widget.genderDropdown,
            const SizedBox(height: 60.0),
            const Label(labelName: "Last Check Up", widgetWidth: double.maxFinite),
            widget.lastChkUpDatePicker,
            const SizedBox(height: 60.0),
            const Label(labelName: "Health Conditions", widgetWidth: double.maxFinite),
            widget.healthConditions,
            const SizedBox(height: 60.0),
            const Label(labelName: "Citizenship", widgetWidth: double.maxFinite),
            widget.citizenship,
            const SizedBox(height: 60.0),
            const Label(labelName: "Civil Status", widgetWidth: double.maxFinite),
            widget.civilStat
          ],
        )
      ),
    );
  }
}