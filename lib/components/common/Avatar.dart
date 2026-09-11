import 'package:flutter/material.dart';

import '../../models/user.dart';

class Avatar extends StatelessWidget {
  final User user;
  final double size;
  final bool showVerificationBadge;
  final bool showOnlineIndicator;
  final VoidCallback? onPressed;

  const Avatar({
    super.key,
    required this.user,
    this.size = 44,
    this.showVerificationBadge = true,
    this.showOnlineIndicator = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Widget avatar = SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildAvatar(),
          if (showVerificationBadge && user.isVerified)
            _buildVerificationBadge(),
          if (showOnlineIndicator) _buildOnlineIndicator(),
        ],
      ),
    );

    if (onPressed != null) {
      avatar = GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildAvatar() {
    final localPath = user.avatarPath;
    final imageUrl = user.avatarUrl;

    Widget image;

    if (localPath != null && localPath.isNotEmpty) {
      image = Image.asset(
        localPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildNetworkOrFallback(imageUrl);
        },
      );
    } else {
      image = _buildNetworkOrFallback(imageUrl);
    }

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE8E8E8),
      ),
      clipBehavior: Clip.antiAlias,
      child: image,
    );
  }

  Widget _buildNetworkOrFallback(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildFallback();
        },
      );
    }

    return _buildFallback();
  }

  Widget _buildFallback() {
    final initial = user.displayName.isNotEmpty
        ? user.displayName[0].toUpperCase()
        : '?';

    return Center(
      child: Text(
        initial,
        style: TextStyle(
          fontSize: size * 0.38,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF666666),
        ),
      ),
    );
  }

  Widget _buildVerificationBadge() {
    final badgeSize = size * 0.28;

    return Positioned(
      right: -1,
      bottom: -1,
      child: Container(
        width: badgeSize,
        height: badgeSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF2196F3),
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: badgeSize * 0.65,
        ),
      ),
    );
  }

  Widget _buildOnlineIndicator() {
    final indicatorSize = size * 0.22;

    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        width: indicatorSize,
        height: indicatorSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF32CD72),
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
