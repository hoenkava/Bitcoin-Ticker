import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURL =
    'https://rest.coinapi.io/v1/exchangerate/currenciesList/cryptoList?apiKey=';

const apiKey = '094415FF-58F6-46A7-82E2-27A0E22B7DD5';

class coinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String i in cryptoList) {
      http.Response getResponse = await http.get(
          'https://rest.coinapi.io/v1/exchangerate/$i/$selectedCurrency?apiKey=094415FF-58F6-46A7-82E2-27A0E22B7DD5');
      if (getResponse.statusCode == 200) {
        var decodedData = jsonDecode(getResponse.body);
        // print(decodedData);
        cryptoPrices[i] = decodedData['rate'].toStringAsFixed(0);
        print(cryptoPrices);
      } else {
        print(getResponse.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
