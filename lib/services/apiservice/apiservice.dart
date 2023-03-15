import 'dart:convert';

import 'package:currency_converter/models/currency_info.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  static Future<CurrencyInfo> fetchCurrencyConversionOnline(
      {String? from, String? to, double? amount}) async {
    CurrencyInfo? currencyInfo;

    try {
      Response? response = await http.get(
          headers: {'apiKey': "wkVvWYVHCq0k0WDaOH78GrjeJDbTJ3ve"},
          Uri.parse(
              "https://api.apilayer.com/exchangerates_data/convert?to=$to&from=$from&amount=$amount"));

      if (response.statusCode == 200) {
        print("sucess");
        currencyInfo = CurrencyInfo.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }

    return currencyInfo!;
  }
}
