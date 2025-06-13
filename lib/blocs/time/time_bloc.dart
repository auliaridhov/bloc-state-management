import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'time_event.dart';
import 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  StreamSubscription<String>? _ticker;

  TimeBloc() : super(TimeInitial()) {
    on<StartClock>(_onStartClock);
    on<_TimeUpdated>(_onTimeUpdated);
  }

  void _onStartClock(StartClock event, Emitter<TimeState> emit) {
    _ticker?.cancel();

    // Membuat stream waktu setiap detik
    _ticker = Stream<String>.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      return DateFormat.Hms().format(now); // Format HH:mm:ss
    }).listen((formattedTime) {
      add(_TimeUpdated(formattedTime));
    });
  }

  void _onTimeUpdated(_TimeUpdated event, Emitter<TimeState> emit) {
    emit(TimeTick(event.time));
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}

// Event internal (tidak diekspor ke file lain)
class _TimeUpdated extends TimeEvent {
  final String time;
  _TimeUpdated(this.time);
}
