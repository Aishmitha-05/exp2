import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Main Application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce Catalog',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductCatalogPage(),
    );
  }
}

// Product Model
class Product {
  final String name;
  final String description;
  final String price;
  final String emoji;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.emoji,
  });
}

// Product List
const List<Product> products = [
  Product(
    name: 'Smart Watch',
    description: 'Fitness tracking and smart notifications',
    price: '₹2,499',
    emoji: '⌚',
  ),
  Product(
    name: 'Headphones',
    description: 'Wireless headphones with clear sound',
    price: '₹1,999',
    emoji: '🎧',
  ),
  Product(
    name: 'Camera',
    description: 'Capture your favourite moments',
    price: '₹25,999',
    emoji: '📷',
  ),
  Product(
    name: 'Shoes',
    description: 'Comfortable shoes for everyday use',
    price: '₹1,499',
    emoji: '👟',
  ),
  Product(
    name: 'Backpack',
    description: 'Stylish backpack for travel and college',
    price: '₹999',
    emoji: '🎒',
  ),
  Product(
    name: 'Sunglasses',
    description: 'Modern sunglasses with UV protection',
    price: '₹799',
    emoji: '🕶️',
  ),
  Product(
    name: 'Laptop',
    description: 'Powerful laptop for work and study',
    price: '₹54,999',
    emoji: '💻',
  ),
  Product(
    name: 'Camera Lens',
    description: 'High quality lens for photography',
    price: '₹8,999',
    emoji: '📸',
  ),
];

// Product Catalog Page
class ProductCatalogPage extends StatelessWidget {
  const ProductCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        title: const Text(
          'ShopEasy 🛍️',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 20),
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 20),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int columns;

          if (constraints.maxWidth < 600) {
            columns = 2;
          } else if (constraints.maxWidth < 1000) {
            columns = 3;
          } else {
            columns = 4;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Discover Products 🛒',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Find the best products at amazing prices.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: products[index],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Reusable Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              color: Colors.blue.shade50,
              child: Center(
                child: Text(
                  product.emoji,
                  style: const TextStyle(fontSize: 65),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} added to cart!',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}