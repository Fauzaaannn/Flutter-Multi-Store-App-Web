import 'dart:convert';

import 'package:app_web/global_variables.dart';
import 'package:app_web/models/banner.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class BannerController {
  uploadBanner({required dynamic pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic("ddf2jygio", "gms3n8xe");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'banners'),
      );

      String image = imageResponse.secureUrl;

      BannerModel bannerModel = BannerModel(id: '', image: image);

      http.Response response = await http.post(
        Uri.parse('$uri/api/banner'),
        body: bannerModel.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Banner uploaded successfully');
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      // send a http get request to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        // OK
        List<dynamic> data = jsonDecode(response.body);

        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();

        return banners;
      } else {
        // throw an exception if the server responsed with an error status code
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      throw Exception('Failed to load banners $e');
    }
  }
}
