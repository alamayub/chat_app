import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({ Key? key, required this.url, required this.radius });

  final String url;
  final double radius;

  const Avatar.small({Key? key, required this.url, this.radius = 16 });
  const Avatar.medium({Key? key, required this.url, this.radius = 22 });
  const Avatar.large({Key? key, required this.url, this.radius = 44 });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(url),
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}
