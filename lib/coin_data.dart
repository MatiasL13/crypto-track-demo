import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'ARS',
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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future getCoinData(String cucurrency) async{
   // http.Response response =  await   http.get('https://apiv2.bitcoinaverage.com/indices/global/ticker/$crypto$cucurrency');
    http.Response response =  await   http.get('https://apiv2.bitcoinaverage.com/indices/global/ticker/short?crypto=BTC,ETH,LTC&fiat=$cucurrency');

    if( response.statusCode == 200){
      // var id = jsonDecode(data)['weather'][0]['id'];
      // var city = jsonDecode(data)['name'];
      // var temp = jsonDecode(data)['main']['temp'];
      return jsonDecode(response.body);
      // print(latitude);
      // print(longitude);
      // print(id);
      // print(city);
      // print(temp);
    }
  }

}
