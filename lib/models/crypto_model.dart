class Crypto {
  final String symbol;
  final String priceChange;
  final String priceChangePercent;
  final String currentPrice;
  final String openPrice;
  final String highPrice;
  final String lowPrice;
  final String bestBidPrice;
  final String bestAskPrice;

  Crypto({
    required this.symbol,
    required this.priceChange,
    required this.priceChangePercent,
    required this.currentPrice,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.bestBidPrice,
    required this.bestAskPrice,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      symbol: json['s'] as String,
      priceChange: json['p'] as String,
      priceChangePercent: json['P'] as String,
      currentPrice: json['c'] as String,
      openPrice: json['o'] as String,
      highPrice: json['h'] as String,
      lowPrice: json['l'] as String,
      bestBidPrice: json['b'] as String,
      bestAskPrice: json['a'] as String,
    );
  }

  String? get imageUrl => null;

  String? get name => null;

  String? get iconUrl => null;

  get volume => null;
}
