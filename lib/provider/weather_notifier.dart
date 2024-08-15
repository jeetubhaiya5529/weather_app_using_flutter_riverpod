import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:waether_app_using_riverpod/model/model.dart';

// WeatherNotifier class to manage the weather state
class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(WeatherState.initial()) {
    fetchInitialWeatherData();
  }

  static const String apiKey = '0494f5f4c0584c4c80d72047241208';
  final String currentBaseUrl = 'http://api.weatherapi.com/v1/current.json';
  final String forecastBaseUrl = 'http://api.weatherapi.com/v1/forecast.json';

  // Fetch initial weather data for the default location
  Future<void> fetchInitialWeatherData() async {
    await fetchWeatherData('Lucknow'); // Change to your desired default location
  }

  // Method to fetch weather data based on city
  Future<void> fetchWeatherData(String city) async {
    if (city.isEmpty) return;

    try {
      // Fetch current weather data
      final currentResponse =
          await http.get(Uri.parse('$currentBaseUrl?key=$apiKey&q=$city'));
      // print('Current Response status: ${currentResponse.statusCode}');
      // print('Current Response body: ${currentResponse.body}');

      if (currentResponse.statusCode == 200) {
        final currentWeatherData = json.decode(currentResponse.body);

        // Fetch forecast data
        final forecastResponse = await http
            .get(Uri.parse('$forecastBaseUrl?key=$apiKey&q=$city&days=7'));
        // print('Forecast Response status: ${forecastResponse.statusCode}');
        // print('Forecast Response body: ${forecastResponse.body}');

        if (forecastResponse.statusCode == 200) {
          final forecastWeatherData = json.decode(forecastResponse.body);
          var locationData = currentWeatherData['location'];
          var currentWeather = currentWeatherData['current'];
          var forecastData = forecastWeatherData['forecast']['forecastday'];

          // Ensure forecastData exists
          if (forecastData != null && forecastData.isNotEmpty) {
            // Extract hourly forecast for the current day
            List<dynamic> hourForecast = forecastData[0]['hour'];

            // Extract daily forecast
            List<dynamic> dailyForecast = forecastData.map((day) {
              return {
                'date': day['date'],
                'maxTemp': day['day']['maxtemp_c'],
                'minTemp': day['day']['mintemp_c'],
                'condition': day['day']['condition']['text'],
                'icon': day['day']['condition']['icon'],
              };
            }).toList();

            var parsedDate = DateTime.parse(locationData["localtime"]);
            var newDate = DateFormat('MMMMEEEEd').format(parsedDate);

            state = WeatherState(
              location: getShortLocationName(locationData['name']),
              weatherIcon:
                  '${currentWeather['condition']['text'].replaceAll(' ', '').toLowerCase()}.png',
              temperature: currentWeather['temp_c'].toInt(),
              humidity: currentWeather['humidity'].toInt(),
              windSpeed: currentWeather['wind_kph'].toInt(),
              cloud: currentWeather['cloud'].toInt(),
              currentDate: newDate,
              currentWeatherStatus: currentWeather['condition']['text'],
              hourWeatherForecast: hourForecast,
              dailyWeatherForecast: dailyForecast,
            );
          } else {
            // print('Error: forecast data is null or malformed');
          }
        } else {
          // print(
          //     'Error: ${forecastResponse.statusCode}, Body: ${forecastResponse.body}');
        }
      } else {
        // print(
        //     'Error: ${currentResponse.statusCode}, Body: ${currentResponse.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  static String getShortLocationName(String s) {
    List<String> wordList = s.split(' ');

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return '${wordList[0]} ${wordList[1]}';
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }
}
