import 'package:charity_marathon/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  double totalDonations = 0;
  final double goal = 500000;
  final List<Map<String, dynamic>> topDonors = [
    {"name": "Alice", "amount": 5000},
    {"name": "Bob", "amount": 4000},
    {"name": "Charlie", "amount": 3500},
    {"name": "David", "amount": 3000},
    {"name": "Eve", "amount": 2500},
  ];
  final DatabaseReference reference = FirebaseDatabase.instance.ref();

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
              child: Text("Log out"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder(
            stream: reference.child("users").onValue,
            builder: (context, snapshot) {
              Map users = Map();
              snapshot.data!.snapshot.children.forEach((element) {
                users.addAll({element.key: element.value});
              });
              List users_list = users.entries.toList().toList();
              users_list
                  .sort((a, b) => a.value["total"].compareTo(b.value["total"]));
              users_list = users_list.reversed.toList();
              int count = users_list.length;
              if (users_list.length > 15) count = 15;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    child: MarqueeWidget(),
                  ),
                  SizedBox(height: 20),
                  if (snapshot.connectionState != ConnectionState.waiting)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPodium(users_list[1], 2, Colors.grey),
                        _buildPodium(users_list[0], 1, Colors.yellow),
                        _buildPodium(users_list[2], 3, Colors.brown),
                      ],
                    ),
                  SizedBox(height: 20),
                  StreamBuilder(
                      stream: reference.child("total").onValue,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        totalDonations =
                            (snapshot.data!.snapshot.value) as double;
                        return Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Собрано: ${totalDonations}",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 77, 85, 78),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                  Text("Цель: ${goal}",
                                      style: TextStyle(
                                          color: Color(0xFF1B5E20),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold))
                                ]),
                            LinearProgressIndicator(
                              value: totalDonations / goal,
                              minHeight: 20,
                              backgroundColor: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        );
                      }),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Top-100", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                      ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(fixedSize: Size(300, 50)),
                        onPressed: () {},
                        child: Text("Donate"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if (snapshot.connectionState != ConnectionState.waiting)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(
                              2, 169, 92, 0.2), // Зеленый фон для стилистики
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          itemCount: users_list.length - 3,
                          itemBuilder: (context, index) {
                            // print(users_list[index + 3].key['name']);
                            // print(users_list[index + 3].value['total']);
                            return buildDonorTile(
                                users_list[index + 3].value['name'],
                                users_list[index + 3].value['total'],
                                index + 3);
                            // return ListTile(
                            //   title: Text(topDonors[index]['name']),
                            //   trailing: Text("\$${topDonors[index]['amount']}"),
                            // );
                          },
                        ),
                      ),
                    ),
                ],
              );
            }),
      ),
    );
  }

  Widget _buildPodium(MapEntry donor, int position, Color color) {
    return Column(
      children: [
        Container(
          height: position == 1 ? 100 : (position == 2 ? 80 : 60),
          width: 60,
          color: color,
          child: Center(
            child: Text(
              "#${position}\n${donor.value['name']}\n\$${donor.value['total']}",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
    final DatabaseReference reference = FirebaseDatabase.instance.ref();
    return StreamBuilder(
      stream: reference.child("donates").onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Container();

        Map donations = Map();
        snapshot.data!.snapshot.children.forEach((element) {
          donations.addAll({element.key: element.value});
        });
        List donations_list = donations.entries.toList().reversed.toList();
        int count = donations_list.length;
        if (donations_list.length > 15) count = 15;
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: count,
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
                      "${donations_list[index].value['name'] ?? "Аноним"}: \$${donations_list[index].value["amount"]}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

Widget buildDonorTile(String name, int amount, int index) {
  print("SDFJSFDKFKDSLKJFDSJK");
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
        subtitle: Text("Donated: \$${amount}",
            style: TextStyle(color: Colors.green[900])),
        trailing:
            Icon(Icons.military_tech, color: Colors.amber, size: 30), // Медаль
      ),
    ),
  );
}
