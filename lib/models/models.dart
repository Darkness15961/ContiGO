enum Modality { presencial, virtual, hibrida }

extension ModalityX on Modality {
  String get label => switch (this) {
        Modality.presencial => 'Presencial',
        Modality.virtual => 'Virtual',
        Modality.hibrida => 'Híbrida',
      };
}

class Student {
  const Student({
    required this.id,
    required this.name,
    required this.career,
    required this.email,
    required this.whatMovesYou,
    required this.description,
    required this.passions,
    required this.skills,
    required this.interests,
    required this.wantsToLearn,
    required this.availability,
    required this.modality,
    this.photoUrl,
    this.localPhotoPath,
  });

  final String id;
  final String name;
  final String career;
  final String email;
  final String whatMovesYou;
  final String description;
  final String passions;
  final List<String> skills;
  final List<String> interests;
  final List<String> wantsToLearn;
  final String availability;
  final Modality modality;

  /// Foto remota (simulación / mock).
  final String? photoUrl;

  /// Foto local elegida desde galería o cámara.
  final String? localPhotoPath;

  bool get hasPhoto =>
      (localPhotoPath != null && localPhotoPath!.isNotEmpty) ||
      (photoUrl != null && photoUrl!.isNotEmpty);

  String get initials => name
      .split(' ')
      .where((p) => p.isNotEmpty)
      .take(2)
      .map((p) => p[0].toUpperCase())
      .join();

  Student copyWith({
    String? name,
    String? career,
    String? email,
    String? whatMovesYou,
    String? description,
    String? passions,
    List<String>? skills,
    List<String>? interests,
    List<String>? wantsToLearn,
    String? availability,
    Modality? modality,
    String? photoUrl,
    String? localPhotoPath,
    bool clearLocalPhoto = false,
  }) {
    return Student(
      id: id,
      name: name ?? this.name,
      career: career ?? this.career,
      email: email ?? this.email,
      whatMovesYou: whatMovesYou ?? this.whatMovesYou,
      description: description ?? this.description,
      passions: passions ?? this.passions,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      wantsToLearn: wantsToLearn ?? this.wantsToLearn,
      availability: availability ?? this.availability,
      modality: modality ?? this.modality,
      photoUrl: photoUrl ?? this.photoUrl,
      localPhotoPath:
          clearLocalPhoto ? null : (localPhotoPath ?? this.localPhotoPath),
    );
  }
}

class ProjectIdea {
  const ProjectIdea({
    required this.id,
    required this.author,
    required this.codeName,
    required this.title,
    required this.about,
    required this.why,
    required this.motivation,
    required this.lookingForPeople,
    required this.categories,
    required this.knowledgeAreas,
    required this.modality,
    this.coverUrl,
    this.localCoverPath,
  });

  final String id;
  final Student author;
  final String codeName;
  final String title;
  final String about;
  final String why;
  final String motivation;
  final String lookingForPeople;
  final List<String> categories;
  final List<String> knowledgeAreas;
  final Modality modality;
  final String? coverUrl;
  final String? localCoverPath;

  bool get hasCover =>
      (localCoverPath != null && localCoverPath!.isNotEmpty) ||
      (coverUrl != null && coverUrl!.isNotEmpty);
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

enum ConnectionBucket { nuevas, enConversacion, equipos }

extension ConnectionBucketX on ConnectionBucket {
  String get label => switch (this) {
        ConnectionBucket.nuevas => 'Nuevas',
        ConnectionBucket.enConversacion => 'En conversación',
        ConnectionBucket.equipos => 'Equipos',
      };
}

class TeamConnection {
  const TeamConnection({
    required this.id,
    required this.project,
    required this.members,
    required this.bucket,
    this.lastMessage,
  });

  final String id;
  final ProjectIdea project;
  final List<Student> members;
  final ConnectionBucket bucket;
  final String? lastMessage;
}

class ChatMessage {
  const ChatMessage({
    required this.fromId,
    required this.text,
    required this.at,
  });

  final String fromId;
  final String text;
  final DateTime at;
}

class MeetingProposal {
  const MeetingProposal({
    required this.modality,
    required this.dateLabel,
    required this.timeLabel,
    required this.placeOrLink,
    required this.message,
  });

  final Modality modality;
  final String dateLabel;
  final String timeLabel;
  final String placeOrLink;
  final String message;
}
