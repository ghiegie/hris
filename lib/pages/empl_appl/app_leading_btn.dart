import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeadingBtn extends StatefulWidget {
  const LeadingBtn({super.key});

  @override
  State<LeadingBtn> createState() => _LeadingBtnState();
}

class _LeadingBtnState extends State<LeadingBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: _leadingOnPress, icon: const Icon(Icons.arrow_back));
  }

  void _leadingOnPress() => showDialog(context: context, builder: _dialogBuilder);

  Widget _dialogBuilder(BuildContext buildContext) {
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
              TextButton(onPressed: _exitApplication, child: const Text("Yes")),
              const SizedBox(width: 10.0),
              TextButton(onPressed: _cancelExit, child: const Text("No")),
            ]
          )
        ],
      )
    );
  }

  void _exitApplication() => context.go("/landing");

  void _cancelExit() => context.pop();
}