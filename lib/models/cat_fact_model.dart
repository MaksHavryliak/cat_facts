class CatFact {
  final String fact;
  final String date;

  CatFact({required this.fact, required this.date});

  Map<String, dynamic> toJson() => {
    'fact': fact,
    'date': date,
  };

  factory CatFact.fromJson(Map<String, dynamic> json) => CatFact(
    fact: json['fact'],
    date: json['date'],
  );
}