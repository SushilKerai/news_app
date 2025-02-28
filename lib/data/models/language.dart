import 'dart:convert';

Language languageFromJson(String str) => Language.fromJson(json.decode(str));

String languageToJson(Language data) => json.encode(data.toJson());

class Language {
  Languages languages;
  String description;
  String status;

  Language({
    required this.languages,
    required this.description,
    required this.status,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        languages: Languages.fromJson(json["languages"]),
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "languages": languages.toJson(),
        "description": description,
        "status": status,
      };
}

class Languages {
  String arabic;
  String chinese;
  String dutch;
  String english;
  String finnish;
  String french;
  String german;
  String hindi;
  String italian;
  String japanese;
  String korean;
  String malay;
  String portuguese;
  String russian;
  String spanish;
  String vietnamise;
  String danish;
  String czech;
  String greek;
  String hungarian;
  String serbian;
  String thai;
  String turkish;

  Languages({
    required this.arabic,
    required this.chinese,
    required this.dutch,
    required this.english,
    required this.finnish,
    required this.french,
    required this.german,
    required this.hindi,
    required this.italian,
    required this.japanese,
    required this.korean,
    required this.malay,
    required this.portuguese,
    required this.russian,
    required this.spanish,
    required this.vietnamise,
    required this.danish,
    required this.czech,
    required this.greek,
    required this.hungarian,
    required this.serbian,
    required this.thai,
    required this.turkish,
  });

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        arabic: json["Arabic"],
        chinese: json["Chinese"],
        dutch: json["Dutch"],
        english: json["English"],
        finnish: json["Finnish"],
        french: json["French"],
        german: json["German"],
        hindi: json["Hindi"],
        italian: json["Italian"],
        japanese: json["Japanese"],
        korean: json["Korean"],
        malay: json["Malay"],
        portuguese: json["Portuguese"],
        russian: json["Russian"],
        spanish: json["Spanish"],
        vietnamise: json["Vietnamise"],
        danish: json["Danish"],
        czech: json["Czech"],
        greek: json["Greek"],
        hungarian: json["Hungarian"],
        serbian: json["Serbian"],
        thai: json["Thai"],
        turkish: json["Turkish"],
      );

  Map<String, dynamic> toJson() => {
        "Arabic": arabic,
        "Chinese": chinese,
        "Dutch": dutch,
        "English": english,
        "Finnish": finnish,
        "French": french,
        "German": german,
        "Hindi": hindi,
        "Italian": italian,
        "Japanese": japanese,
        "Korean": korean,
        "Malay": malay,
        "Portuguese": portuguese,
        "Russian": russian,
        "Spanish": spanish,
        "Vietnamise": vietnamise,
        "Danish": danish,
        "Czech": czech,
        "Greek": greek,
        "Hungarian": hungarian,
        "Serbian": serbian,
        "Thai": thai,
        "Turkish": turkish,
      };
}
