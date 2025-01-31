import 'package:flutter/material.dart';

class DonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Page', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Donation Section
            Text(
              "Enter your donation",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var amount in ['25', '50', '100', '200', '500'])
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("£$amount"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF02A95C), // Main theme color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Custom Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tip Section
            Text(
              "Tip GoFundMe services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: 15,
              min: 0,
              max: 30,
              divisions: 30,
              label: '15%',
              onChanged: (value) {},
              activeColor: Color(0xFF02A95C),
            ),
            SizedBox(height: 20),

            // Payment Method Section
            Text(
              "Payment Method",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              value: 'Google Pay',
              groupValue: 'Google Pay',
              onChanged: (value) {},
              title: Text('Google Pay'),
            ),
            RadioListTile(
              value: 'Card or Debit',
              groupValue: 'Google Pay',
              onChanged: (value) {},
              title: Text('Credit or Debit'),
            ),
            SizedBox(height: 20),

            // Summary Section
            Divider(),
            Text(
              "Your donation",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Donation: £0.00"),
            Text("Tip: £0.00"),
            Text("Total: £0.00"),
            Divider(),
            SizedBox(height: 20),

            // Payment Button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF02A95C),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Donate with Google Pay",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}