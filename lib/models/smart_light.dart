import 'smart_device.dart';
import 'schedulable.dart';

// SmartLight extends SmartDevice and uses Schedulable mixin
// Demonstrates: inheritance, super, this, mixin usage
class SmartLight extends SmartDevice with Schedulable {
  bool isOn;
  int brightness; // 0-100

  // Default constructor using super to call parent constructor
  SmartLight(super.name, super.location, {this.isOn = false, this.brightness = 50});

  // Named constructor using super
  SmartLight.withDefaults({required super.name, this.isOn = false, this.brightness = 70})
      : super.withDefaults();

  // Override abstract method from SmartDevice
  @override
  String getStatus() {
    return isOn ? 'On (Brightness: $brightness%)' : 'Off';
  }

  @override
  void performAction() {
    isOn = !isOn;
  }

  void setBrightness(int value) {
    brightness = value.clamp(0, 100);
  }
}
