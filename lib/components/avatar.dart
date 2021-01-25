import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(this.avatarAsset, {Key key, this.radius = 5.0, this.size = 40})
      : super(key: key);

  final String avatarAsset;
  final double radius;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size, maxWidth: size),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image(
          width: size,
          height: size,
          fit: BoxFit.cover,
          image: AssetImage(avatarAsset),
        ),
      ),
    );
  }
}
