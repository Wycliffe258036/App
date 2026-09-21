import 'package:flutter/material.dart';

import '../../models/story.dart';
import '../../theme/app_typography.dart';
import '../common/default_avatar.dart';

class StoryBubble extends StatelessWidget {
  final Story story;

  final VoidCallback? onTap;

  final double size;

  const StoryBubble({
    super.key,
    required this.story,
    this.onTap,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${story.user.displayName} story',
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: size + 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStoryRing(),

              const SizedBox(height: 3),

              _buildName(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryRing() {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildOuterRing(),

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: _buildAvatar(),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildOuterRing() {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: story.isViewed
            ? const LinearGradient(
                colors: [
                  Color(0xFFD5D5D5),
                  Color(0xFFBDBDBD),
                ],
              )
            : const SweepGradient(
                colors: [
                  Color(0xFFFF3D81),
                  Color(0xFFFF8A3D),
                  Color(0xFFFFD23F),
                  Color(0xFFCB4CFF),
                  Color(0xFFFF3D81),
                ],
              ),
      ),
      child: const SizedBox.expand(),
    );
  }

 Widget _buildAvatar() {
    final avatarUrl = story.user.avatarUrl;
    final avatarSlotSize = size - 6; // matches the 3px ring padding inset

    if (avatarUrl == null || avatarUrl.isEmpty) {
      return DefaultAvatar(user: story.user, size: avatarSlotSize);
    }

    return Image.network(
      avatarUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return DefaultAvatar(user: story.user, size: avatarSlotSize);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return DefaultAvatar(user: story.user, size: avatarSlotSize);
      },
    );
  }

  Widget _buildName() {
    return SizedBox(
      width: size + 8,
      child: Text(
        story.user.displayName,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.caption(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF222222),
        ),
      ),
    );
  }
}