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
  late dynamic val;

  CustomDropdown({super.key, required this.list});

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
    setState(_onChangeSetState(val));
  }

  void Function() _onChangeSetState(dynamic val) {
    return () => widget.val = val;
  }
}

class VecList2<T> extends StatefulWidget {
  final String emptyLabel;
  final List<T> list = [];

  VecList2({super.key, required this.emptyLabel});

  @override
  State<VecList2<T>> createState() => _VecList2State<T>();
}

class _VecList2State<T> extends State<VecList2<T>> {
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
    setState(_addItemSetState);
  }

  void _addItemSetState() {
    _isThereItem = true;
    widget.list.add(dynamic as T);
  }

  Widget _separatorBuilder(BuildContext ctx, int index) => const SizedBox(height: 5.0);

  Widget Function(BuildContext ctx, int index) _itemBuilder() {
    return (ctx, index) {
      return const Text("asdas");
    };
  }
}

class VecList extends StatefulWidget {
  final String emptyLabel;
  final List<dynamic> list = [];

  VecList({super.key, required this.emptyLabel});

  @override
  State<VecList> createState() => _VecListState();
}

class _VecListState extends State<VecList> {
  var _isThereItem = false;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        //Label(labelName: "Health Condition", widgetWidth: boxConstraints.maxWidth),

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

        const SizedBox(height: 10.0),
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
    setState(_addItemSetState);
  }

  void _addItemSetState() {
    _isThereItem = true;
    widget.list.add(dynamic);
  }

  Widget _separatorBuilder(BuildContext ctx, int index) => const SizedBox(height: 5.0);

  Widget Function(BuildContext ctx, int index) _itemBuilder() {
    return (ctx, index) {
      return const Text("asdas");
    };
  }
}

class VecItem extends StatefulWidget {
  final healtConditionName = TextEditingController();
  final int index;

  VecItem({super.key, required this.index});

  @override
  State<VecItem> createState() => _VecItemState();
}

class _VecItemState extends State<VecItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: TextFieldDesign.build(""),
            controller: widget.healtConditionName
          )
        ),
        const SizedBox(width: 5.0),
        ElevatedButton(
          onPressed: () {}, 
          child: const Text("Remove")
        )
      ],
    );
  }
}

class Something<T> {

}