import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Scan the QR code to donate", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: 200,
              color: Colors.grey[300], // Placeholder for QR code
              child: Center(child: Text("QR Code Here")),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Payment Confirmed!")),
                );
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text("Confirm Payment"),
            ),
          ],
        ),
      ),
    );
  }
}
