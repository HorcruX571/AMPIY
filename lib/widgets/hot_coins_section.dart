import 'package:flutter/material.dart';
import '../models/crypto_model.dart';

class HotCoinsSection extends StatelessWidget {
  final List<Crypto> hotCoins;
  final Map<String, Crypto> cryptoData;

  HotCoinsSection({required this.hotCoins, required this.cryptoData});

  @override
  Widget build(BuildContext context) {
    // Take only the top 4 hot coins
    final topFourHotCoins = hotCoins.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hot Coins',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 210, 210, 210)),
        ),
        SizedBox(height: 20),
        // Wrapping GridView with an Expanded widget to manage available space
        SizedBox(
          height: 400, // Increase the height to provide more space
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns for the grid
              childAspectRatio: 1, // Adjusted aspect ratio to allow more height
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemCount: topFourHotCoins.length,
            itemBuilder: (context, index) {
              final coin = topFourHotCoins[index];
              return Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0), // Reduced padding
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          'https://cryptoicons.org/api/icon/${coin.symbol.toLowerCase()}/200',
                        ),
                        onBackgroundImageError: (_, __) => Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        radius: 25, // Reduced radius
                      ),
                      SizedBox(height: 8), // Reduced spacing
                      Text(
                        coin.symbol,
                        style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Reduced font size
                        ),
                      ),
                      SizedBox(height: 4), // Reduced spacing
                      Text(
                        '₹ ${coin.currentPrice}',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14), // Reduced font size
                      ),
                      SizedBox(height: 4), // Reduced spacing
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.red,
                        size: 16, // Reduced icon size
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Increase spacing between HotCoinsSection and TopGainersSection
      ],
    );
  }
}
