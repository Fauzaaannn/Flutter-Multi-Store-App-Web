import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'categoryScreen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String categoryName;
  dynamic _image;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: _image != null
                          ? Image.memory(_image)
                          : Text(
                              'Category image',
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        onChanged: (value) {
                          categoryName = value;
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please enter category name';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Category Name",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.grey),
                      ),
                      onPressed: () {},
                      child: Text("Cancel"),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(categoryName);
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text("Upload Images"),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
