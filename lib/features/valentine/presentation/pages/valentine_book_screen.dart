import 'package:flutter/material.dart';

import '../../data/valentine_content.dart';
import '../../domain/jump_target.dart';
import '../widgets/animated_heart_background.dart';
import '../widgets/content_pages.dart';
import '../widgets/navigation_controls.dart';
import '../widgets/spread_layout.dart';

class ValentineBookScreen extends StatefulWidget {
  const ValentineBookScreen({super.key, required this.onToggleThemeMode});

  final VoidCallback onToggleThemeMode;

  @override
  State<ValentineBookScreen> createState() => _ValentineBookScreenState();
}

class _ValentineBookScreenState extends State<ValentineBookScreen> {
  late final PageController _mobileController;
  late final PageController _wideController;

  int _mobileIndex = 0;
  int _wideIndex = 0;

  @override
  void initState() {
    super.initState();
    _mobileController = PageController();
    _wideController = PageController();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _wideController.dispose();
    super.dispose();
  }

  int get _widePageCount => 2 + kStorySections.length + 1;

  int get _mobilePageCount => 1 + (_widePageCount - 1) * 2;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundGradient = isDark
        ? const LinearGradient(
            colors: [Color(0xFF18141A), Color(0xFF231B24), Color(0xFF32202A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [Color(0xFFFFF8EF), Color(0xFFFFF1E6), Color(0xFFFDE6E8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Stack(
          children: [
            Positioned.fill(child: AnimatedHeartBackground(isDarkMode: isDark)),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 980;
                  final currentIndex = isWide ? _wideIndex : _mobileIndex;
                  final pageCount = isWide ? _widePageCount : _mobilePageCount;

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                        child: ValentineTopBar(
                          onJump: (target) => _jumpTo(target, isWide),
                          isDarkMode: isDark,
                          onToggleThemeMode: widget.onToggleThemeMode,
                        ),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 320),
                          child: isWide
                              ? _buildWidePager(constraints.maxWidth)
                              : _buildMobilePager(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                        child: ValentineBottomControls(
                          index: currentIndex,
                          total: pageCount,
                          canGoBack: currentIndex > 0,
                          canGoForward: currentIndex < pageCount - 1,
                          onBack: () => _stepPage(isWide: isWide, delta: -1),
                          onForward: () => _stepPage(isWide: isWide, delta: 1),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidePager(double screenWidth) {
    final horizontalPadding = screenWidth > 1300 ? 44.0 : 20.0;

    return Padding(
      key: const ValueKey('wide'),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
      child: PageView.builder(
        controller: _wideController,
        itemCount: _widePageCount,
        onPageChanged: (value) => setState(() => _wideIndex = value),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const CoverPage();
          }

          final spread = _wideSpreadFor(index);
          return SpreadView(left: spread.left, right: spread.right);
        },
      ),
    );
  }

  Widget _buildMobilePager() {
    return Padding(
      key: const ValueKey('mobile'),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: PageView.builder(
        controller: _mobileController,
        itemCount: _mobilePageCount,
        onPageChanged: (value) => setState(() => _mobileIndex = value),
        itemBuilder: (context, index) => _mobilePageFor(index),
      ),
    );
  }

  ({Widget left, Widget right}) _wideSpreadFor(int index) {
    if (index == 1) {
      return (
        left: ContentsPage(storySections: kStorySections),
        right: const ContentsCompanionPage(
          imageUrls: kContentsCompanionImageUrls,
        ),
      );
    }

    final storyStart = 2;
    final storyEnd = storyStart + kStorySections.length - 1;
    if (index >= storyStart && index <= storyEnd) {
      final story = kStorySections[index - storyStart];
      final imageOnLeft = (index - storyStart).isEven;
      return (
        left: imageOnLeft
            ? StoryImagePage(title: story.title, imageUrls: story.imageUrls)
            : StoryNotePage(
                heading: story.title,
                body: story.note,
                loveNotePlaceholder: story.loveNotePlaceholder,
              ),
        right: imageOnLeft
            ? StoryNotePage(
                heading: story.title,
                body: story.note,
                loveNotePlaceholder: story.loveNotePlaceholder,
              )
            : StoryImagePage(title: story.title, imageUrls: story.imageUrls),
      );
    }

    return (
      left: const SingleImagePage(
        title: 'For You, My Love',
        imageUrl: kLetterImageUrl,
        caption: 'My woman in all her beauty and grace.',
      ),
      right: const LetterPage(letterBody: kLetterBody),
    );
  }

  Widget _mobilePageFor(int index) {
    if (index == 0) {
      return const CoverPage();
    }

    final spreadIndex = 1 + ((index - 1) ~/ 2);
    final isLeftLeaf = (index - 1).isEven;
    final spread = _wideSpreadFor(spreadIndex);

    return SinglePageView(page: isLeftLeaf ? spread.left : spread.right);
  }

  void _jumpTo(JumpTarget target, bool isWide) {
    final int page;
    if (isWide) {
      page = switch (target) {
        JumpTarget.cover => 0,
        JumpTarget.contents => 1,
        JumpTarget.story => 2,
        JumpTarget.letter => _widePageCount - 1,
      };
    } else {
      page = switch (target) {
        JumpTarget.cover => 0,
        JumpTarget.contents => 1,
        JumpTarget.story => 3,
        JumpTarget.letter => _mobilePageCount - 2,
      };
    }

    final controller = isWide ? _wideController : _mobileController;
    controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _stepPage({required bool isWide, required int delta}) {
    final controller = isWide ? _wideController : _mobileController;
    final current = isWide ? _wideIndex : _mobileIndex;
    final count = isWide ? _widePageCount : _mobilePageCount;
    final target = (current + delta).clamp(0, count - 1);
    if (target == current) {
      return;
    }

    controller.animateToPage(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
