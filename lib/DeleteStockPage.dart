import 'package:flutter/material.dart';
import 'StockItem.dart';

class DeleteStockPage extends StatelessWidget {
  final StockItem item;

  DeleteStockPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Stock'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete ${item.name}?',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Delete'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
