class ApiConstants {
  static const String API_URL = "http://127.0.0.1:3000/api/v1";
  static String PLACES_API(String input, String lang, String apiKey, String sessionToken) =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
}

class ApiPaths {
  static const String menu = "/menu";
}
