// Mixin: Schedulable
// Provides scheduling functionality for smart devices
mixin Schedulable {
  String? _scheduledTime;

  String? get scheduledTime => _scheduledTime;

  bool get isScheduled => _scheduledTime != null;

  void schedule(String time) {
    _scheduledTime = time;
  }

  void cancelSchedule() {
    _scheduledTime = null;
  }
}

