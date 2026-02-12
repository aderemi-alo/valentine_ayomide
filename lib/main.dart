import 'package:flutter/material.dart';

void main() {
  runApp(const ValentinePlaybookApp());
}

enum JumpTarget { cover, contents, story, letter }

class StorySection {
  const StorySection({
    required this.title,
    required this.note,
    required this.imageUrl,
  });

  final String title;
  final String note;
  final String imageUrl;
}

class ValentinePlaybookApp extends StatelessWidget {
  const ValentinePlaybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Valentine Playbook',
      theme: ThemeData(
        fontFamily: 'Georgia',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCC4B5C),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ValentineBookScreen(),
    );
  }
}

class ValentineBookScreen extends StatefulWidget {
  const ValentineBookScreen({super.key});

  @override
  State<ValentineBookScreen> createState() => _ValentineBookScreenState();
}

class _ValentineBookScreenState extends State<ValentineBookScreen> {
  final List<StorySection> _storySections = const [
    StorySection(
      title: 'The First Spark',
      imageUrl: 'https://picsum.photos/seed/firstspark/1000/1400',
      note:
          'Placeholder note: this is where the story of your first meeting goes. '
          'Write about the moment you noticed her smile, how the room felt, and '
          'what made this memory unforgettable.',
    ),
    StorySection(
      title: 'The Day We Knew',
      imageUrl: 'https://picsum.photos/seed/dayweknew/1000/1400',
      note:
          'Placeholder note: describe the day it became clear this was special. '
          'Talk about one tiny detail only the two of you remember, and how it '
          'changed everything after that.',
    ),
    StorySection(
      title: 'Our Favorite Adventures',
      imageUrl: 'https://picsum.photos/seed/adventures/1000/1400',
      note:
          'Placeholder note: use this space for your favorite trips, late-night '
          'drives, inside jokes, and the little traditions that became yours. '
          'Keep it personal and playful.',
    ),
    StorySection(
      title: 'Still Choosing You',
      imageUrl: 'https://picsum.photos/seed/stillchoosing/1000/1400',
      note:
          'Placeholder note: write about why you love her today. Mention how '
          'she makes ordinary days better, and what future chapter you are most '
          'excited to write together.',
    ),
  ];

  late final PageController _mobileController;
  late final PageController _wideController;

  int _mobileIndex = 0;
  int _wideIndex = 0;

  static const String _letterImageUrl =
      'https://picsum.photos/seed/valentineletter/1000/1400';

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

  int get _widePageCount => 2 + _storySections.length + 1;

  int get _mobilePageCount => 1 + (_widePageCount - 1) * 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8EF), Color(0xFFFFF1E6), Color(0xFFFDE6E8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 980;
              final currentIndex = isWide ? _wideIndex : _mobileIndex;
              final pageCount = isWide ? _widePageCount : _mobilePageCount;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: _TopBar(onJump: (target) => _jumpTo(target, isWide)),
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
                    child: _BottomControls(
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
            return _buildCoverPage();
          }

          final spread = _wideSpreadFor(index);
          return _SpreadView(left: spread.left, right: spread.right);
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
      return (left: _buildContentsPage(), right: _buildContentsCompanionPage());
    }

    final storyStart = 2;
    final storyEnd = storyStart + _storySections.length - 1;
    if (index >= storyStart && index <= storyEnd) {
      final story = _storySections[index - storyStart];
      final imageOnLeft = (index - storyStart).isEven;
      return (
        left: imageOnLeft
            ? _buildImagePage(
                title: story.title,
                imageUrl: story.imageUrl,
                caption: 'Photo placeholder for ${story.title}',
              )
            : _buildNotePage(heading: story.title, body: story.note),
        right: imageOnLeft
            ? _buildNotePage(heading: story.title, body: story.note)
            : _buildImagePage(
                title: story.title,
                imageUrl: story.imageUrl,
                caption: 'Photo placeholder for ${story.title}',
              ),
      );
    }

    return (
      left: _buildImagePage(
        title: 'For You, My Love',
        imageUrl: _letterImageUrl,
        caption: 'Replace with your favorite picture together',
      ),
      right: _buildLetterPage(),
    );
  }

  Widget _mobilePageFor(int index) {
    if (index == 0) {
      return _buildCoverPage();
    }

    final spreadIndex = 1 + ((index - 1) ~/ 2);
    final isLeftLeaf = (index - 1).isEven;
    final spread = _wideSpreadFor(spreadIndex);

    return _SinglePageView(page: isLeftLeaf ? spread.left : spread.right);
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

  Widget _buildCoverPage() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Container(
          decoration: _paperDecoration,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFD7CF).withValues(alpha: 0.9),
                        const Color(0xFFFAD7EA).withValues(alpha: 0.85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -70,
                top: -40,
                child: _floatingShape(
                  size: 180,
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.35),
                ),
              ),
              Positioned(
                left: -60,
                bottom: -45,
                child: _floatingShape(
                  size: 190,
                  color: const Color(0xFFFF8EA7).withValues(alpha: 0.23),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Valentine Edition',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 3.2,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF703840),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Our Love\nStory',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            height: 1.05,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4E1F2A),
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'A playbook of our favorite chapters, small moments, and '
                      'the letter I wrote just for you.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.55,
                        color: const Color(0xFF643B42),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF5F6),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: const Color(0xFFDEA3AF)),
                      ),
                      child: Text(
                        'Swipe or use Next to begin',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF83444F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentsPage() {
    return _BookPage(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contents',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color(0xFF4D2330),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Use the jump buttons above any time.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF7B4A55)),
            ),
            const SizedBox(height: 22),
            ..._storySections.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      child: Text(
                        '${entry.key + 1}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: const Color(0xFFB65063),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        entry.value.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: const Color(0xFF5B2B35)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Finale: A Valentine Letter',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontStyle: FontStyle.italic,
                color: const Color(0xFFB7445E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentsCompanionPage() {
    return _BookPage(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How To Personalize',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF4D2330),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Replace each placeholder image URL with your own photos. '
              'All images use BoxFit.cover, so they always scale to fill each page '
              'while preserving aspect ratio.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: const Color(0xFF68404A),
              ),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://picsum.photos/seed/contentsboard/1000/1400',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      _imageFallback('Memory board placeholder'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePage({
    required String title,
    required String imageUrl,
    required String caption,
  }) {
    return _BookPage(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF502732),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      _imageFallback('Image placeholder'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              caption,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: const Color(0xFF865A64)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotePage({required String heading, required String body}) {
    return _BookPage(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF4A2130),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  body,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.8,
                    color: const Color(0xFF623B45),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Love note space',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 1.2,
                color: const Color(0xFFB14761),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLetterPage() {
    return _BookPage(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Valentine Letter',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF4A2130),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'My Love,\n\n'
                  'This is placeholder text for your real letter. Replace this '
                  'section with your own words about what she means to you, how '
                  'she changes your life for the better, and all the ways you want '
                  'to keep choosing her every day.\n\n'
                  'Thank you for the laughter, for the calm in the chaos, and for '
                  'being home to my heart.\n\n'
                  'Forever yours,\n'
                  '[Your Name]',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.85,
                    color: const Color(0xFF623B45),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _floatingShape({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _imageFallback(String label) {
    return Container(
      color: const Color(0xFFFFEFF2),
      child: Center(
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: const Color(0xFF9B6B76)),
        ),
      ),
    );
  }

  BoxDecoration get _paperDecoration => BoxDecoration(
    color: const Color(0xFFFFFCFA),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: const Color(0xFFE7CED2), width: 1.2),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF8C5A63).withValues(alpha: 0.14),
        blurRadius: 26,
        offset: const Offset(0, 14),
      ),
    ],
  );
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onJump});

  final ValueChanged<JumpTarget> onJump;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9D4D8)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        spacing: 8,
        children: [
          _jumpButton(
            context,
            label: 'Cover',
            onTap: () => onJump(JumpTarget.cover),
          ),
          _jumpButton(
            context,
            label: 'Contents',
            onTap: () => onJump(JumpTarget.contents),
          ),
          _jumpButton(
            context,
            label: 'Our Story',
            onTap: () => onJump(JumpTarget.story),
          ),
          _jumpButton(
            context,
            label: 'Letter',
            onTap: () => onJump(JumpTarget.letter),
          ),
        ],
      ),
    );
  }

  Widget _jumpButton(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return FilledButton.tonal(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        foregroundColor: const Color(0xFF5B2B35),
        backgroundColor: const Color(0xFFF8E8EB),
      ),
      child: Text(label),
    );
  }
}

class _BottomControls extends StatelessWidget {
  const _BottomControls({
    required this.index,
    required this.total,
    required this.canGoBack,
    required this.canGoForward,
    required this.onBack,
    required this.onForward,
  });

  final int index;
  final int total;
  final bool canGoBack;
  final bool canGoForward;
  final VoidCallback onBack;
  final VoidCallback onForward;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9D4D8)),
      ),
      child: Row(
        children: [
          IconButton.filledTonal(
            onPressed: canGoBack ? onBack : null,
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Previous page',
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Page ${index + 1} of $total',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: const Color(0xFF60343D)),
            ),
          ),
          const SizedBox(width: 10),
          IconButton.filled(
            onPressed: canGoForward ? onForward : null,
            icon: const Icon(Icons.arrow_forward_rounded),
            tooltip: 'Next page',
          ),
        ],
      ),
    );
  }
}

class _SpreadView extends StatelessWidget {
  const _SpreadView({required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 14),
        Expanded(child: right),
      ],
    );
  }
}

class _SinglePageView extends StatelessWidget {
  const _SinglePageView({required this.page});

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: page,
      ),
    );
  }
}

class _BookPage extends StatelessWidget {
  const _BookPage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7CED2), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8C5A63).withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}
