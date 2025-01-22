import 'package:cloudinary_public/cloudinary_public.dart';

class CategoryController {
  uploadCategory(
      {required dynamic pickedImage, required dynamic pickedBanner}) async {
    try {
      final cloudinary = CloudinaryPublic("ddf2jygio", "gms3n8xe");

      // upload the image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'categoryImages'),
      );

      print(imageResponse);

      // upload the banner
      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedBanner,
            identifier: 'pickedBanner', folder: 'categoryImages'),
      );

      print(bannerResponse);
    } catch (e) {
      print('Error Uploading to Cloudinary: $e');
    }
  }
}
