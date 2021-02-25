import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<Widget> currencyWidgets = [];
  final List<String> cryptoList = ['BTC', 'ETH', 'LTC'];
  String selectedCurrency = 'AUD';
  var currencyRate;
  // String finalRate;

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  void onCurrencyChange(String value) {
    setState(
      () {
        selectedCurrency = value;
        getData();
      },
    );
  }

  Map<String, String> finalRate = {};
  void getData() async {
    try {
      currencyRate = await coinData().getCoinData(selectedCurrency);
      setState(() {
        finalRate = currencyRate;
      });

      print(finalRate);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  Widget build(BuildContext context) {
    getDropdownItems();
    currencyWidgets.clear();
    cryptoList.forEach((element) {
      currencyWidgets.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          child: Card(
            elevation: 10.0,
            color: Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
              child: Text(
                '1 $element = ${finalRate[element]} $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    },);
    // coinData dataofCoins = new coinData();
    // dataofCoins.getCoinData(selectedCurrency);
    // List<DropdownMenuItem<String>>chize = [];
    // for (int i = 0; i < currenciesList.length; i++) {
    //   chize.add(
    //     DropdownMenuItem(
    //       child: Text(currenciesList[i]),
    //       value: currenciesList[i],
    //     ),
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Coin Ticker'),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...currencyWidgets,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  // padding: EdgeInsets.only(bottom: 30.0),
                  color: Colors.lightBlue,
                  child: DropdownButton<String>(
                    value: selectedCurrency,
                    items: getDropdownItems(),
                    // items: chize,
                    // items: [
                    //   DropdownMenuItem(
                    //     child: Text('USD'),
                    //     value: 'USD',
                    //   ),
                    //   DropdownMenuItem(
                    //     child: Text('EUR'),
                    //     value: 'EUR',
                    //   ),
                    //   DropdownMenuItem(
                    //     child: Text('GBP'),
                    //     value: 'GBP',
                    //   ),
                    // ],
                    onChanged: onCurrencyChange,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
