import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ListSkeleton extends StatefulWidget {
  const ListSkeleton({Key? key}) : super(key: key);

  @override
  State<ListSkeleton> createState() => _ListSkeletonState();
}

class _ListSkeletonState extends State<ListSkeleton> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  shape: BoxShape.rectangle,
                  width: MediaQuery.of(context).size.width / 3,
                  height: 100,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
