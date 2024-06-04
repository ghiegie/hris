import 'package:uuid/uuid.dart';

class HealthConditionModel {
  String? healthCondition;
  final uuid = const Uuid().v1();

  HealthConditionModel([this.healthCondition]);

  void nameHealthCondition(String name) {
    healthCondition = name;
  }
}