
import 'package:epharmacyapp/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/categoriescontroller.dart';
import '../pages/productsByCategoryPage.dart';

class CategoriesWidget extends ConsumerWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 100,
      child:ref.watch(categoriesProvider).when(data: (data)=>
      ListView.builder(
        shrinkWrap: true,
        physics:const ClampingScrollPhysics(),
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        
        itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  GestureDetector(
                     onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsByCategoryPage(),settings: RouteSettings(arguments: data[index])));
              },
                    child: Image.network(
                        data[index].image.toString(),
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                      ),
                  ),
                  
                  Text(
                    data[index].name.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
          );
         
        },
      ),
      
      
       error: (error,stackTrace)=>ErrorWidget(error.toString()), loading: ()=>LoadingScreen())
    );
  }
}
