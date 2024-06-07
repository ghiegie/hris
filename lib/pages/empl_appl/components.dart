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

class GroupedTextField extends StatefulWidget {
  final List<String> textFields;
  final List<Widget> widgetList = [];

  GroupedTextField({super.key, required this.textFields});

  factory GroupedTextField.fromFields(List<String> textFields) {
    var res = GroupedTextField(textFields: textFields);

    for (var val in textFields) {
      res.widgetList.add(
        TextFormField(
          decoration: TextFieldDesign.build(val),
          controller: TextEditingController()
        )
      );
    }

    return res;
  }

  @override
  State<GroupedTextField> createState() => _GroupedTextFieldState();
}

class _GroupedTextFieldState extends State<GroupedTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all()
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: _itemBuilder, 
        separatorBuilder: _separatorbuilder, 
        itemCount: widget.textFields.length
      ),
    );
  }

  Widget _separatorbuilder(BuildContext ctx, int index) {
    return const SizedBox(height: 5.0);
  }

  Widget _itemBuilder(BuildContext ctx, int index) {
    return widget.widgetList[index];
  }
}

class TextFieldDesign {
  final String label;

  TextFieldDesign(this.label);

  static InputDecoration build(String label) {
    return TextFieldDesign(label)._build();
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

class CustomDatePicker extends StatefulWidget {
  final controller = TextEditingController();

  CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: TextFieldDesign.build(""),
      onTap: _onTap,
    );
  }

  void _onTap() async {
    final date = await showDatePicker(context: context, firstDate: DateTime(0), lastDate: DateTime.now());

    if (date != null) {
      setState(_onTapSetState(date));
    }
  }

  void Function() _onTapSetState(DateTime refDate) {
    return () {
      widget.controller.text ="${refDate.month}/${refDate.day}/${refDate.year}";
    };
  }
}

class CustomDropdown extends StatefulWidget {
  final List<DropdownMenuItem<dynamic>> list;
  dynamic val;
  void Function()? additionalAction;

  CustomDropdown({super.key, required this.list, this.additionalAction});

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
      items: widget.list, 
      onChanged: _onChange
    );
  }

  void _onChange(dynamic val) {
    if (widget.additionalAction != null) {
      widget.additionalAction!();
    }

    

    void Function() onChangeSetState(dynamic val) {
      return () => widget.val = val;
    }

    setState(onChangeSetState(val));
  }
}

class VecList<T> extends StatefulWidget {
  final String emptyLabel;
  final List<T> list = [];
  late final void Function() addFunc;
  late final Widget Function(int)? format;

  VecList({super.key, required this.emptyLabel});

  factory VecList.customBuild(String label, T Function() factory) {
    VecList<T> res = VecList(emptyLabel: label);

    res.addFunc = () {
      T item = factory();
      res.list.add(item);
    };
    
    return res;
  }

  @override
  State<VecList<T>> createState() => _VecListState<T>();
}

class _VecListState<T> extends State<VecList<T>> {
  var _isThereItem = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !_isThereItem,
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
            ),
          )
        ),

        Visibility(
          visible: _isThereItem,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black
              ),
              borderRadius: BorderRadius.circular(5.0)
            ),
            padding: const EdgeInsets.all(5.0),
            child: ListView.separated(
              itemCount: widget.list.length,
              shrinkWrap: true,
              itemBuilder: _itemBuilder(),
              separatorBuilder: _separatorBuilder,
            ),
          )
        ),

        const SizedBox(height: 5.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: _addItem, 
              child: const Text("Add")
            )
          ],
        ),
      ],
    );
  }

  void _addItem() {
    void addItemSetState() {
      _isThereItem = true;
      widget.addFunc();
    }

    setState(addItemSetState);
  }

  Widget _separatorBuilder(BuildContext ctx, int index) => const SizedBox(height: 5.0);

  Widget Function(BuildContext ctx, int index) _itemBuilder() {
    return (ctx, index) {
      late Widget toShow;
      
      try {
        toShow = widget.format == null ? const Text("Error") : widget.format!(index);
      } catch (_) {
        toShow = const Text("Error");
      }

      return Row(
        children: [
          Expanded(child: toShow),
          const SizedBox(width: 5.0),
          ElevatedButton(
            onPressed: _remove(index), 
            child: const Text("Remove")
          )
        ],
      );
    };
  }

  void Function() _remove(int index) {
    void removeSetState() {
      widget.list.removeAt(index);
      if (widget.list.isEmpty) {
        _isThereItem = false;
      }
    }

    return () {
      setState(removeSetState);
    };
  }
}

class CustomTextField extends StatefulWidget {
  final controller = TextEditingController();

  CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: TextFieldDesign.build(""),
    );
  }
}