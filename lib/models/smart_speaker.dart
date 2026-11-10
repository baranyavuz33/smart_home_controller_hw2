import 'smart_device.dart';

// SmartSpeaker extends SmartDevice
// Demonstrates: inheritance, super, this
class SmartSpeaker extends SmartDevice {
  bool isPlaying;
  int volume; // 0-100
  String currentTrack;

  // Default constructor using super
  SmartSpeaker(super.name, super.location,
      {this.isPlaying = false, this.volume = 50, this.currentTrack = 'No track'});

  // Named constructor using super
  SmartSpeaker.withDefaults(
      {required super.name, this.isPlaying = false, this.volume = 30, this.currentTrack = 'No track'})
      : super.withDefaults();

  @override
  String getStatus() {
    return isPlaying ? 'Playing: $currentTrack (Vol: $volume%)' : 'Paused (Vol: $volume%)';
  }

  @override
  void performAction() {
    isPlaying = !isPlaying;
  }

  void setVolume(int value) {
    volume = value.clamp(0, 100);
  }
}
