import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/model/addr_model.dart';
import 'package:hris/model/health_condition_model.dart';
import 'package:hris/pages/empl_appl/app_leading_btn.dart';
import 'package:hris/pages/empl_appl/form.dart';

class EmployeeApplicationPage extends StatefulWidget {
  const EmployeeApplicationPage({super.key});

  @override
  State<EmployeeApplicationPage> createState() => _EmployeeApplicationPageState();
}

class _EmployeeApplicationPageState extends State<EmployeeApplicationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _midNameController = TextEditingController();
  final _nameExtController = TextEditingController();

  var _birthDate = "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}";
  final _bdateController = TextEditingController();

  var _lastChkUp = "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}";
  final _lastChkUpController = TextEditingController();

  late String _gender;

  var _isThereHealhCondition = false;
  final List<HealthConditionModel> _healthConditions = [];

  final _citizenshipController = TextEditingController();

  String? _civilStatus;

  final _spouseController = TextEditingController();
  final _occupController = TextEditingController();
  final _officeAddrController = TextEditingController();
  final _childCountController = TextEditingController();

  var _isThereAddress = false;
  final List<AddrModel> _addresses = [];
  int _isMailAddrIndex = 0;
  bool _isTherePermAddr = false;
  int _permAddrIndex = 0;

  @override
  void initState() {
    super.initState();
    _bdateController.text = "";
    _lastChkUpController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Application Form"),
        leading: const LeadingBtn()//IconButton(onPressed: _leadingOnPress, icon: const Icon(Icons.arrow_back))
      ),
      body: ApplForm()
      // body: Center(
      //   child: Form(
      //     child: LayoutBuilder(builder: _formBuilder)
      //   ),
      // ),
    );
  }

  Widget _formBuilder(BuildContext buildContext, BoxConstraints boxConstraints) {
    var newWidth = boxConstraints.maxWidth * 0.75;

    return SizedBox(
      width: newWidth,
      child: ListView(
        children: [
          //Label(labelName: "Name Details", widgetWidth: boxConstraints.maxWidth),
          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all()
            ),
            child: Column(
              children: [
                TextFormField(
                  decoration: txtFieldDesign("Last Name"),
                  controller: _lastNameController,
                ),
                const SizedBox(height: 5.0),
                TextFormField(
                  decoration: txtFieldDesign("First Name"),
                  controller: _firstNameController,
                ),
                const SizedBox(height: 5.0),
                TextFormField(
                  decoration: txtFieldDesign("Middle Name"),
                  controller: _midNameController,
                ),
                const SizedBox(height: 5.0),
                TextFormField(
                  decoration: txtFieldDesign("Name Extension"),
                  controller: _nameExtController,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60.0),

          //Label(labelName: "Birthday", widgetWidth: boxConstraints.maxWidth),
          TextFormField(
            onTap: _modBirthDay,
            readOnly: true,
            decoration: txtFieldDesign(""),
            controller: _bdateController,
          ),
          const SizedBox(height: 10.0),

          //Label(labelName: "Gender", widgetWidth: boxConstraints.maxWidth),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border: OutlineInputBorder()
            ),
            items: const [
              DropdownMenuItem(
                value: "Male",
                child: Text("Male")
              ),
              DropdownMenuItem(
                value: "Female",
                child: Text("Female")
              ),
            ], 
            onChanged: _genderChange
          ),
          const SizedBox(height: 60.0),

          //Label(labelName: "Last Checkup Date", widgetWidth: boxConstraints.maxWidth),
          TextFormField(
            readOnly: true,
            decoration: txtFieldDesign(""),
            controller: _lastChkUpController,
            onTap: _modLastChkUp,
          ),
          const SizedBox(height: 60.0),

          Column(
            children: [
              //Label(labelName: "Health Condition", widgetWidth: boxConstraints.maxWidth),

              Visibility(
                visible: !_isThereHealhCondition,
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0))
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: const Text(
                    "Add Health Condtions you currently have.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                )
              ),

              Visibility(
                visible: _isThereHealhCondition,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.separated(
                    itemCount: _healthConditions.length,
                    shrinkWrap: true,
                    itemBuilder: _healthCondListBuilder(),
                    separatorBuilder: (_, __) => const SizedBox(height: 5.0),
                  ),
                )
              ),

              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () {
                    setState(_addHealthConditionSetState);
                  }, child: const Text("Add"))
                ],
              ),
            ],
          ),

          const SizedBox(height: 60.0),

          //Label(labelName: "Citizenship", widgetWidth: boxConstraints.maxWidth),
          TextFormField(
            decoration: txtFieldDesign("Citizenship"),
            controller: _citizenshipController,
          ),

          const SizedBox(height: 60.0),

          //Label(labelName: "Civil Status", widgetWidth: boxConstraints.maxWidth),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border: OutlineInputBorder()
            ),
            items: const [
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
            ], 
            onChanged: _civilStatusChange
          ),
          const SizedBox(height: 10.0),
          Visibility(
            visible: _civilStatus != null && _civilStatus == "Married",
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all()
              ),
              child: Column(
                children: [
                  TextFormField(
                    decoration: txtFieldDesign("Spouse"),
                    controller: _spouseController,
                  ),
                  const SizedBox(height: 5.0),
                  TextFormField(
                    decoration: txtFieldDesign("Occupation"),
                    controller: _occupController,
                  ),
                  const SizedBox(height: 5.0),
                  TextFormField(
                    decoration: txtFieldDesign("Office Address"),
                    controller: _officeAddrController,
                  ),
                  const SizedBox(height: 5.0),
                  TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: txtFieldDesign("Child Count"),
                    controller: _childCountController,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 60.0),

          Column(
            children: [
              //Label(labelName: "Address", widgetWidth: boxConstraints.maxWidth),
              Visibility(
                visible: !_isThereAddress,
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0))
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: const Text(
                    "Add Addresses. There must be at least ONE Permanent Address",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                )
              ),

              Visibility(
                visible: _isThereAddress,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.separated(
                    itemCount: _addresses.length,
                    shrinkWrap: true,
                    itemBuilder: _addrListBuilder(),
                    separatorBuilder: (_, __) => const SizedBox(height: 5.0),
                  ),
                )
              ),

              const SizedBox(height: 10.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: _addAddress, child: const Text("Add"))
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 60.0),
        ],  
      )
    );
  }

  Widget? Function(BuildContext, int) _addrListBuilder() {
    return (BuildContext context, int index) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(5.0))
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: Row(
                children: [
                  const Text("Is this your mailing address"),
                  const SizedBox(width: 5.0),
                  Checkbox(
                    value: _isMailAddrIndex == index, 
                    onChanged: (val) {
                      setState(() {
                        _isMailAddrIndex = index;
                        _addresses[index].isMailAddr = _isMailAddrIndex == index;
                      });

                      if (val == true) {
                        setState(() {
                          for (var item in _addresses) {
                            item.addrType = AddrType.Temporary;
                          }
                        });
                        _permAddrIndex = index;
                      }

                      //_addresses[index].addrType = val;
                    }
                  )
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 5.0,
                right: 10.0
              ),
              child: DropdownButtonFormField(
                value: _addresses[index].addrType,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder()
                ),
                items: const [
                  DropdownMenuItem(
                    value: AddrType.Permanent,
                    child: Text("Permanent")
                  ),
                  DropdownMenuItem(
                    value: AddrType.Temporary,
                    child: Text("Temporary")
                  ),
                ], 
                onChanged: (val) {
                  if (val != null) {
                    if (val == AddrType.Permanent) {
                      setState(() {
                        for (var item in _addresses) {
                          item.addrType = AddrType.Temporary;
                        }
                      });
                      _permAddrIndex = index;
                    }

                    _addresses[index].addrType = val;
                  }
                }
              ),
            ),

            _AddrForm(addr: _addresses[index]),
            const SizedBox(width: 5.0),
            ElevatedButton(onPressed: _removeAddress(index), child: const Text("Remove")),
          ],
        ),
      );
    };
  }

  void Function() _removeAddress(int index) {
    return () {
      setState(() {
        if (index == _permAddrIndex && _addresses.length > 1) {
          return;
        }

        if (index == _isMailAddrIndex && _addresses.length > 1) {
          return;
        }

        _addresses.removeAt(index);
        if (_addresses.isEmpty) {
          _isMailAddrIndex = 0;
          _isThereAddress = false;
        }
      });
    };
  }

  void _addAddress() {
    setState(_addAddressSetState);
  }

  void _addAddressSetState() {
    _isThereAddress = true;
    _addresses.add(AddrModel(_addrTypeIdentifier(), _addrIsMailAddrIdentifier()));
  }

  bool _addrIsMailAddrIdentifier() {
    if (_addresses.isEmpty) {
      return true;
    }

    for (var item in _addresses) {
      if (item.isMailAddr == true) {
        return false;
      }
    }

    return true;
  }

  AddrType _addrTypeIdentifier() {
    if (_addresses.isEmpty) {
      _isTherePermAddr = true;
      return AddrType.Permanent;
    } 

    for (var item in _addresses) {
      if (item.addrType == AddrType.Permanent) {
        return AddrType.Temporary;
      }
    }

    _isTherePermAddr = true;
    return AddrType.Permanent;
  }

  void _civilStatusChange(String? civStat) => setState(_civilStatusChangeSetState(civStat));

  void Function() _civilStatusChangeSetState(String? refCivStat) => () {
    _civilStatus = refCivStat!;
    if (_civilStatus != "Married") {
      _spouseController.text = "";
      _occupController.text = "";
      _officeAddrController.text = "";
      _childCountController.text = "";
    }
  }; 

  Widget? Function(BuildContext, int) _healthCondListBuilder() {
    return (BuildContext context, int index) {
      var txtController = TextEditingController(text: _healthConditions[index].healthCondition ?? "");
      txtController.addListener(() {
        _healthConditions[index].healthCondition = txtController.text;
      });
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: txtFieldDesign(""),
                  controller: txtController
                )
              ),
              const SizedBox(width: 5.0),
              ElevatedButton(onPressed: _removeCondition(index), child: const Text("Remove"))
            ],
          ),
        ],
      );
    };
  }

  void Function() _removeCondition(int index) {
    return () {
      setState(() {
        _healthConditions.remove(_healthConditions[index]);

        if (_healthConditions.isEmpty) {
          _isThereHealhCondition = false;
        }
      });
    };
  }

  void _addHealthConditionSetState() {
    _isThereHealhCondition = true;
    _healthConditions.add(HealthConditionModel());
  } 

  void _modLastChkUp() async {
    final date = await showDatePicker(context: context, firstDate: DateTime(0), lastDate: DateTime.now());

    if (date != null) {
      setState(_modLastChkUpSetState(date));      
    }
  }

  void Function() _modLastChkUpSetState(DateTime refDate) {
    return () {
      _lastChkUp = "${refDate.month}/${refDate.day}/${refDate.year}";
      _lastChkUpController.text = _lastChkUp;
    };
  }

  void _genderChange(String? gender) => setState(_genderChangeSetState(gender));

  void Function() _genderChangeSetState(String? refGender) => () => _gender = refGender!;

  void _modBirthDay() async {
    final date = await showDatePicker(context: context, firstDate: DateTime(0), lastDate: DateTime.now());

    if (date != null) {
      setState(_modBirthDaySetState(date));
    }
  }

  void Function() _modBirthDaySetState(DateTime refDate) {
    return () {
      _birthDate = "${refDate.month}/${refDate.day}/${refDate.year}";
      _bdateController.text = _birthDate;
    };
  }

  InputDecoration txtFieldDesign(String? label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black
        )
      )
    );
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

// class Label extends StatelessWidget {
//   final String labelName;
//   final double widgetWidth;

//   const Label({super.key, required this.labelName, required this.widgetWidth});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widgetWidth,
//       child: Text(
//         labelName,
//         textAlign: TextAlign.left,
//       )
//     );
//   }
// }

class _AddrForm extends StatefulWidget {
  final AddrModel addr;

  const _AddrForm({required this.addr});
  @override
  State<_AddrForm> createState() => __AddrFormState();
}

class __AddrFormState extends State<_AddrForm> {
  @override
  Widget build(BuildContext context) {
    final unitNoController = TextEditingController(text: widget.addr.unitNo);
    unitNoController.addListener(() {
      widget.addr.unitNo = unitNoController.text;
    });

    final buildNameController = TextEditingController(text: widget.addr.buildName);
    buildNameController.addListener(() {
      widget.addr.buildName = buildNameController.text;
    });

    final buildNoController = TextEditingController(text: widget.addr.buildNo);
    buildNoController.addListener(() {
      widget.addr.buildNo = buildNoController.text;
    });

    final blkLotController = TextEditingController(text: widget.addr.blkLot);
    blkLotController.addListener(() {
      widget.addr.blkLot = blkLotController.text;
    });

    final streetController = TextEditingController(text: widget.addr.street);
    streetController.addListener(() {
      widget.addr.street = streetController.text;
    });

    final subdController = TextEditingController(text: widget.addr.subd);
    subdController.addListener(() {
      widget.addr.subd = subdController.text;
    });

    final brgyController = TextEditingController(text: widget.addr.brgy);
    brgyController.addListener(() {
      widget.addr.brgy = brgyController.text;
    });

    final muniCityController = TextEditingController(text: widget.addr.muniCity);
    muniCityController.addListener(() {
      widget.addr.muniCity = muniCityController.text;
    });

    final provController = TextEditingController(text: widget.addr.prov);
    provController.addListener(() {
      widget.addr.prov = provController.text;
    });

    final zipController = TextEditingController(text: widget.addr.zip);
    zipController.addListener(() {
      widget.addr.zip = zipController.text;
    });

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Unit No.",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: unitNoController
          ),

          const SizedBox(height: 5.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Building Name",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: buildNameController
          ),

          const SizedBox(height: 5.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Building No",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: buildNoController
          ),

          const SizedBox(height: 5.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Block/Lot No.",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: blkLotController
          ),

          const SizedBox(height: 5.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Street",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: streetController
          ),

          const SizedBox(height: 5.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Subdivision",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: subdController
          ),

          const SizedBox(height: 5.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Barangay",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: brgyController
          ),

          const SizedBox(height: 5.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Municipality/City",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: muniCityController
          ),

          const SizedBox(height: 5.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Province",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: provController
          ),

          const SizedBox(height: 5.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Zip Code",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              )
            ),
            controller: zipController
          ),
        ],
      ),
    );
  }
}
