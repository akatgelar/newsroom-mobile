import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SliderSkeleton extends StatefulWidget {
  const SliderSkeleton({Key? key}) : super(key: key);

  @override
  State<SliderSkeleton> createState() => _SliderSkeletonState();
}

class _SliderSkeletonState extends State<SliderSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.20,
      child: SkeletonItem(
        child: Row(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                shape: BoxShape.rectangle,
                width: MediaQuery.of(context).size.width / 1.3,
                height: 120,
                padding: const EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
