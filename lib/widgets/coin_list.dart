import 'package:flutter/material.dart';
import '../models/crypto_model.dart';

class CoinList extends StatefulWidget {
  final Map<String, Crypto> cryptoData;

  CoinList({required this.cryptoData});

  @override
  _CoinListState createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  bool showAllCoins = false;

  @override
  Widget build(BuildContext context) {
    final coins = widget.cryptoData.values.toList();
    final displayCoins = showAllCoins ? coins : coins.take(10).toList();

    return Column(
      children: [
        for (var coin in displayCoins)
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/${coin.symbol}.png'),
              ),
              title: Text(
                coin.symbol,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(coin.symbol),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹${coin.currentPrice}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '${coin.priceChangePercent}%',
                    style: TextStyle(
                      color: double.parse(coin.priceChangePercent) > 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (!showAllCoins && coins.length > 10)
          ElevatedButton(
            onPressed: () {
              setState(() {
                showAllCoins = true;
              });
            },
            child: Text('View More'),
          ),
      ],
    );
  }
}
