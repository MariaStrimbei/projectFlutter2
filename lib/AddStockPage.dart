import 'package:flutter/material.dart';
import 'StockItem.dart';

class AddStockPage extends StatefulWidget {
  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String selectedCategory = 'Roofing and Siding';
  String selectedWarehouse = 'Warehouse A';

  List<String> categories = [
    "Roofing and Siding",
    "Sanitary and Plumbing",
    "Electrical",
    "Flooring",
    "Doors and Windows",
    "Paint and Coatings",
  ];

  List<String> warehouses = [
    "Warehouse A",
    "Warehouse B",
    "Warehouse C",
    "Warehouse D",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stock'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 10),
              Text('Category:', style: TextStyle(fontSize: 16)),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              SizedBox(height: 10),
              Text('Warehouse:', style: TextStyle(fontSize: 16)),
              DropdownButton<String>(
                value: selectedWarehouse,
                hint: Text('Select Warehouse'),
                onChanged: (value) {
                  setState(() {
                    selectedWarehouse = value!;
                  });
                },
                items: warehouses.map((warehouse) {
                  return DropdownMenuItem<String>(
                    value: warehouse,
                    child: Text(warehouse),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _handleAddButtonClick(context);
                      },
                      child: Text('Add Stock'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      child: Text('Cancel'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleAddButtonClick(BuildContext context) {
    StockItem? newItem = _validateAndCreateNewItem();
    if (newItem != null) {
      Navigator.pop(context, newItem);
    }
  }

//validate data and create the item
  StockItem? _validateAndCreateNewItem() {
    String name = nameController.text.trim();
    String category = selectedCategory;
    String warehouse = selectedWarehouse;

    if (name.isNotEmpty && category.isNotEmpty && warehouse.isNotEmpty) {
      try {
        int quantity = int.parse(quantityController.text);
        double price = double.parse(priceController.text);

        if (quantity > 0 && price > 0) {
          return StockItem(
            name: name,
            category: category,
            quantity: quantity,
            price: price,
            warehouse: warehouse,
          );
        } else {
          _showSnackBar(context, 'Please enter valid quantity and price');
        }
      } catch (e) {
        _showSnackBar(context, 'Please enter valid quantity and price');
      }
    } else {
      _showSnackBar(context, 'Please complete all fields');
    }

    return null;
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
