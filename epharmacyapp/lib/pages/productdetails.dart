

import 'package:epharmacyapp/models/productmodel.dart';
import 'package:epharmacyapp/pages/relatedproducts.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:  Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Colors.teal.shade300,
                      ),
                      ),
                      
                ),
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    product.image!,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
               
                const Positioned(
                    top: 10,
                    right: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.teal,
                        size: 35,
                      ),
                    )),
                const Positioned(
                    top: 10,
                    right: 60,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.teal,
                        size: 35,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                product.name!,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.description!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "\$${product.price}",
                  style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade300,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                    ),
                    
                      onPressed: () {}, child: Text("Add To Cart"))),
            ),
            const SizedBox(
              height: 32,
            ),
           
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Similar Products",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
             
              
            const SizedBox(
              height: 16,
            ),
            RelatedProducts(categoryname: product.categoryname.toString())
          ],
        ),
      ),
    );
  }
}
