import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PersonCachedImage extends StatelessWidget {
  const PersonCachedImage({
    super.key,
    required this.url,
    required this.width,
    required this.height,
  });
  final String? url;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return const Center(child: CircularProgressIndicator(color: Colors.white,));
      },
      errorWidget: (context, url, error) {
        return Image.asset('assets/images/no_image.jpg');
      },
    );
  }
}
