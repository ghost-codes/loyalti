import 'package:loyalty/core/models/menu.dart';
import 'package:loyalty/core/network/rest_client.dart';

class SelisApi {
  SelisApi(
    RestClient restClient,
  ) : _restClient = restClient;

  final RestClient _restClient;

  Future<Menu> menu() async {
    final json = await _restClient.get('/menu');
    return Menu.fromJson(json);
  }
}
