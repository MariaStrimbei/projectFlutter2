import 'package:flutter/material.dart';
import 'AddStockPage.dart';
import 'EditStockPage.dart';
import 'DeleteStockPage.dart';
import 'StockItem.dart';
import 'sql_helper.dart';

class ManageStockPage extends StatefulWidget {
  @override
  _ManageStockPageState createState() => _ManageStockPageState();
}

class _ManageStockPageState extends State<ManageStockPage> {
  List<Map<String, dynamic>> _stockItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshStockItems();
  }

  void _refreshStockItems() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _stockItems = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Stock'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _stockItems.length,
              itemBuilder: (context, index) {
                StockItem item = StockItem.fromMap(_stockItems[index]);
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
      await SQLHelper.createItem(
        name: newItem.name,
        quantity: newItem.quantity,
        price: newItem.price,
        category: newItem.category,
        warehouse: newItem.warehouse,
      );
      _refreshStockItems();
      print("Stock items after adding: $_stockItems");
      _showSnackBar(context, 'Stock item ${newItem.name} added successfully');
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
      if (editedItem.id != null) {
        print("Updating item: ${editedItem.toMap()}");
        await SQLHelper.updateItem(editedItem);
        _refreshStockItems();
        print("Stock items after update: $_stockItems");
        _showSnackBar(context, 'Stock item ${item.name} edited successfully');
      } else {
        print("Error: editedItem.id is null");
      }
    }
  }

  void _navigateToDeleteScreen(BuildContext context, StockItem item) async {
    print("Deleting item with ID: ${item.id}");

    bool deletionConfirmed = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeleteStockPage(item: item),
      ),
    );

    if (deletionConfirmed) {
      await SQLHelper.deleteItem(item.id!);
      _refreshStockItems();
      print("Stock items after deletion: $_stockItems");
      _showSnackBar(context, 'Stock item ${item.name} deleted successfully');
    } else {
      _showSnackBar(
          context, 'Error deleting item ${item.name}. Please try again.');
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
