import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String labelName;
  final double widgetWidth;

  const Label({super.key, required this.labelName, required this.widgetWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widgetWidth,
      child: Text(
        labelName,
        textAlign: TextAlign.left,
      )
    );
  }
}

class TextFieldDesign {
  String? label;

  TextFieldDesign({this.label});

  static InputDecoration build({String? label}) {
    return TextFieldDesign(label: label)._build();
  } 

  InputDecoration _build() {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black
        )
      )
    );
  }
}

InputDecoration textFieldDesign({String? label}) {
  return InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black
      )
    )
  );
}

class Datepicker extends StatefulWidget {
  final DateTime start;
  final DateTime end;

  const Datepicker({super.key, required this.start, required this.end});

  @override
  State<Datepicker> createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  final controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: TextFieldDesign.build(),
      controller: controller,
      onTap: _modFn(context),
    );
  }

  void Function() _modFn(BuildContext context) {
    modSetState(DateTime refDate) {
      return () {
        var newDate = "${refDate.month}/${refDate.day}/${refDate.year}";
        controller.text = newDate;
      };
    } 

    return () async {
      final date = await showDatePicker(
        context: context, 
        firstDate: widget.start, 
        lastDate: widget.end
      );

      if (date != null) {
        setState(modSetState(date));
      }
    };
  }
}

class CustomDropdown extends StatefulWidget {
  final List<DropdownMenuItem<dynamic>> items;
  final dynamic Function(dynamic) onChanged;

  dynamic selectedVal;

  CustomDropdown({super.key, required this.items, required this.onChanged});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder()
      ),
      items: widget.items, 
      onChanged: (val) {
        widget.selectedVal = widget.onChanged(val);
      }
    );
  }
}

class VectorForm extends StatefulWidget {
  final List<dynamic> vecList = [];

  final String emptyLabel;
  final Widget Function(BuildContext, int) Function(List<dynamic>, void Function(int)) itemBuilder;
  final void Function(int) removeFn;
  final void Function() addFn;

  VectorForm({
    super.key, 
    required this.emptyLabel, 
    required this.itemBuilder, 
    required this.addFn, required this.removeFn
  });

  @override
  State<VectorForm> createState() => _VectorFormState();
}

class _VectorFormState extends State<VectorForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.vecList.isEmpty,
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(5.0))
            ),
            padding: const EdgeInsets.all(5.0),
            child: Text(
              widget.emptyLabel,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic
              ),
            )
          )
        ),

        Visibility(
          visible: widget.vecList.isNotEmpty,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black
              ),
              borderRadius: BorderRadius.circular(5.0)
            ),
            padding: const EdgeInsets.all(5.0),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: widget.itemBuilder(widget.vecList, widget.removeFn), 
              separatorBuilder: (_, __) => const SizedBox(height: 5.0), 
              itemCount: widget.vecList.length
            )
          )
        ),

        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                var item = widget.addFn();
                widget.vecList.
              }, 
              child: const Text('Add')
            )
          ]
        )
      ]
    );
  }
}