import 'package:flutter/material.dart';

import '../components/homecategorywidget.dart';
import '../components/productwidget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 100),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(Icons.tune),
                      hintText: "Search Product",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      contentPadding: EdgeInsets.only(top: 12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              CategoriesWidget(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text(
                      "Products",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(child: Container(
                height: MediaQuery.of(context).size.height,
                child: ProductWidget())),
            ],
          ),
        ),
      ),
    );
  }
}
