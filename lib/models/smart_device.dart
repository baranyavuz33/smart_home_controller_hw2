import 'connectable.dart';

// Abstract base class: SmartDevice
// Demonstrates: abstract class, abstraction, static keyword, constructor
abstract class SmartDevice implements Connectable {
  // Static variable to track total number of devices created
  static int deviceCount = 0;

  final String name;
  final String location;
  bool _isConnected = false;

  // Default constructor using 'this' keyword
  SmartDevice(this.name, this.location) {
    deviceCount++;
  }

  // Named constructor using 'this' keyword
  SmartDevice.withDefaults({required this.name, this.location = 'Living Room'}) {
    deviceCount++;
  }

  // Abstract method - must be implemented by subclasses
  String getStatus();

  // Abstract method - device-specific action
  void performAction();

  // Interface implementation: Connectable
  @override
  bool get isConnected => _isConnected;

  @override
  void connect() {
    _isConnected = true;
  }

  @override
  void disconnect() {
    _isConnected = false;
  }

  // Static method to get total device count
  static int getTotalDevices() {
    return deviceCount;
  }
}

