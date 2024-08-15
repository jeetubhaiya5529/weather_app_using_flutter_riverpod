// WeatherState class to hold the weather data
class WeatherState {
  final String location;
  final String weatherIcon;
  final int temperature;
  final int humidity;
  final int windSpeed;
  final int cloud;
  final String currentDate;
  final String currentWeatherStatus;
  final List<dynamic> hourWeatherForecast;
  final List<dynamic> dailyWeatherForecast;

  WeatherState({
    required this.location,
    required this.weatherIcon,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.cloud,
    required this.currentDate,
    required this.currentWeatherStatus,
    required this.hourWeatherForecast,
    required this.dailyWeatherForecast,
  });

  // Initial state with default values
  factory WeatherState.initial() {
    return WeatherState(
      location: 'Delhi',
      weatherIcon: 'weather.png',
      temperature: 0,
      humidity: 0,
      windSpeed: 0,
      cloud: 0,
      currentDate: '',
      currentWeatherStatus: '',
      hourWeatherForecast: [],
      dailyWeatherForecast: [],
    );
  }
}