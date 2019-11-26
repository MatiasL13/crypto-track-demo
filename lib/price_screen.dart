import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrencency = 'USD';
  var  currencyValue ;
  
  Future<dynamic> getCurrencyOnline(String currency) async{
        CoinData coinOnline  = CoinData();

      var  response = await coinOnline.getCoinData(currency);
      return response;
  }
  CupertinoPicker iOSwidget(){
    List<Text> dropMenuItems = [];

    for (String currency in currenciesList) {
      var newItem = new Text(currency);
      dropMenuItems.add(newItem);
    }

    return CupertinoPicker(
                backgroundColor: Colors.lightBlue,
                itemExtent: 32,
                onSelectedItemChanged: (selectedIndex) async {
                  var currencyValueResult = await getCurrencyOnline(dropMenuItems[selectedIndex].data);
                  print(currencyValueResult);
                  setState(() {
                    selectedCurrencency = dropMenuItems[selectedIndex].data;
                    currencyValue = currencyValueResult;
                  });
                  print(selectedIndex);
                },
                children: dropMenuItems,
              );
  }
  DropdownButton androidWidget(){
    List<DropdownMenuItem<String>> dropMenuItems = [];

        for (String currency in currenciesList) {
          var newItem = new DropdownMenuItem(
            child: Text(currency),
            value: currency,
          );
          dropMenuItems.add(newItem);
        }

    return DropdownButton<String>(
                value: selectedCurrencency,
                items: dropMenuItems,
                onChanged: (value) async {
                  var currencyValueResult = await getCurrencyOnline(value);
                  print(currencyValueResult);
                  setState(() {
                    selectedCurrencency = value;
                    currencyValue = currencyValueResult;
                  });
                },
              );
  }

  Widget getWidget(){

    if(Platform.isIOS){
      return iOSwidget();
    }else{
      return androidWidget();
    }
  }

   List<Padding> getCrypto(){
        List<Padding> paddingItems = [];

    for(String c in cryptoList){
       var item = new Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $c = ${currencyValue["$c$selectedCurrencency"]["last"]} $selectedCurrencency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
      paddingItems.add(item);
    }
    return paddingItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: getCrypto(),
          ),
          
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child:getWidget() 
              )
        ],
      ),
    );
  }
}

