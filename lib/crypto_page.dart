import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'models/crypto_model.dart';
import 'widgets/section_card.dart';
import 'widgets/coin_list.dart';
import 'widgets/market_variation_graph.dart';
import 'widgets/hot_coins_section.dart';
import 'widgets/top_gainers_section.dart';

class CryptoPage extends StatefulWidget {
  @override
  _CryptoPageState createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage>
    with SingleTickerProviderStateMixin {
  late WebSocketChannel channel;
  Map<String, Crypto> cryptoData = {};

  @override
  void initState() {
    super.initState();
    connectWebSocket();
  }

  void connectWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://prereg.ex.api.ampiy.com/prices'),
    );

    channel.sink.add(jsonEncode({
      "method": "SUBSCRIBE",
      "params": ["all@ticker"],
      "cid": 1,
    }));

    channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      if (decodedMessage['stream'] == 'all@fpTckr') {
        setState(() {
          for (var coinData in decodedMessage['data']) {
            Crypto coin = Crypto.fromJson(coinData);
            cryptoData[coin.symbol] = coin;
          }
        });
      }
    }, onError: (error) {
      print('WebSocket Error: $error');
      reconnectWebSocket();
    }, onDone: () {
      reconnectWebSocket();
    });
  }

  void reconnectWebSocket() {
    Future.delayed(Duration(seconds: 5), () {
      if (channel.closeCode != null) {
        connectWebSocket();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Prepare market data for the graph
    List<Map<String, dynamic>> marketData = cryptoData.values.map((crypto) {
      return {
        'symbol': crypto.symbol,
        'gain': double.parse(crypto.priceChangePercent),
      };
    }).toList();

    // Prepare hot coins data
    List<Crypto> hotCoins = cryptoData.values
        .where((crypto) => double.parse(crypto.priceChangePercent) > 0)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to AMPIY!'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeadingSection(),
            SizedBox(height: 16),
            _buildActionButtons(),
            SizedBox(height: 24),
            SectionCard(
              title: 'Create wealth with SIP',
              description:
                  'Invest. Grow. Repeat. Grow your money with SIP now.',
              image: Icon(Icons.trending_up, size: 40, color: Colors.cyan),
              buttonText: ('Start a SIP'),
              onPressed: () {
                // Navigate to Start SIP Page
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SectionCard(
                    title: 'SIP Calculator',
                    description: 'Calculate Interest and Returns',
                    image: Icon(Icons.calculate, size: 40, color: Colors.cyan),
                    onPressed: () {
                      // Navigate to SIP Calculator Page
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SectionCard(
                    title: 'Deposit Money',
                    description: 'Use UPI or Bank Account to trade or buy SIP',
                    image: Icon(Icons.account_balance,
                        size: 40, color: Colors.cyan),
                    onPressed: () {
                      // Navigate to Deposit Money Page
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Coins',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 210, 210, 210)),
            ),
            CoinList(cryptoData: cryptoData),
            SizedBox(height: 24),
            /* Text(
              'Market Variation Spectrum',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),*/
            MarketVariationGraph(marketData: marketData, data: cryptoData),
            SizedBox(height: 24),
            //Text(
            // 'Hot Coins',
            //style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //),
            // Make sure HotCoinsSection has flexible height
            Container(
              height: 500, // Increased height to accommodate content
              child: HotCoinsSection(
                hotCoins: hotCoins,
                cryptoData: cryptoData,
              ),
            ),

            SizedBox(height: 10), // Increased spacing here to 90 pixels
            /* Text(
              'Top Gainers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),*/
            TopGainersSection(cryptoData: cryptoData),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadingSection() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              'Welcome to AMPIY!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Buy your first crypto asset today !!',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBoxedButton('Verify Account', () {
          // Navigate to Verify Account Page
        }),
        _buildBoxedButton('Buy', () {
          // Navigate to Buy Page
        }),
        _buildBoxedButton('Sell', () {
          // Navigate to Sell Page
        }),
        _buildBoxedButton('Referral', () {
          // Navigate to Referral Page
        }),
        _buildBoxedButton('Tutorial', () {
          // Navigate to Tutorial Page
        }),
      ],
    );
  }

  Widget _buildBoxedButton(String label, VoidCallback onPressed) {
    return Expanded(
      child: SizedBox(
        height: 80, // Increased height for a bigger box
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2, 4),
                blurRadius: 6,
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(0), // Remove default padding
              backgroundColor: Colors.transparent, // Transparent background
              shadowColor: Colors.transparent, // No shadow
            ),
            onPressed: onPressed,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: const Color.fromARGB(255, 21, 255, 216),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }
}
