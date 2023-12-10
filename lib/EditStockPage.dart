import 'package:flutter/material.dart';
import 'StockItem.dart';
import 'main.dart';

class EditStockPage extends StatefulWidget {
  final StockItem stockItem;

  EditStockPage({required this.stockItem});

  @override
  _EditStockPageState createState() => _EditStockPageState();
}

class _EditStockPageState extends State<EditStockPage> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController priceController;

  late String selectedCategory;
  late String selectedWarehouse;

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
  void initState() {
    super.initState();

    // Initialize controllers and selected values with existing data
    nameController = TextEditingController(text: widget.stockItem.name);
    quantityController =
        TextEditingController(text: widget.stockItem.quantity.toString());
    priceController =
        TextEditingController(text: widget.stockItem.price.toString());
    selectedCategory = widget.stockItem.category;
    selectedWarehouse = widget.stockItem.warehouse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
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
                      // Validate input and update stock item in the list
                      StockItem updatedItem = StockItem(
                        name: nameController.text,
                        category: selectedCategory,
                        quantity: int.parse(quantityController.text),
                        price: double.parse(priceController.text),
                        warehouse: selectedWarehouse,
                      );
                      Navigator.pop(context,
                          updatedItem); // Navigate back to the previous screen and pass the updated item
                    },
                    child: Text('Update Stock'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context,
                          null); // Navigate back without adding a new item
                    },
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
