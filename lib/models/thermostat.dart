import 'smart_device.dart';
import 'schedulable.dart';

// Thermostat extends SmartDevice and uses Schedulable mixin
// Demonstrates: inheritance, super, this
class Thermostat extends SmartDevice with Schedulable {
  double temperature; // in Celsius
  bool isHeating;

  // Default constructor using super
  Thermostat(super.name, super.location, {this.temperature = 22.0, this.isHeating = false});

  // Named constructor using super
  Thermostat.withDefaults({required super.name, this.temperature = 20.0, this.isHeating = false})
      : super.withDefaults();

  @override
  String getStatus() {
    return isHeating
        ? 'Heating to ${temperature.toStringAsFixed(1)}°C'
        : 'Idle at ${temperature.toStringAsFixed(1)}°C';
  }

  @override
  void performAction() {
    isHeating = !isHeating;
  }

  void setTemperature(double value) {
    temperature = value.clamp(10.0, 35.0);
  }

  void increaseTemperature() {
    setTemperature(temperature + 0.5);
  }

  void decreaseTemperature() {
    setTemperature(temperature - 0.5);
  }
}
