import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowPhoto extends StatefulWidget {
  static const String route = '/ShowPhoto';
  final String url;

  const ShowPhoto({Key? key, required this.url}) : super(key: key);

  @override
  State<ShowPhoto> createState() => _ShowPhotoState();
}

class _ShowPhotoState extends State<ShowPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: InteractiveViewer(
          minScale: .1,
          maxScale: 5,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.url),
                    fit: BoxFit.contain)),
          ),
        ),
      ),
    );
  }
}
