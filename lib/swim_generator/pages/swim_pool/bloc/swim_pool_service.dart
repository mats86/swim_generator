part of 'swim_pool_bloc.dart';

class SwimPoolService {
  Future<List<SwimPool>> getSwimPools() async {
    final response = await http.get(
        Uri.parse('https://localhost:7226/SwimPool?apiKey=IhrEchterApiKey'));
    if (response.statusCode == 200) {
      List<dynamic> swimPoolsJson = json.decode(response.body);
      return swimPoolsJson.map((json) => SwimPool.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load swim pools');
    }
  }
}
