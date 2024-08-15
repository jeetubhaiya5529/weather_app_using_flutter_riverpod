import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waether_app_using_riverpod/model/model.dart';
import 'package:waether_app_using_riverpod/provider/weather_notifier.dart';

final weatherProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
  return WeatherNotifier();
});