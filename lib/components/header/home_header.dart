import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../theme/app_typography.dart';
import '../common/notification_button.dart';
//import '../common/search_button.dart';
import 'greeting_banner.dart';

class HomeHeader extends StatefulWidget {
  final User currentUser;

  final String appName;

  final int unreadNotifications;

  final String? greeting;

  final String? greetingSubtitle;

  final VoidCallback? onMenuPressed;

  final VoidCallback? onNotificationPressed;

  final bool showGreeting;

  final Duration greetingVisibleDuration;

  const HomeHeader({
    super.key,
    required this.currentUser,
    this.appName = 'Babangang',
    this.unreadNotifications = 0,
    this.greeting,
    this.greetingSubtitle,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.showGreeting = true,
    this.greetingVisibleDuration = const Duration(
      milliseconds: 3000,
    ),
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader>
    with SingleTickerProviderStateMixin {
  bool _greetingVisible = false;

  Timer? _greetingTimer;

  @override
  void initState() {
    super.initState();

    if (widget.showGreeting) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        setState(() {
          _greetingVisible = true;
        });

        _scheduleGreetingHide();
      });
    }
  }

  void _scheduleGreetingHide() {
    _greetingTimer?.cancel();

    _greetingTimer = Timer(
      widget.greetingVisibleDuration,
      () {
        if (!mounted) return;

        setState(() {
          _greetingVisible = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _greetingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final greeting = widget.greeting ??
        'Hello ${widget.currentUser.displayName} 👋';

    final subtitle =
        widget.greetingSubtitle ?? 'Have a great day!';

    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTopBar(),

         AnimatedSize(
           duration: const Duration(
             milliseconds: 650,
           ),
            reverseDuration: const Duration(
              milliseconds: 500,
           ),
           curve: Curves.easeOutBack,
            alignment: Alignment.topCenter,
            child: _greetingVisible
                ? _buildAnimatedGreeting(
                    greeting,
                    subtitle,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return SizedBox(
      height: 58,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        child: Row(
          children: [
            _buildMenuButton(),

            Expanded(
              child: Center(
                child: Text(
                  widget.appName,
                  style: AppTypography.title(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF151515),
                  ),
                ),
              ),
            ),

            NotificationButton(
              unreadCount: widget.unreadNotifications,
              onPressed: widget.onNotificationPressed,
              size: 44,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return Semantics(
      button: true,
      label: 'Open menu',
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: widget.onMenuPressed,
          customBorder: const CircleBorder(),
          child: const SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: Icon(
                Icons.grid_view_rounded,
                size: 25,
                color: Color(0xFF171717),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedGreeting(
    String greeting,
    String subtitle,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: -1.0,
        end: 0.0,
      ),
      duration: const Duration(
        milliseconds: 650,
      ),
      curve: Curves.easeOutBack,
      builder: (
        context,
        value,
        child,
      ) {
        return FractionalTranslation(
          translation: Offset(
            0,
            value,
          ),
          child: child,
        );
      },
      child: GreetingBanner(
        greeting: greeting,
        subtitle: subtitle,
      ),
    );
  }
}