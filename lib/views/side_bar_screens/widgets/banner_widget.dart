import 'package:app_web/controllers/banner_controller.dart';
import 'package:app_web/models/banner.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  // A Future that will hold the list of banners once loaded from the API
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No Banners Available'),
          );
        } else {
          final banners = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: banners.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, // number of columns
              crossAxisSpacing: 8, // spacing between columns
              mainAxisSpacing: 8, // spacing between rows
            ),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.network(
                  banner.image,
                  height: 200,
                  width: 200,
                ),
              );
            },
          );
        }
      },
    );
  }
}
