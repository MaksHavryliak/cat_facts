import 'dart:math';

import 'package:dio/dio.dart';

class CatService {
  final Dio _dio = Dio();

  Future<String> fetchCatFact() async {
    final response = await _dio.get('https://catfact.ninja/fact');
    return response.data['fact'];
  }

  String generateRandomDate() {
    final random = Random();
    final year = 2020 + random.nextInt(5);
    final month = 1 + random.nextInt(12);
    final day = 1 + random.nextInt(28);
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString()}';
  }

  String generateImageUrl() {
    return 'https://cataas.com/cat?random=${DateTime.now().millisecondsSinceEpoch}';
  }
}