import 'package:flutter/material.dart';

import '../../models/story.dart';
import '../../theme/app_typography.dart';

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

          if (story.isLive)
            Positioned(
              left: 3,
              bottom: 0,
              child: _buildLiveBadge(),
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

    if (avatarUrl == null || avatarUrl.isEmpty) {
      return Container(
        color: const Color(0xFFE8E8E8),
        child: const Icon(
          Icons.person_rounded,
          color: Color(0xFF888888),
          size: 30,
        ),
      );
    }

    return Image.network(
      avatarUrl,
      fit: BoxFit.cover,
      errorBuilder: (
        context,
        error,
        stackTrace,
      ) {
        return Container(
          color: const Color(0xFFE8E8E8),
          child: const Icon(
            Icons.person_rounded,
            color: Color(0xFF888888),
            size: 30,
          ),
        );
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return Container(
          color: const Color(0xFFE8E8E8),
          child: const Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3D6E),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      child: Text(
        'LIVE',
        style: AppTypography.caption(
          fontSize: 8,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
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