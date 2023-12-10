import 'package:flutter/material.dart';
import 'StockItem.dart';
import 'AddStockPage.dart';
import 'EditStockPage.dart';
import 'DeleteStockPage.dart';

import 'main.dart';

class ManageStockPage extends StatefulWidget {
  @override
  State<ManageStockPage> createState() => _ManageStockPageState();
}

class _ManageStockPageState extends State<ManageStockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Stock'),
      ),
      body: ListView.builder(
        itemCount: stockItems.length,
        itemBuilder: (context, index) {
          StockItem item = stockItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${item.category}'),
                Text('Unit Price: ${item.price}'),
                Text('Quantity: ${item.quantity}'),
                Text('Warehouse: ${item.warehouse}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _navigateToEditScreen(context, item);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _navigateToDeleteScreen(context, item);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddScreen(BuildContext context) async {
    StockItem? newItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStockPage(),
      ),
    );

    if (newItem != null) {
      setState(() {
  
        stockItems.add(newItem);
      });

      _showSnackBar(context, 'Stock item  ${newItem.name} added successfully');
    }
  }

  void _navigateToEditScreen(BuildContext context, StockItem item) async {
    StockItem? editedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditStockPage(stockItem: item),
      ),
    );

    if (editedItem != null) {
      setState(() {
        // Update the existing item in the list
        int index = stockItems.indexOf(item);
        if (index != -1) {
          stockItems[index] = editedItem;
        }
      });

      _showSnackBar(context, 'Stock item ${item.name} edited successfully');
    }
  }

void _navigateToDeleteScreen(BuildContext context, StockItem item) async {
  bool deletionConfirmed = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DeleteStockPage(item: item),
    ),
  );

  if (deletionConfirmed) {
    // Handle deletion
    setState(() {
      stockItems.remove(item);
    });

    _showSnackBar(context, 'Stock item ${item.name} deleted successfully');
  }
}


  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
