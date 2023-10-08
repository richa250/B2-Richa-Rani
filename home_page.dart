import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Home page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Grid'),
      ),
      body: ImageGrid(),
    );
  }
}

class ImageGrid extends StatelessWidget {
  final List<String> imageUrls = List.generate(
      50, (index) => 'https://picsum.photos/200/200?random=${index + 1}');

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: imageUrls[index],
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) {
            print("Error loading image: $error");
            return Icon(Icons.error);
          },
          fit: BoxFit.cover,
        );
      },
    );
  }
}
