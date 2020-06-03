import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateCrontorlller = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateCrontorlller;
  // For state, exposing only a stream which outputs data
  Stream<int> get counter => _counterStateCrontorlller.stream;

  final _counterEventController = StreamController<CounterEvent>();
  // For events, exposing only a sink which is an input
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    // Whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }
  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateCrontorlller.close();
    _counterEventController.close();
  }
}
