import 'package:flutter/material.dart';

import '../../models/media.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../common/Avatar.dart';
import '../../theme/app_typography.dart';

class PostCard extends StatefulWidget {
  final Post post;

  final VoidCallback? onComment;

  final VoidCallback? onShare;

  final VoidCallback? onSave;

  const PostCard({
    super.key,
    required this.post,
    this.onComment,
    this.onShare,
    this.onSave,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool _isLiked;
  late bool _isSaved;
  late int _likeCount;

  @override
  void initState() {
    super.initState();

    _isLiked = widget.post.isLiked;
    _isSaved = widget.post.isSaved;
    _likeCount = widget.post.likeCount;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;

      if (_isLiked) {
        _likeCount++;
      } else if (_likeCount > 0) {
        _likeCount--;
      }
    });
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });

    widget.onSave?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),

          if (widget.post.sharedFrom != null) ...[
            const SizedBox(height: 8),
            _buildSharedFrom(),
          ],

          if (widget.post.hasMedia) ...[
            const SizedBox(height: 12),
            _buildMedia(),
          ],

          if (widget.post.text != null &&
              widget.post.text!.trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildCaption(),
          ],

          const SizedBox(height: 10),

          _buildActions(),

          const SizedBox(height: 4),

          _buildEngagementSummary(),

          const SizedBox(height: 12),

          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEDEDED),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // HEADER
  // ================================================================

  Widget _buildHeader() {
    final user = widget.post.author;

    return Row(
      children: [
        _buildAvatar(
          user,
          size: 42,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      user.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  if (user.isVerified) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified_rounded,
                      size: 15,
                      color: Color(0xFF287BEA),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 2),

              Text(
                '@${user.username}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption(
                  fontSize: 12,
                  color: const Color(0xFF777777),
                ),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_horiz_rounded,
            size: 22,
          ),
          splashRadius: 20,
          color: const Color(0xFF555555),
        ),
      ],
    );
  }

  Widget _buildSharedFrom() {
    final shared = widget.post.sharedFrom!;
    return Row(
      children: [
        Avatar(
          user: shared.sharedBy,
          size: 26,
          showVerificationBadge: false,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Shared from ${shared.sharedBy.displayName}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF666666),
            ),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // MEDIA
  // ================================================================

  Widget _buildMedia() {
    final post = widget.post;

    if (post.isCarousel) {
      return _buildCarousel();
    }

    if (post.isVideo) {
      return _buildVideo();
    }

    final media = post.media.first;

    return _buildImage(
      media,
    );
  }

  Widget _buildImage(Media media) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: media.aspectRatio ?? 4 / 5,
        child: Image.network(
          media.optimizedUrl ?? media.url,
          fit: BoxFit.cover,
          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return _buildMediaError();
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
              color: const Color(0xFFEFEFEF),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: PageView.builder(
          itemCount: widget.post.media.length,
          itemBuilder: (
            context,
            index,
          ) {
            return _buildCarouselImage(
              widget.post.media[index],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCarouselImage(Media media) {
    return Image.network(
      media.optimizedUrl ?? media.url,
      fit: BoxFit.cover,
      errorBuilder: (
        context,
        error,
        stackTrace,
      ) {
        return _buildMediaError();
      },
    );
  }

  Widget _buildVideo() {
    final media = widget.post.media.first;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: media.aspectRatio ?? 4 / 5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (media.thumbnailUrl != null)
              Image.network(
                media.thumbnailUrl!,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return _buildVideoBackground();
                },
              )
            else
              _buildVideoBackground(),

            Container(
              color: Colors.black.withOpacity(0.12),
            ),

            const Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xAA111111),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoBackground() {
    return Container(
      color: const Color(0xFF222222),
      child: const Center(
        child: Icon(
          Icons.videocam_rounded,
          color: Colors.white54,
          size: 48,
        ),
      ),
    );
  }

  Widget _buildMediaError() {
    return Container(
      color: const Color(0xFFECECEC),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Color(0xFF999999),
          size: 42,
        ),
      ),
    );
  }

  // ================================================================
  // CAPTION
  // ================================================================

  Widget _buildCaption() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: widget.post.text!,
            style: AppTypography.body(
              fontSize: 14,
              color: const Color(0xFF222222),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // ACTIONS
  // ================================================================

  Widget _buildActions() {
    return Row(
      children: [
        _ActionButton(
          icon: _isLiked
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          label: _formatCount(_likeCount),
          active: _isLiked,
          onTap: _toggleLike,
        ),

        const SizedBox(width: 18),

        _ActionButton(
          icon: Icons.chat_bubble_outline_rounded,
          label: _formatCount(
            widget.post.commentCount,
          ),
          onTap: widget.onComment,
        ),

        const SizedBox(width: 18),

        _ActionButton(
          icon: Icons.send_outlined,
          label: _formatCount(
            widget.post.shareCount,
          ),
          onTap: widget.onShare,
        ),

        const Spacer(),

        IconButton(
          onPressed: _toggleSave,
          icon: Icon(
            _isSaved
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            size: 22,
          ),
          color: const Color(0xFF222222),
          splashRadius: 20,
          tooltip: 'Save',
        ),
      ],
    );
  }

  // ================================================================
  // ENGAGEMENT
  // ================================================================

  Widget _buildEngagementSummary() {
    final comments = widget.post.commentCount;

    if (_likeCount == 0 && comments == 0) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (_likeCount > 0)
          Text(
            '$_likeCount ${_likeCount == 1 ? 'like' : 'likes'}',
            style: AppTypography.caption(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF555555),
            ),
          ),

        if (_likeCount > 0 && comments > 0)
          const SizedBox(width: 12),

        if (comments > 0)
          Text(
            '$comments ${comments == 1 ? 'comment' : 'comments'}',
            style: AppTypography.caption(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF555555),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatar(
    User user, {
    required double size,
  }) {
    return Avatar(
      user: user,
      size: size,
      showVerificationBadge: false,
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    }

    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }

    return count.toString();
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;

  final String label;

  final bool active;

  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: active
                  ? const Color(0xFFE83D68)
                  : const Color(0xFF222222),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: AppTypography.caption(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF555555),
              ),
            ),
          ],
        ),
      ),
    );
  }
}