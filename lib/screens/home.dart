import 'package:flutter/material.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Map to store the quantity for each image by its index
  Map<int, int> itemQuantities = {};
  int counter = 0; // Total count of items in the cart
  double totalAmount = 0.0; // Total amount for all the items in the cart

  // Image paths
  List<String> imagePaths = [
    'assets/images/pro_pic.jpg',
    'assets/images/cat/atta.jpg',
    'assets/images/cat/clean.jpg',
    'assets/images/cat/bake.jpg',
  ];
// Prices for each item, indexed the same as imagePaths
  List<double> itemPrices = [
    10.0, // Price for 'pro_pic.jpg'
    29.0, // Price for 'atta.jpg'
    33.0, // Price for 'clean.jpg'
    44.0, // Price for 'bake.jpg'
  ];
  // Map to track whether the ADD button is clicked and show quantity row
  Map<int, bool> isAddButtonClicked = {};

  // Method to add an item to the specific image's cart
  void addToCart(int index) {
    setState(() {
      itemQuantities[index] = (itemQuantities[index] ?? 0) + 1;
      counter++;
      isAddButtonClicked[index] =
          true; // Mark that the "ADD" button was clicked
      totalAmount += itemPrices[index]; // Add price to total
    });
  }

  // Method to subtract an item from the specific image's cart
  void subtractFromCart(int index) {
    setState(() {
      if (itemQuantities[index] != null && itemQuantities[index]! > 0) {
        itemQuantities[index] = itemQuantities[index]! - 1;
        counter--;
        totalAmount -= itemPrices[index]; // Subtract price from total
      }
      // If quantity reaches 0, hide add/remove buttons and show the ADD button again
      if (itemQuantities[index] == 0) {
        isAddButtonClicked[index] = false; // Show the "ADD" button again
      }
    });
  }

  // Method to navigate to the next screen with the counter value
  void navigateToNextScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NextScreen(
            counter: counter,
            itemQuantities: itemQuantities, // Pass the itemQuantities map
            totalAmount: totalAmount, // Pass the total amount
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // GridView to display the images with their respective add/subtract functionality
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: imagePaths.length, // Number of images
              itemBuilder: (context, index) {
                return GridTile(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      // Image displayed in the grid
                      Image.asset(
                        imagePaths[index], // Use image from list
                        fit: BoxFit.cover,
                      ),
                      // If the "ADD" button is clicked, it will be replaced by the add/remove row
                      if (isAddButtonClicked[index] != true)
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            color: Colors.green,
                            child: GestureDetector(
                              onTap: () => addToCart(index),
                              child: const Text(
                                'ADD', // Text saying "ADD"
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        // Show the Row with Add and Remove buttons when "ADD" is clicked
                        Positioned(
                          bottom: -10,
                          left: 10,
                          right: -10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Button to add items
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => addToCart(index),
                              ),
                              // Display current quantity for the image
                              Text(
                                '${itemQuantities[index] ?? 0}', // Show the quantity
                                style: const TextStyle(fontSize: 16),
                              ),
                              // Button to subtract items
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => subtractFromCart(index),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Counter display above the add/subtract buttons
          if (counter > 0)
            Positioned(
              bottom: 80, // Position counter above buttons
              child: GestureDetector(
                onTap: () => navigateToNextScreen(context), // Navigate on tap
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  radius: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text(
                        '$counter', // Display current count
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
