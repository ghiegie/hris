import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget appbarLeadingBtn(BuildContext context) {
  return IconButton(
    onPressed: _leadingOnPressed(context), 
    icon: const Icon(Icons.arrow_back)
  );
}

void Function() _leadingOnPressed(BuildContext context) {
  return () => showDialog(
    context: context, 
    builder: _builder
  ); 
}

Widget _builder(BuildContext context) {
  return Dialog(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Leave application form?"),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(onPressed: _exitApplication(context), child: const Text("Yes")),
            const SizedBox(width: 10.0),
            TextButton(onPressed: _cancelExit(context), child: const Text("No")),
          ]
        )
      ],
    )    
  );
}

void Function() _exitApplication(BuildContext context) {
  return () => context.go("/landing");
}

void Function() _cancelExit(BuildContext context) {
  return () => context.pop();
}