abstract class TimeState {}

class TimeInitial extends TimeState {}

class TimeTick extends TimeState {
  final String currentTime;
  TimeTick(this.currentTime);
}
