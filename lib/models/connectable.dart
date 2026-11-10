// Interface: Connectable
// Defines connectivity behavior for smart devices
abstract class Connectable {
  bool get isConnected;
  void connect();
  void disconnect();
}

