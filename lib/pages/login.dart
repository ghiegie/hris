import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/app_config/config.dart';
import 'package:hris/main.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final Future<String> _dbLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showLoginInvalidUserPwd = false;

  final _userTxtController = TextEditingController();
  final _pwdTxtController = TextEditingController();

  Future<String> _databasepath(String configLoc) async {
    final file = File(configLoc);
    final contents = await file.readAsString();
    final parsedJSON = jsonDecode(contents) as Map<String, dynamic>;
    final config = Config.fromJson(parsedJSON);
    return config.database.location;
  }

  @override
  void initState() {
    super.initState();
    _dbLocation = _databasepath("D:\\projects\\hris\\HRIS_Data\\config.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _dbLocation, 
        builder: _futureBuilder
      )
    );
  }

  Widget _futureBuilder(BuildContext buildContext, AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data != null) {
        ref.watch(appModel).database = snapshot.data!;
        return _okStage();
      } else {
        return const _ErrLogin(errMsg: "Config File not found");
      }
    }

    if (snapshot.hasError) {
      return const _ErrLogin(errMsg: "Error finding file");
    }

    return _loadingStage();
  }

  Widget _loadingStage() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: const Color.fromARGB(255, 211, 206, 206),
          color: Theme.of(context).colorScheme.primary,
        ),
      )
    );
  }

  Widget _okStage() {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(builder: _form)
      )
    );
  }

  Widget _form(BuildContext buildContext, BoxConstraints boxConstraints) {
    final double newWidth = boxConstraints.maxWidth / 3.0;

    return Form(
      key: _formKey,
      child: SizedBox(
        width: newWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _showLoginInvalidUserPwd,
              child: const Text(
                "Invalid Password",
                style: TextStyle(
                  color: Colors.red
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              
              controller: _userTxtController,
              decoration: txtFieldDesign("Username"),
              validator: _validatorFunc("Enter username"),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _pwdTxtController,
              decoration: txtFieldDesign("Password"),
              validator: _validatorFunc("Enter password"),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _eBtnOnPressed, 
              child: const Text("Submit")
            )
          ]
        ),
      )
    );
  }

  String? Function(String?)? _validatorFunc(String prompt) {
    return (String? val) {
      if (val == null || val.isEmpty) {
        return prompt;
      }
      return null;
    };
  }

  InputDecoration txtFieldDesign(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black
        )
      )
    );
  }

  void _eBtnOnPressed() async {
    if (_formKey.currentState!.validate()) {
      var dbLoc = ref.watch(appModel).database;

      sqfliteFfiInit();
      var dbFactory = databaseFactoryFfi;
      var db = await dbFactory.openDatabase(dbLoc);

      var res = (await db.rawQuery("select * from app_clients where user='${_userTxtController.text}' AND pwd='${_pwdTxtController.text}'")).isEmpty;

      setState(() {
        _showLoginInvalidUserPwd = res;
      });

      if (!_showLoginInvalidUserPwd) {
        var refCtx = context;
        if (refCtx.mounted) {
          _userTxtController.text = "";
          _pwdTxtController.text = "";
          refCtx.go("/landing");
        }
      }
    }
  }
}

class _ErrLogin extends StatefulWidget {
  final String errMsg;

  const _ErrLogin({required this.errMsg});

  @override
  State<_ErrLogin> createState() => __ErrLoginState();
}

class __ErrLoginState extends State<_ErrLogin> {
  int _timeOut = 10;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
  }

  void _timerCallback(Timer timer) {
    if (_timeOut == 0) {
      _timer.cancel();
      exit(69);
    } 

    setState(_timeOutChanger);
  }

  void _timeOutChanger() => _timeOut -= 1;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("${widget.errMsg}. Exiting in $_timeOut")
    );
  }
}