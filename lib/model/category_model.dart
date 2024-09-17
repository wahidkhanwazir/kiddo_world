class CategoryModel {
  final String char;
  final String? isFor;
  final String question;
  final String correctOption;
  final List<String> voice;
  final List<String> choices;

  const CategoryModel(
      {
      required this.correctOption,
      required this.char,
       this.isFor,
      required this.question,
      required this.voice,
      required this.choices});
}
