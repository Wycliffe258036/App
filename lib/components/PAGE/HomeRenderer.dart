import 'package:flutter/material.dart';

import '../../models/home_state.dart';
import '../../models/post.dart';
import '../../models/story.dart';
import '../../models/user.dart';
import '../POST/PostCard.dart';
import '../header/home_header.dart';
import '../stories/stories_row_skeleton.dart';
import '../stories/story_row.dart';
import '../STATES/post_skeleton.dart';

class HomeRenderer extends StatelessWidget {
  final HomeState state;
  final Future<void> Function()? onRefresh;
  final ValueChanged<Story>? onStoryTap;
  final VoidCallback? onCreateStoryTap;

  const HomeRenderer({
    super.key,
    required this.state,
    this.onRefresh,
    this.onStoryTap,
    this.onCreateStoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildStories()),
            SliverToBoxAdapter(child: _buildFeed()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final data = state.data;
    final currentUser = data?.header.currentUser ??
        const User(id: '', username: '', displayName: '');

    return HomeHeader(
      currentUser: currentUser,
      appName: 'Asterisk',
      unreadNotifications: data?.header.unreadNotifications ?? 0,
    );
  }

  Widget _buildStories() {
    // During the first load there is no content to preserve, so show the
    // skeleton. During refresh we deliberately keep the existing stories.
    if (state.status == HomeStatus.initial ||
        state.status == HomeStatus.loading) {
      return const StoryRowSkeleton();
    }

    final data = state.data;
    if (data == null || data.stories.isEmpty) {
      return const SizedBox.shrink();
    }

    return StoryRow(
      currentUser: data.header.currentUser,
      stories: data.stories,
      onStoryTap: onStoryTap,
      onCreateStoryTap: onCreateStoryTap,
    );
  }

  Widget _buildFeed() {
    if (state.status == HomeStatus.initial ||
        state.status == HomeStatus.loading) {
      return _buildFeedLoading();
    }

    final data = state.data;

    if (state.status == HomeStatus.error && data == null) {
      return _buildFeedError();
    }

    if (data == null || data.feed.isEmpty) {
      return _buildFeedEmpty();
    }

    // loaded, refreshing and loadingMore all keep rendering the current feed.
    return _buildFeedContent(data.feed);
  }

  Widget _buildFeedLoading() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostSkeleton(),
          SizedBox(height: 12),
          PostSkeleton(),
        ],
      ),
    );
  }

  Widget _buildFeedContent(List<FeedItem> feed) {
    return Column(
      children: feed.map((item) {
        if (item.type == FeedItemType.post && item.post != null) {
          return PostCard(
            key: ValueKey(item.id),
            post: item.post!,
          );
        }

        // Advertising will be wired to AdPostCard in the advertising
        // checkpoint. Keeping unsupported feed items invisible is safer than
        // rendering a broken placeholder.
        return const SizedBox.shrink();
      }).toList(),
    );
  }

  Widget _buildFeedEmpty() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 40),
      child: Center(
        child: Text('There are no posts to show yet.'),
      ),
    );
  }

  Widget _buildFeedError() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Center(
        child: Text('Something went wrong while loading your feed.'),
      ),
    );
  }
}
