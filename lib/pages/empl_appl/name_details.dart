import 'package:flutter/material.dart';
import 'package:hris/pages/empl_appl/components.dart';

class NameForm extends StatefulWidget {
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final midNameController = TextEditingController();
  final nameExtController = TextEditingController();

  NameForm({super.key});

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  TextFormField _formFieldFormat(String label, TextEditingController controller) {
    return TextFormField(
      decoration: TextFieldDesign.build(label: label),
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all()
      ),
      child: Column(
        children: [
          _formFieldFormat("Last Name", widget.lastNameController),
          const SizedBox(height: 5.0),
          _formFieldFormat("First Name", widget.firstNameController),
          const SizedBox(height: 5.0),
          _formFieldFormat("Middle Name", widget.midNameController),
          const SizedBox(height: 5.0),
          _formFieldFormat("Middle Name", widget.nameExtController)
        ],
      )
    );
  }
}