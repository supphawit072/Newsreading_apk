import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key, required Null Function() onLiked})
      : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  int likeCount = 0;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              isLiked = !isLiked;
              likeCount += isLiked ? 1 : -1;
            });
          },
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : null,
          ),
        ),
        Text('$likeCount'),
      ],
    );
  }
}
