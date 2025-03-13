import 'package:flutter/material.dart';

class MarketNewsSection extends StatelessWidget {
  final List<Map<String, String>> newsList = [
    {"title": "Tech Stocks Rally as Market Gains", "source": "CNBC"},
    {"title": "Oil Prices Surge Amid Global Tensions", "source": "Bloomberg"},
    {"title": "Investors Look to Fed Meeting for Clues", "source": "Reuters"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Market News", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: Text("View All")),
          ],
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(news["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(news["source"]!, style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
