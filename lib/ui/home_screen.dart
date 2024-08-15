import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waether_app_using_riverpod/provider/provider.dart';
import 'package:waether_app_using_riverpod/ui/component/weather_item.dart';
import 'package:waether_app_using_riverpod/ui/detail_screen.dart';
import 'package:waether_app_using_riverpod/widget/constants.dart';

class HomeScreen extends ConsumerWidget {
  final TextEditingController _cityController = TextEditingController();
  final Constants _constants = Constants();
  final weatherIcon = 'weather.png';

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);
    // print(weatherState.toString());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
        color: _constants.primaryColor.withOpacity(.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: size.height * .7,
              decoration: BoxDecoration(
                  gradient: _constants.linearGradientBlue,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: _constants.primaryColor.withOpacity(.6),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 5)),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/menu.png',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/pin.png',
                            width: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            weatherState.location,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {
                                _cityController.clear();
                                showBarModalBottomSheet(
                                    context: context,
                                    builder: (context) => SingleChildScrollView(
                                          controller:
                                              ModalScrollController.of(context),
                                          child: Container(
                                            height: size.height * .2,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 70,
                                                  child: Divider(
                                                    thickness: 3.5,
                                                    color:
                                                        _constants.primaryColor,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  onChanged: (searchText) {
                                                    ref
                                                        .read(weatherProvider
                                                            .notifier)
                                                        .fetchWeatherData(
                                                            _cityController
                                                                .text);
                                                  },
                                                  controller: _cityController,
                                                  autofocus: true,
                                                  decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.search,
                                                        color: _constants
                                                            .primaryColor,
                                                      ),
                                                      suffixIcon:
                                                          GestureDetector(
                                                        onTap: () {
                                                          _cityController
                                                              .clear();
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          color: _constants
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                      hintText:
                                                          'Search city e.g. London',
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: _constants
                                                                  .primaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10))),
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 20,
                              ))
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/man.png',
                          width: 35,
                          height: 35,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset('assets/$weatherIcon'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          weatherState.temperature.toString(),
                          style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = _constants.shader),
                        ),
                      ),
                      Text(
                        '°C',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = _constants.shader),
                      ),
                    ],
                  ),
                  Text(
                    weatherState.currentWeatherStatus,
                    style: const TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                  Text(
                    weatherState.currentDate,
                    style: const TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Divider(
                      color: Colors.white70,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeatherItem(
                            value: weatherState.windSpeed.toInt(),
                            unit: 'Km/h',
                            imageUrl: 'assets/windmill.png'),
                        WeatherItem(
                            value: weatherState.humidity.toInt(),
                            unit: '%',
                            imageUrl: 'assets/humidity.png'),
                        WeatherItem(
                            value: weatherState.cloud.toInt(),
                            unit: '%',
                            imageUrl: 'assets/cloudy.png')
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              height: size.height * .2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetailPage(
                                      dailyForecastWeather:
                                          weatherState.dailyWeatherForecast,
                                    ))),
                        child: Text(
                          'Forecasts',
                          style: TextStyle(
                              fontSize: 16, color: _constants.primaryColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                        itemCount: weatherState.hourWeatherForecast.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          String currentTime =
                              DateFormat('HH:mm:ss').format(DateTime.now());
                          String currentHour = currentTime.substring(0, 2);
                          String forecastTime = weatherState
                              .hourWeatherForecast[index]['time']
                              .substring(11, 16);
                          String forecastHour = weatherState
                              .hourWeatherForecast[index]['time']
                              .substring(11, 13);

                          String forecastWeatherName = weatherState
                              .hourWeatherForecast[index]['condition']['text'];
                          String forecastWeatherIcon =
                              "${forecastWeatherName.replaceAll(' ', '').toLowerCase()}.png";

                          String forecastTemperature = weatherState
                              .hourWeatherForecast[index]['temp_c']
                              .round()
                              .toString();

                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            margin: const EdgeInsets.only(right: 20),
                            width: 60,
                            decoration: BoxDecoration(
                              color: currentHour == forecastHour
                                  ? Colors.white
                                  : _constants.primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                    color:
                                        _constants.primaryColor.withOpacity(.2))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  forecastTime,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: _constants.greyColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  'assets/$forecastWeatherIcon',
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      forecastTemperature,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: _constants.greyColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '°C',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: _constants.greyColor,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        })),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
