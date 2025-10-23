import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  String _note = '';

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() => _quantity++);
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OrderItemDisplay(
              _quantity,
              'Footlong',
              note: _note,
            ),
            const SizedBox(height: 20), // small gap
            // 2️⃣ TextField for notes
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Add a note (e.g., no onions, extra pickles)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _note = value; // store the user’s note
                      });
                    },
                  ),
                )),

            const SizedBox(height: 20), // small gap
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: StyledButton(
                      onPressed: (_quantity < widget.maxQuantity)
                          ? _increaseQuantity
                          : null,
                      label: 'Add',
                      color: Colors.green),
                ),
                SizedBox(
                  width: 200,
                  child: StyledButton(
                      onPressed: (_quantity > 0) ? _decreaseQuantity : null,
                      label: 'Remove',
                      color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String itemType;
  final String note;

  const OrderItemDisplay(this.quantity, this.itemType,
      {super.key, this.note = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$quantity $itemType sandwich(es): ${'🥪' * quantity}'),
        if (note.isNotEmpty)
          Text(
            'Note: $note',
            style: const TextStyle(
                fontStyle: FontStyle.italic, color: Colors.grey),
          ),
      ],
    );
  }
}

class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color color;
  const StyledButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: Text(label),
    );
  }
}
