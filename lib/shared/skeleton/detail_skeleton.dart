import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class DetailSkeleton extends StatefulWidget {
  const DetailSkeleton({Key? key}) : super(key: key);

  @override
  State<DetailSkeleton> createState() => _DetailSkeletonState();
}

class _DetailSkeletonState extends State<DetailSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: SkeletonItem(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  shape: BoxShape.rectangle,
                  width: MediaQuery.of(context).size.width / 0.8,
                  height: 200,
                ),
              ),
              const SizedBox(height: 8),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 2,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 2,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 12),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 0.8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 0.8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 0.8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 0.8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 0.8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
