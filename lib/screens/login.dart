import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  final int counter;
  final Map<int, int> itemQuantities;
  final double totalAmount;

  // Define image paths directly in NextScreen
  final List<String> imagePaths = [
    'assets/images/pro_pic.jpg',
    'assets/images/cat/atta.jpg',
    'assets/images/cat/clean.jpg',
    'assets/images/cat/bake.jpg',
  ];

  NextScreen({
    super.key,
    required this.counter,
    required this.itemQuantities,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display total items in the cart
            Text(
              'Total Items: $counter',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
// Display the total price of the items in the cart
            Text(
              'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Display a summary of item quantities
            const Text(
              'Items Added:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // List of items and their quantities
            Expanded(
              child: ListView.builder(
                itemCount: itemQuantities.length,
                itemBuilder: (context, index) {
                  int itemIndex = itemQuantities.keys.toList()[index];
                  String imagePath =
                      imagePaths[itemIndex]; // Access imagePaths here
                  int quantity = itemQuantities[itemIndex] ?? 0;

                  // Only show items that have been added to the cart
                  if (quantity > 0) {
                    return ListTile(
                      leading: Image.asset(
                        imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text('Item ${itemIndex + 1}'),
                      trailing: Text('Quantity: $quantity'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
