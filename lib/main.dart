import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Sandwich Counter')),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Check screen width
            if (constraints.maxWidth <= 200) {
              // 📱 Small screen (phone)
              return const SingleChildScrollView(
                child: Column(
                  children: [
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                  ],
                ),
              );
            } else {
              // 💻 Large screen (tablet / desktop)
              return const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                    OrderItemDisplay(3, 'BLT'),
                    OrderItemDisplay(5, 'Club'),
                    OrderItemDisplay(2, 'Veggie'),
                    OrderItemDisplay(4, 'Turkey'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('$quantity $itemType sandwich(es): ${'🥪' * quantity}',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ));
  }
}
