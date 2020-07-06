import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/networking.dart';

const apiKey = '3d5e9547f7f60f4af8ca85c96905e779';
const weatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName){
    var url = '$weatherURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.geCurrentLocation(); 
    NetworkHelper networkHelper =  NetworkHelper('$weatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'); 
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩'; // normal cloud
    } else if (condition < 400) {
      return '🌧'; // normal rain
    } else if (condition < 600) {
      return '☔️'; 
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫'; // thunder
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍'; // dono hath upr wla emoji
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤'; // scarfs and gloves
    } else {
      return 'Bring a 🧥 just in case'; // jacket 
    }
  }
}
