import 'package:currency_converter/models/currency_info.dart';

class OfflineService {
  static Map<String, double> fetchCurrencyConversionOffline(
      {String? from, String? to, double? amount}) {
    Map<String, double> exchangeRates = {
      "EUR": 88.53,
      "USD": 1.08,
      "JPY": 134,
      "GBP": 0.82,
      "AUD": 1.4,
      "CAD": 1.36,
      "CHF": 0.92,
      "HKD": 7.84,
      "SEK": 10.45,
      "ILS": 3.62,
    };

    print(to);
    print(from);
    print(amount);

    Map<String, double> exchangeRatesList = {'fixed': 0, 'floating': 0};

    if (from != null && to != null && amount != null) {
      exchangeRatesList['fixed'] = amount * exchangeRates[to]!.toDouble();
      exchangeRatesList['floating'] = amount *
          (exchangeRates[from]!.toDouble() / exchangeRates[to]!.toDouble());
      // print(exchangeRatesList[0]);
      // print(exchangeRatesList[1]);
    } else {
      return {};
    }

    return exchangeRatesList;
  }
}
