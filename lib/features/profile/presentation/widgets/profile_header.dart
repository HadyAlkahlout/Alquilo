import 'package:alquilo/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String image;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        CircleAvatar(
          radius: AppSize.s40,
          backgroundImage: NetworkImage(image),
        ),

        SizedBox(width: AppPaddings.p16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textTheme.titleLarge,
              ),

              SizedBox(height: AppPaddings.p4),

              Text(
                email,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}