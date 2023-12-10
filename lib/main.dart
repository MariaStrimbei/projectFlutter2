import 'package:flutter/material.dart';
import 'StockItem.dart';
import 'ManageStockPage.dart';

List<StockItem> stockItems = [];

void initialPopulate() {
  StockItem newItem1 = StockItem(
    name: "Caramida",
    category: "Roofing and Siding",
    quantity: 10,
    price: 3.5,
    warehouse: "Warehouse A",
  );
  StockItem newItem2 = StockItem(
    name: "Priza A24",
    category: "Electrical",
    quantity: 15,
    price: 3.5,
    warehouse: "Warehouse B",
  );
  StockItem newItem3 = StockItem(
    name: "Gresie",
    category: "Flooring",
    quantity: 20,
    price: 3.5,
    warehouse: "Warehouse A",
  );
  stockItems.add(newItem1);
  stockItems.add(newItem2);
  stockItems.add(newItem3);
}

void main() {
  // Add initial data into the table
  initialPopulate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Building store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Welcome back!"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Admin Interface',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageStockPage(),
                    ),
                  );
                },
                icon: Icon(Icons.storage),
                label: Text('Manage Stock'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
