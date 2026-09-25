class Student {
  const Student({
    required this.id,
    required this.name,
    required this.career,
    required this.year,
    required this.whatMovesYou,
    required this.interests,
    required this.canTeach,
    required this.wantsToLearn,
    required this.workStyle,
    required this.availability,
    this.avatarInitials,
  });

  final String id;
  final String name;
  final String career;
  final int year;
  final String whatMovesYou;
  final List<String> interests;
  final List<String> canTeach;
  final List<String> wantsToLearn;
  final String workStyle;
  final String availability;
  final String? avatarInitials;

  String get initials =>
      avatarInitials ??
      name
          .split(' ')
          .where((p) => p.isNotEmpty)
          .take(2)
          .map((p) => p[0].toUpperCase())
          .join();
}

class ProjectIdea {
  const ProjectIdea({
    required this.id,
    required this.author,
    required this.title,
    required this.why,
    required this.lookingFor,
    required this.themeTags,
    required this.motivationTags,
    this.skillsNiceToHave = const [],
    this.canTeach = const [],
    this.wantsToLearn = const [],
  });

  final String id;
  final Student author;
  final String title;
  final String why;
  final String lookingFor;
  final List<String> themeTags;
  final List<String> motivationTags;
  final List<String> skillsNiceToHave;
  final List<String> canTeach;
  final List<String> wantsToLearn;
}

enum ConnectionReason {
  problem('Me interesa el problema'),
  topic('Me apasiona el tema'),
  relatedIdea('Tengo una idea relacionada'),
  learn('Quiero aprender'),
  contribute('Creo que puedo aportar'),
  motivation('Me identifico con la motivación'),
  team('Quiero conocer al equipo');

  const ConnectionReason(this.label);
  final String label;
}

class AffinityMatch {
  const AffinityMatch({
    required this.id,
    required this.idea,
    required this.other,
    required this.reasons,
    required this.status,
    this.note,
  });

  final String id;
  final ProjectIdea idea;
  final Student other;
  final List<ConnectionReason> reasons;
  final MatchStatus status;
  final String? note;
}

enum MatchStatus {
  pending('Esperando respuesta'),
  mutual('Match — listos para conversar'),
  chatting('En conversación'),
  meeting('Reunión agendada');

  const MatchStatus(this.label);
  final String label;
}
