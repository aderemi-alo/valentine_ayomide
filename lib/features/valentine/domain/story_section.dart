class StorySection {
  const StorySection({
    required this.title,
    required this.note,
    required this.imageUrls,
    required this.loveNotePlaceholder,
  });

  final String title;
  final String note;
  final List<String> imageUrls;
  final String loveNotePlaceholder;
}
