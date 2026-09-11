import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/home_data.dart';
import '../../models/home_state.dart';
import '../../models/media.dart';
import '../../models/post.dart';
import '../../models/story.dart';
import '../../models/user.dart';

import '../stories/story_viewer.dart';
import 'HomeRenderer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeState _state = const HomeState();

  final List<String> _viewedQueue = [];

  Timer? _flushTimer;

  @override
  void initState() {
    super.initState();

    _loadHome();
  }

  // ================================================================
  // LOAD HOME
  // ================================================================

  Future<void> _loadHome() async {
    if (!mounted) return;

    setState(() {
      _state = _state.copyWith(
        status: HomeStatus.loading,
      );
    });

    /*
     * DEVELOPMENT DATA
     *
     * Temporary local data.
     *
     * Later this will be replaced by:
     *
     * current user
     * stories
     * feed
     * suggestions
     * pagination
     *
     * from the Asterisk backend.
     */

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) return;

    final data = _createDevelopmentHomeData();

    setState(() {
      _state = HomeState(
        status: HomeStatus.loaded,
        data: data,
      );
    });
  }

  // ================================================================
  // REFRESH
  // ================================================================

  Future<void> _refreshHome() async {
    if (!mounted) return;

    setState(() {
      _state = _state.copyWith(
        status: HomeStatus.refreshing,
      );
    });

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) return;

    final data = _createDevelopmentHomeData();

    setState(() {
      _state = HomeState(
        status: HomeStatus.loaded,
        data: data,
      );
    });
  }

  // ================================================================
  // DEVELOPMENT DATA
  // ================================================================

  HomeData _createDevelopmentHomeData() {
    final now = DateTime.now();

    // ---------------------------------------------------------------
    // CURRENT USER
    // ---------------------------------------------------------------

    const currentUser = User(
      id: 'current_user',
      username: 'asterisk_user',
      displayName: 'Asterisk User',
    );

    // ---------------------------------------------------------------
    // STORY USERS
    // ---------------------------------------------------------------

    const amanda = User(
      id: 'user_amanda',
      username: 'amanda',
      displayName: 'Amanda',
    );

    const luiz = User(
      id: 'user_luiz',
      username: 'luiz',
      displayName: 'Luiz',
    );

    const nina = User(
      id: 'user_nina',
      username: 'nina',
      displayName: 'Nina',
    );

    const iza = User(
      id: 'user_iza',
      username: 'izaa',
      displayName: 'Iza',
    );

    // ---------------------------------------------------------------
    // STORIES
    // ---------------------------------------------------------------

    final stories = [
      Story(
        id: 'story_amanda',
        user: amanda,
        media: const Media(
          id: 'media_amanda',
          type: MediaType.image,
          url: 'https://picsum.photos/400/700?random=11',
        ),
        createdAt: now.subtract(
          const Duration(minutes: 20),
        ),
        expiresAt: now.add(
          const Duration(hours: 23),
        ),
        caption: 'A beautiful day ✨',
        likeCount: 128,
        reshareCount: 14,
      ),

      Story(
        id: 'story_luiz',
        user: luiz,
        media: const Media(
          id: 'media_luiz',
          type: MediaType.image,
          url: 'https://picsum.photos/400/700?random=12',
        ),
        createdAt: now.subtract(
          const Duration(hours: 1),
        ),
        expiresAt: now.add(
          const Duration(hours: 22),
        ),
        caption: 'Keep moving forward 🚀',
        likeCount: 76,
        reshareCount: 8,
      ),

      Story(
        id: 'story_nina',
        user: nina,
        media: const Media(
          id: 'media_nina',
          type: MediaType.image,
          url: 'https://picsum.photos/400/700?random=13',
        ),
        createdAt: now.subtract(
          const Duration(hours: 2),
        ),
        expiresAt: now.add(
          const Duration(hours: 21),
        ),
        caption: 'Little moments matter.',
        likeCount: 203,
        reshareCount: 21,
      ),

      Story(
        id: 'story_iza',
        user: iza,
        media: const Media(
          id: 'media_iza',
          type: MediaType.image,
          url: 'https://picsum.photos/400/700?random=14',
        ),
        createdAt: now.subtract(
          const Duration(hours: 3),
        ),
        expiresAt: now.add(
          const Duration(hours: 20),
        ),
        caption: 'Weekend energy 💫',
        likeCount: 91,
        reshareCount: 11,
      ),
    ];

    // ---------------------------------------------------------------
    // POST USERS
    // ---------------------------------------------------------------

    const hirra = User(
      id: 'hirra',
      username: 'damsel❤️🙈',
      displayName: 'Hirra900',
      isVerified: true,
      avatarPath: 'assets/images/IMG_1449b.PNG',

      /*
       * DEVELOPMENT NOTE:
       *
       * Do NOT use a Windows path here.
       *
       * When we add the image to the Flutter assets folder,
       * this can become:
       *
       * avatarPath: 'assets/images/IMG_1449b.PNG',
       */
    );

    const jordan = User(
      id: 'user_jordan',
      username: 'jordan',
      displayName: 'Jordan',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    );

    // ---------------------------------------------------------------
    // POSTS
    // ---------------------------------------------------------------

    final posts = [
      Post(
        id: 'post_001',
        author: hirra,
        type: PostType.image,
        text: 'Love you, mine ❤️ #love #foryou #beautiful',
        media: const [
          Media(
            id: 'post_media_001',
            type: MediaType.image,
            url: 'https://picsum.photos/900/1100?random=31',
            aspectRatio: 4 / 5,
          ),
        ],
        likeCount: 1245,
        commentCount: 173,
        shareCount: 229,
        createdAt: now.subtract(
          const Duration(minutes: 18),
        ),
      ),

      Post(
        id: 'post_002',
        author: jordan,
        type: PostType.image,
        text: 'A little moment from today. ✨',
        media: const [
          Media(
            id: 'post_media_002',
            type: MediaType.image,
            url: 'https://picsum.photos/900/1100?random=32',
            aspectRatio: 4 / 5,
          ),
        ],
        likeCount: 386,
        commentCount: 42,
        shareCount: 31,
        createdAt: now.subtract(
          const Duration(hours: 2),
        ),
      ),
    ];

    // ---------------------------------------------------------------
    // FEED
    // ---------------------------------------------------------------

    final feed = posts
        .map(
          (post) => FeedItem(
            id: post.id,
            type: FeedItemType.post,
            post: post,
          ),
        )
        .toList();

    // ---------------------------------------------------------------
    // HOME DATA
    // ---------------------------------------------------------------

    return HomeData(
      header: HomeHeaderData(
        currentUser: currentUser,
        unreadNotifications: 2,
      ),
      stories: stories,
      feed: feed,
    );
  }

  // ================================================================
  // STORY INTERACTION
  // ================================================================

  void _handleStoryTap(Story story) {
    final data = _state.data;

    if (data == null) return;

    final index = data.stories.indexOf(story);

    if (index < 0) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryViewer(
          stories: data.stories,
          initialIndex: index,
          onStoryViewed: (viewedStory) {
            _markStoryViewed(viewedStory.id);
          },
          onStoryChanged: _handleStoryChanged,
        ),
      ),
    );
  }

  void _handleStoryChanged(Story updatedStory) {
    final data = _state.data;
    if (data == null) return;

    final index = data.stories.indexWhere(
      (story) => story.id == updatedStory.id,
    );
    if (index < 0) return;

    final updatedStories = List<Story>.from(data.stories);
    updatedStories[index] = updatedStory;

    final updatedData = HomeData(
      header: data.header,
      stories: updatedStories,
      suggestedUsers: data.suggestedUsers,
      feed: data.feed,
      pagination: data.pagination,
    );

    setState(() {
      _state = _state.copyWith(data: updatedData);
    });
  }

  // ================================================================
  // MARK STORY VIEWED
  // ================================================================

  void _markStoryViewed(String storyId) {
    final data = _state.data;

    if (data == null) return;

    final index = data.stories.indexWhere(
      (story) => story.id == storyId,
    );

    if (index < 0) return;

    final updatedStory = data.stories[index].copyWith(
      viewed: true,
    );

    final updatedStories = List<Story>.from(
      data.stories,
    );

    updatedStories[index] = updatedStory;

    final updatedData = HomeData(
      header: data.header,
      stories: updatedStories,
      suggestedUsers: data.suggestedUsers,
      feed: data.feed,
      pagination: data.pagination,
    );

    setState(() {
      _state = _state.copyWith(
        data: updatedData,
      );
    });

    _queueViewedEvent(storyId);
  }

  // ================================================================
  // VIEW EVENT QUEUE
  // ================================================================

  void _queueViewedEvent(String storyId) {
    if (!_viewedQueue.contains(storyId)) {
      _viewedQueue.add(storyId);
    }

    _flushTimer?.cancel();

    _flushTimer = Timer(
      const Duration(seconds: 3),
      _flushViewedEvents,
    );
  }

  Future<void> _flushViewedEvents() async {
    if (_viewedQueue.isEmpty) return;

    final events = List<String>.from(
      _viewedQueue,
    );

    _viewedQueue.clear();

    /*
     * BACKEND TODO:
     *
     * Later:
     *
     * await api.markStoriesViewed(events);
     */

    await Future.delayed(
      const Duration(milliseconds: 100),
    );

    debugPrint(
      'Story view events queued: $events',
    );
  }

  // ================================================================
  // CREATE STORY
  // ================================================================

  void _handleCreateStory() {
    /*
     * CREATE STORY TODO
     *
     * We will connect this to the real story creation
     * flow later.
     */
  }

  // ================================================================
  // DISPOSE
  // ================================================================

  @override
  void dispose() {
    _flushTimer?.cancel();

    super.dispose();
  }

  // ================================================================
  // BUILD
  // ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: HomeRenderer(
        state: _state,
        onRefresh: _refreshHome,
        onStoryTap: _handleStoryTap,
        onCreateStoryTap: _handleCreateStory,
      ),
    );
  }
}