import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _leadingBtnOnPress, 
          icon: const Icon(Icons.arrow_back)
        ),
        title: const Text("Welcome"),
      ),
      body: LayoutBuilder(builder: _landingLayoutBuilder),
    );
  }

  Widget _landingLayoutBuilder(BuildContext buildContext, BoxConstraints boxConstraints) {
    return Center(
      child: Container(
        width: boxConstraints.maxWidth / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _gotoApplication, child: const Text("Employee Application")),
            const SizedBox(height: 10.0),
            ElevatedButton(onPressed: _gotoIDCreate, child: const Text("ID Creation"))
          ],
        )
      ),
    );
  }

  void _gotoApplication() {
    context.go("/landing/empl_appl");
  }

  void _gotoIDCreate() {
    context.go("/landing/id_maker");
  }

  void _leadingBtnOnPress() {
    showDialog(
      context: context, 
      builder: _dialogBuilder
    );
  }

  Widget _dialogBuilder(BuildContext buildContext) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Log out the application?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: _exitLanding, 
                child: const Text("Yes")
              ),
              const SizedBox(width: 10.0),
              TextButton(
                onPressed: _exitCancel, 
                child: const Text("No")
              ),
            ],
          )
        ],
      )
    );
  }

  void _exitLanding() {
    context.go("/");
  }

  void _exitCancel() {
    context.pop();
  }
}