import 'package:my_food_ordering_app/models/restaurants.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<List<Restaurants>?> getRestaurants() async {
    var client = http.Client();
    var uri = Uri.parse("https://csaurabh.github.io/data_api/restaurants.json");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return restaurantsFromJson(json);
    }
    return null;
  }
}
