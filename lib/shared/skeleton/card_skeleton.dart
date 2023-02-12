import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CardSkeleton extends StatefulWidget {
  const CardSkeleton({Key? key}) : super(key: key);

  @override
  State<CardSkeleton> createState() => _CardSkeletonState();
}

class _CardSkeletonState extends State<CardSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.20,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: SkeletonItem(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      shape: BoxShape.rectangle,
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      width: MediaQuery.of(context).size.width / 3,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      width: MediaQuery.of(context).size.width / 2.2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      width: MediaQuery.of(context).size.width / 2.2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      shape: BoxShape.rectangle,
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      width: MediaQuery.of(context).size.width / 3,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      width: MediaQuery.of(context).size.width / 2.2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      width: MediaQuery.of(context).size.width / 2.2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
