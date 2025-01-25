import 'package:app_web/controllers/subcategory_controller.dart';
import 'package:app_web/models/subcategory.dart';
import 'package:flutter/material.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  // a future that will be used to hold the list of categories once loaded from the API
  late Future<List<Subcategory>> futureSubcategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureSubcategories = SubcategoryController().loadSubcategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureSubcategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No Subcategories available'),
          );
        } else {
          final subcategories = snapshot.data!;
          return GridView.builder(
            itemCount: subcategories.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final subcategory = subcategories[index];
              return Column(
                children: [
                  Flexible(
                    child: Image.network(
                      subcategory.image,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Text(subcategory.subCategoryName),
                ],
              );
            },
          );
        }
      },
    );
  }
}
