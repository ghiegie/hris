import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmployeeApplicationPage extends StatefulWidget {
  const EmployeeApplicationPage({super.key});

  @override
  State<EmployeeApplicationPage> createState() => _EmployeeApplicationPageState();
}

class _EmployeeApplicationPageState extends State<EmployeeApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context, 
              builder: (ctx) {
                return Dialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Exit Employee Application?"),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.resolveWith((states) {
                                  return const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                                  );
                                })
                              ),
                              onPressed: () {
                                context.go("/landing/empl_appl");
                              }, 
                              child: const Text("Yes")
                            ),
                            const SizedBox(width: 20.0),
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.resolveWith((states) {
                                  return const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                                  );
                                })
                              ),
                              onPressed: () {}, 
                              child: const Text("No")
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                );
              }
            );
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: const Placeholder()
    );
  }
}