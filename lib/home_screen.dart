import 'package:charity_marathon/auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final double totalDonations = 75000;
  final double goal = 100000;
  final List<Map<String, dynamic>> topDonors = [
    {"name": "Alice", "amount": 5000},
    {"name": "Bob", "amount": 4000},
    {"name": "Charlie", "amount": 3500},
    {"name": "David", "amount": 3000},
    {"name": "Eve", "amount": 2500},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset('assets/logo_white.png', height: 80),
                SizedBox(width: 10),
                Text("Charity Marathon 2025"),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Auth().signOut();
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              child: MarqueeWidget(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPodium(topDonors[1], 2, Colors.grey),
                _buildPodium(topDonors[0], 1, Colors.yellow),
                _buildPodium(topDonors[2], 3, Colors.brown),
              ],
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Собрано: ${totalDonations}", style: TextStyle(color: Color(0xFF1B5E20), fontSize: 22, fontWeight: FontWeight.bold)),
              Text("Цель: ${goal}", style: TextStyle(color: Color(0xFF1B5E20), fontSize: 22, fontWeight: FontWeight.bold))
            ],),
            LinearProgressIndicator(
              value: totalDonations / goal,
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(100, 50)
                  ),
                  onPressed: () {},
                  child: Text("Donate"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Share"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(2, 169, 92, 0.2), // Зеленый фон для стилистики
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: topDonors.length - 3,
                  itemBuilder: (context, index) {
                    return buildDonorTile(topDonors[index + 3]['name'], topDonors[index + 3]['amount'], index + 3);
                    // return ListTile(
                    //   title: Text(topDonors[index]['name']),
                    //   trailing: Text("\$${topDonors[index]['amount']}"),
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodium(Map<String, dynamic> donor, int position, Color color) {
    return Column(
      children: [
        Container(
          height: position == 1 ? 100 : (position == 2 ? 80 : 60),
          width: 60,
          color: color,
          child: Center(
            child: Text("#${position}\n${donor['name']}\n\$${donor['amount']}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class MarqueeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Transform(
            transform: Matrix4.skewX(-0.2), // Наклон влево
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.green[400], // Зеленый фон для стилистики
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Donor ${index + 1}: \$${(index + 1) * 100}",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildDonorTile(String name, int amount, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.green[100], // Светло-зеленый фон
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[700], 
          child: Text("${index + 1}", style: TextStyle(color: Colors.white)),
        ),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text("Donated: \$${amount}", style: TextStyle(color: Colors.green[900])),
        trailing: Icon(Icons.military_tech, color: Colors.amber, size: 30), // Медаль
      ),
    ),
  );
}