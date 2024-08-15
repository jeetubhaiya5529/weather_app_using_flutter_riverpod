import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waether_app_using_riverpod/provider/provider.dart';
import 'package:waether_app_using_riverpod/widget/constants.dart';

class DetailPage extends ConsumerStatefulWidget {
  final List<dynamic> dailyForecastWeather;

  const DetailPage({super.key, required this.dailyForecastWeather});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  final Constants _constants = Constants();

  // Map<String, dynamic> getForecastWeather(int index) {
  //   if (index < 0 || index >= widget.dailyForecastWeather.length) {
  //     print('Index $index is out of bounds for dailyForecastWeather');
  //     return {};
  //   }

  //   var forecastData = widget.dailyForecastWeather[index];

  //   print('Forecast data for index $index: $forecastData');

  //   int maxWindSpeed = forecastData["day"]?["maxwind_kph"]?.toInt() ?? 0;
  //   int avgHumidity = forecastData["day"]?["avghumidity"]?.toInt() ?? 0;
  //   int chanceOfRain = forecastData["day"]?["day_chance_of_rain"]?.toInt() ?? 0;

  //   var parsedDate = DateTime.parse(forecastData["date"]);
  //   var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

  //   String weatherName =
  //       forecastData["day"]?["condition"]?["text"] ?? "Unknown";

  //   String weatherIcon = "${weatherName.replaceAll(' ', '').toLowerCase()}.png";

  //   String assetPath = 'assets/$weatherIcon';

  //   int minTemperature = forecastData["day"]?["mintemp_c"]?.toInt() ?? 0;
  //   int maxTemperature = forecastData["day"]?["maxtemp_c"]?.toInt() ?? 0;

  //   var result = {
  //     'maxWindSpeed': maxWindSpeed,
  //     'avgHumidity': avgHumidity,
  //     'chanceOfRain': chanceOfRain,
  //     'forecastDate': forecastDate,
  //     'weatherName': weatherName,
  //     'weatherIcon': assetPath,
  //     'minTemperature': minTemperature,
  //     'maxTemperature': maxTemperature
  //   };
  //   print(result.toString());

  //   return result;
  // }

  // bool isAssetAvailable(String path) {
  //   // Implement your own logic to check asset availability if needed.
  //   return true; // Placeholder for asset checking
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final weatherState = ref.watch(weatherProvider);
    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        title: const Text(
          'Forecasts',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: _constants.primaryColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                print('Settings Tapped');
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 300,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [
                            Color(0xffa9c1f5),
                            Color(0xff6696f5),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.1),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            width: 150,
                            child: Image.asset(weatherState.weatherIcon),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 10,
                            child: Text(
                              weatherState.location,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Positioned(
                          //   bottom: 0,
                          //   left: 10,
                          //   child: Text(
                          //     weatherState.maxWindSpeed.toString(),
                          //     style: const TextStyle(
                          //       fontSize: 16,
                          //       color: Colors.black54,
                          //     ),
                          //   ),
                          // ),
                          // Positioned(
                          //   bottom: 50,
                          //   left: 10,
                          //   child: Text(
                          //     getForecastWeather(0)["weatherName"],
                          //     style: TextStyle(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
