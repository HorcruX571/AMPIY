import 'package:flutter/material.dart';
import '../models/crypto_model.dart';

class TopGainersSection extends StatelessWidget {
  final Map<String, Crypto> cryptoData;

  TopGainersSection({required this.cryptoData});

  @override
  Widget build(BuildContext context) {
    // Sort coins by price change percentage in descending order
    final topGainers = cryptoData.values.toList()
      ..sort((a, b) => double.parse(b.priceChangePercent)
          .compareTo(double.parse(a.priceChangePercent)));

    // Take only the top 4 gainers
    final topFourGainers = topGainers.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Gainers',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 210, 210, 210)),
        ),
        SizedBox(height: 16),
        ...topFourGainers.map((crypto) => Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    // Use a working link for crypto logos. Replace {crypto.symbol} with the actual symbol.
                    'https://cryptoicons.org/api/icon/${crypto.symbol.toLowerCase()}/200',
                  ),
                  onBackgroundImageError: (_, __) => Icon(
                      Icons.error), // Fallback in case the image fails to load
                ),
                title: Text(
                  crypto.symbol,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Gain: ${crypto.priceChangePercent}%',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  '₹ ${crypto.currentPrice}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            )),
      ],
    );
  }
}
