import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/home_data.dart';
import '../../models/home_state.dart';
import '../../models/media.dart';
import '../../models/post.dart';
import '../../models/story.dart';
import '../../models/user.dart';
import '../../theme/sky_gradient_background.dart';

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
    const felix = User(
      id: 'user_felix',
      username: 'felix.codes',
      displayName: 'Felix',
      // Deliberately no avatarUrl or avatarPath — exercises the
      // DefaultAvatar/initials fallback wherever Felix's avatar shows
      // up, both as a post author and in a reshare row.
    );

    const maya = User(
      id: 'user_maya',
      username: 'maya.frames',
      displayName: 'Maya',
      avatarUrl: 'https://i.pravatar.cc/150?img=45',
    );
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

     const sofia = User(
      id: 'user_iza',
      username: 'izaa',
      displayName: 'Iza',
    );

    // ---------------------------------------------------------------
    // POST USERS
    // ---------------------------------------------------------------

    const hirra = User(
      id: 'hirra',
      username: 'damsel❤️🙈',
      displayName: 'Hirra',
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
    const wycliffe = User(
      id: 'Admin',
      username: 'wycliffe.ishaku',
      displayName: 'Wycliffe',
      isVerified: true,
      avatarPath: 'assets/images/Screenshot_20250131-231554.PNG',
    );
    const destiny = User(
      id: 'destiny',
      username: 'dezny',
      displayName: 'Destiny',
      avatarPath: 'assets/images/Screenshot_20250205-164510.PNG',
    );
    const shiktra = User(
      id: 'shiktra',
      username: 'shik_shik',
      displayName: 'Shiktra',
      avatarPath: 'assets/images/Screenshot_20250126-173721.PNG',
    );
    //const joshua = User(
      //id: 'joshua',
      //username: 'josh',
      //displayName: 'Joshua',
      //avatarUrl: 'https://i.pravatar.cc/150?img=12',
    //);
    //const steve = User(
      //id: 'steve',
      //username: 'steve',
      //displayName: 'Steve',
      //avatarUrl: 'https://i.pravatar.cc/150?img=13',
    //);
    //const alex = User(
      //id: 'alex',
      //username: 'alex',
      //displayName: 'Alex',
      //avatarUrl: 'https://i.pravatar.cc/150?img=19',
    //);
    //const princewill = User(
      //id: 'princewill',
      //username: 'princewill',
      //displayName: 'Ray',
      //avatarUrl: 'https://i.pravatar.cc/150?img=16',
    //);



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

      Story(
        id: 'story_jordan',
        user: jordan,
        media: const Media(
          id: 'media_jordan',
          type: MediaType.image,
          url: 'https://picsum.photos/400/700?random=15',
        ),
        createdAt: now.subtract(const Duration(minutes: 40)),
        expiresAt: now.add(const Duration(hours: 23)),
        viewed: true,
        caption: 'Coffee first ☕',
        likeCount: 34,
        reshareCount: 2,
      ),

      Story(
        id: 'story_sofia_1',
        user: sofia,
        media: const Media(
          id: 'media_sofia_1',
          type: MediaType.image,
          url: 'https://picsum.photos/400/700?random=16',
        ),
        createdAt: now.subtract(const Duration(hours: 3)),
        expiresAt: now.add(const Duration(hours: 21)),
        caption: 'Golden hour, part one 🌇',
        likeCount: 58,
        reshareCount: 4,
      ),

      Story(
        id: 'story_sofia_2',
        user: sofia,
        media: const Media(
          id: 'media_sofia_2',
          type: MediaType.image,
          url: 'https://picsum.photos/400/700?random=17',
        ),
        createdAt: now.subtract(const Duration(hours: 2, minutes: 40)),
        expiresAt: now.add(const Duration(hours: 21, minutes: 20)),
        caption: 'Golden hour 🌅',
        likeCount: 41,
        reshareCount: 1,
      ),

      Story(
        id: 'story_hirra',
        user: hirra,
        media: const Media(
          id: 'media_sofia_2',
          type: MediaType.image,
          url: 'https://picsum.photos/400/700?random=18',
        ),
        createdAt: now.subtract(const Duration(hours: 2, minutes: 40)),
        expiresAt: now.add(const Duration(hours: 21, minutes: 20)),
        caption: 'Golden hour',
        likeCount: 4907,
        reshareCount: 10,
      ),
    ];




    // ---------------------------------------------------------------
    // POSTS
    // ---------------------------------------------------------------

    // ---------------------------------------------------------------
    // POSTS
    //
    // One post per capability PostCard currently renders, each
    // commented with what it's specifically testing.
    // ---------------------------------------------------------------

    // TEST: reshare wrapping an image post, with a share caption.
    final sharedImagePost = Post(
      id: 'post_006',
      author: hirra,
      type: PostType.image,
      text: 'Love you, mine ❤️ #love #foryou #beautiful',
      media: const [
        Media(
          id: 'post_media_006',
          type: MediaType.image,
          url: 'https://picsum.photos/900/1100?random=31',
          aspectRatio: 4 / 5,
        ),
      ],
      sharedFrom: SharedPostInfo(
        sharedBy: jordan,
        originalPostId: 'post_001',
        sharedAt: now.subtract(const Duration(minutes: 5)),
        shareCaption: 'This made my whole week 🥹',
      ),
      likeCount: 1245,
      commentCount: 173,
      shareCount: 229,
      createdAt: now.subtract(const Duration(minutes: 5)),
    );

    // TEST: reshare wrapping a TEXT-ONLY post — this combination
    // (sharedFrom + no media) wasn't covered before. Also puts
    // Felix's no-avatar user into the small reshare-row avatar.
    final sharedTextPost = Post(
      id: 'post_012',
      author: wycliffe,
      type: PostType.text,
      text: 'Three years ago I quit my job to write full-time. No regrets.',
      sharedFrom: SharedPostInfo(
        sharedBy: felix,
        originalPostId: 'post_005',
        sharedAt: now.subtract(const Duration(minutes: 12)),
        shareCaption: 'This really resonated with me.',
      ),
      likeCount: 643,
      commentCount: 87,
      shareCount: 12,
      createdAt: now.subtract(const Duration(minutes: 12)),
    );

    // TEST: standard portrait (4:5) image post — the common case.
    final imagePostPortrait = Post(
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
      createdAt: now.subtract(const Duration(minutes: 18)),
    );

    // TEST: square (1:1) image + an author with NO avatar at all, so
    // the header falls back to DefaultAvatar's initial ("F"). Also
    // "likes only" engagement (comments = 0).
    final imagePostSquare = Post(
      id: 'post_007',
      author: felix,
      type: PostType.image,
      text: 'Finally got the home office looking right. 🖥️',
      media: const [
        Media(
          id: 'post_media_007',
          type: MediaType.image,
          url: 'https://picsum.photos/900/900?random=51',
          aspectRatio: 1,
        ),
      ],
      likeCount: 42,
      commentCount: 0,
      shareCount: 3,
      createdAt: now.subtract(const Duration(hours: 1, minutes: 10)),
    );

    // TEST: broken/unreachable image URL — should fall back to the
    // grey "image not supported" placeholder. Uses the .invalid TLD,
    // which is reserved by RFC 2606 to never resolve, so this test is
    // deterministic regardless of network. Author (Jordan) has an
    // already-viewed story, so this card's ring shows the MUTED variant.
    final imagePostBroken = Post(
      id: 'post_002',
      author: jordan,
      type: PostType.image,
      text: 'A little moment from today. ✨ (this image is deliberately broken)',
      media: const [
        Media(
          id: 'post_media_002',
          type: MediaType.image,
          url: 'https://not-a-real-domain.invalid/broken.jpg',
          aspectRatio: 16 / 9,
        ),
      ],
      likeCount: 386,
      commentCount: 42,
      shareCount: 31,
      createdAt: now.subtract(const Duration(hours: 2)),
    );

    // TEST: landscape (16:9) image + ZERO likes/comments — the
    // engagement summary line should be hidden entirely.
    final imagePostLandscapeNoEngagement = Post(
      id: 'post_008',
      author: maya,
      type: PostType.image,
      text: 'Somewhere over the hills this morning.',
      media: const [
        Media(
          id: 'post_media_008',
          type: MediaType.image,
          url: 'https://picsum.photos/1200/675?random=52',
          aspectRatio: 16 / 9,
        ),
      ],
      likeCount: 0,
      commentCount: 0,
      shareCount: 0,
      createdAt: now.subtract(const Duration(hours: 3, minutes: 30)),
    );

    // TEST: video WITH thumbnail + duration badge. Sofia's story is
    // still unviewed, so this card's ring shows the vivid variant.
    // Numbers exercise all three count formats at once: likes in
    // millions, comments in thousands, shares as a plain number.
    final videoPostWithThumbnail = Post(
      id: 'post_003',
      author: sofia,
      type: PostType.video,
      text: 'Chasing sunsets in Santorini 🌅 #travel #wanderlust',
      media: const [
        Media(
          id: 'post_media_003',
          type: MediaType.video,
          url: 'https://example.com/video-santorini.mp4',
          thumbnailUrl: 'https://picsum.photos/900/1100?random=41',
          aspectRatio: 4 / 5,
          durationMs: 34000,
        ),
      ],
      likeCount: 1250000,
      commentCount: 3400,
      shareCount: 812,
      createdAt: now.subtract(const Duration(hours: 4)),
    );

    // TEST: video with NO thumbnail and NO duration — falls back to
    // the plain dark background + video icon, no duration badge.
    // Also "comments only" engagement (likes = 0).
    final videoPostNoThumbnail = Post(
      id: 'post_009',
      author: destiny,
      type: PostType.video,
      text: 'Testing the new mic setup — full video soon 🎙️',
      media: const [
        Media(
          id: 'post_media_009',
          type: MediaType.video,
          url: 'https://example.com/video-mic-test.mp4',
        ),
      ],
      likeCount: 0,
      commentCount: 12,
      shareCount: 0,
      createdAt: now.subtract(const Duration(hours: 5)),
    );

    // TEST: carousel mixing image AND video slides (4 items) — page
    // dots, plus each video slide gets its own play button + duration.
    final carouselMixedMedia = Post(
      id: 'post_004',
      author: shiktra,
      type: PostType.carousel,
      text: "Behind the scenes from today's shoot 🎬✨ swipe for the clips",
      media: const [
        Media(
          id: 'post_media_004a',
          type: MediaType.image,
          url: 'https://picsum.photos/900/1100?random=42',
          aspectRatio: 4 / 5,
        ),
        Media(
          id: 'post_media_004b',
          type: MediaType.video,
          url: 'https://example.com/video-bts-1.mp4',
          thumbnailUrl: 'https://picsum.photos/900/1100?random=43',
          durationMs: 18000,
        ),
        Media(
          id: 'post_media_004c',
          type: MediaType.image,
          url: 'https://picsum.photos/900/1100?random=44',
        ),
        Media(
          id: 'post_media_004d',
          type: MediaType.video,
          url: 'https://example.com/video-bts-2.mp4',
          thumbnailUrl: 'https://picsum.photos/900/1100?random=45',
          durationMs: 9000,
        ),
      ],
      likeCount: 2210,
      commentCount: 98,
      shareCount: 54,
      createdAt: now.subtract(const Duration(hours: 6)),
    );

    // TEST: the minimal carousel case — exactly 2 image slides, so
    // only 2 page dots appear.
    final carouselTwoImages = Post(
      id: 'post_010',
      author: maya,
      type: PostType.carousel,
      text: 'A tale of two coffees ☕☕',
      media: const [
        Media(
          id: 'post_media_010a',
          type: MediaType.image,
          url: 'https://picsum.photos/900/1100?random=53',
          aspectRatio: 4 / 5,
        ),
        Media(
          id: 'post_media_010b',
          type: MediaType.image,
          url: 'https://picsum.photos/900/1100?random=54',
          aspectRatio: 4 / 5,
        ),
      ],
      likeCount: 318,
      commentCount: 27,
      shareCount: 9,
      createdAt: now.subtract(const Duration(hours: 7)),
    );

    // TEST: short text-only post (no media at all).
    final textPostShort = Post(
      id: 'post_005',
      author: hirra,
      type: PostType.text,
      text: 'Three years ago I quit my job to write full-time. No regrets — '
          'just a lot of coffee and a very patient cat. Ask me anything '
          'about the jump. 📝',
      likeCount: 643,
      commentCount: 87,
      shareCount: 12,
      createdAt: now.subtract(const Duration(hours: 8)),
    );

    // TEST: a much longer text-only post, to check wrapping over
    // several lines with nothing truncated (the below-image caption
    // has no maxLines, unlike the overlaid header caption elsewhere).
    final textPostLong = Post(
      id: 'post_011',
      author: felix,
      type: PostType.text,
      text: 'Spent the weekend finally refactoring the side project I keep '
          'putting off. Turns out most of what I thought was "one big '
          'problem" was actually five small ones wearing a trench coat. '
          'Broke it apart, wrote a few tests, and now it feels like a '
          'completely different codebase — in a good way. Anyone else '
          'find that naming things properly the second time around is '
          'somehow harder than the first?',
      likeCount: 211,
      commentCount: 34,
      shareCount: 6,
      createdAt: now.subtract(const Duration(hours: 10)),
    );

    final posts = [
      sharedImagePost,
      sharedTextPost,
      imagePostPortrait,
      imagePostSquare,
      imagePostBroken,
      imagePostLandscapeNoEngagement,
      videoPostWithThumbnail,
      videoPostNoThumbnail,
      carouselMixedMedia,
      carouselTwoImages,
      textPostShort,
      textPostLong,
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
  // POST INTERACTION
  // ================================================================

  void _handlePostLike(String postId) {
    final data = _state.data;
    if (data == null) return;

    final index = data.feed.indexWhere((item) => item.post?.id == postId);
    if (index < 0) return;

    final post = data.feed[index].post;
    if (post == null) return;

    final liked = !post.isLiked;

    _updateFeedPost(
      index,
      post.copyWith(
        isLiked: liked,
        likeCount: liked
            ? post.likeCount + 1
            : (post.likeCount > 0 ? post.likeCount - 1 : 0),
      ),
    );
  }

  void _handlePostSave(String postId) {
    final data = _state.data;
    if (data == null) return;

    final index = data.feed.indexWhere((item) => item.post?.id == postId);
    if (index < 0) return;

    final post = data.feed[index].post;
    if (post == null) return;

    _updateFeedPost(index, post.copyWith(isSaved: !post.isSaved));
  }

  void _updateFeedPost(int index, Post updatedPost) {
    final data = _state.data;
    if (data == null) return;

    final updatedFeed = List<FeedItem>.from(data.feed);

    updatedFeed[index] = FeedItem(
      id: updatedFeed[index].id,
      type: updatedFeed[index].type,
      post: updatedPost,
      ad: updatedFeed[index].ad,
    );

    final updatedData = HomeData(
      header: data.header,
      stories: data.stories,
      suggestedUsers: data.suggestedUsers,
      feed: updatedFeed,
      pagination: data.pagination,
    );

    setState(() {
      _state = _state.copyWith(data: updatedData);
    });
  }

    // ================================================================
  // POST AUTHOR INTERACTION
  // ================================================================

  void _handlePostAuthorTap(User user) {
    final data = _state.data;
    if (data == null) return;

    final activeStories = data.stories
        .where((story) => story.user.id == user.id && story.isLive)
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    if (activeStories.isEmpty) {
      _showProfileNavigationPlaceholder();
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryViewer(
          stories: activeStories,
          initialIndex: 0,
          onStoryViewed: (viewedStory) {
            _markStoryViewed(viewedStory.id);
          },
          onStoryChanged: _handleStoryChanged,
        ),
      ),
    );
  }

  void _showProfileNavigationPlaceholder() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          content: const Text(
            'This action will take you to the profile page of this user.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
    return SkyGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: HomeRenderer(
          state: _state,
          onRefresh: _refreshHome,
          onStoryTap: _handleStoryTap,
          onCreateStoryTap: _handleCreateStory,
          onPostLike: _handlePostLike,
          onPostSave: _handlePostSave,
          onPostAuthorTap: _handlePostAuthorTap,
        ),
      ),
    );
  }
}  