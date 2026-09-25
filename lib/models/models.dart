enum Modality { presencial, virtual, hibrida }

extension ModalityX on Modality {
  String get label => switch (this) {
        Modality.presencial => 'Presencial',
        Modality.virtual => 'Virtual',
        Modality.hibrida => 'Híbrida',
      };
}

/// Sedes / provincias donde opera ContiGO (Universidad Continental).
enum CampusProvince { huancayo, cusco, arequipa, lima }

extension CampusProvinceX on CampusProvince {
  String get label => switch (this) {
        CampusProvince.huancayo => 'Huancayo',
        CampusProvince.cusco => 'Cusco',
        CampusProvince.arequipa => 'Arequipa',
        CampusProvince.lima => 'Lima',
      };
}

/// Normaliza tags de comunidad: "Emprendimiento" / "#emprendimiento" → "#emprendimiento"
String normalizeHashtag(String raw) {
  var t = raw.trim().toLowerCase();
  if (t.isEmpty) return '';
  t = t.replaceAll(RegExp(r'\s+'), '');
  if (!t.startsWith('#')) t = '#$t';
  t = t.replaceAll(RegExp(r'[^#a-záéíóúüñ0-9]', caseSensitive: false), '');
  return t.length > 1 ? t : '';
}

List<String> parseHashtags(String raw) {
  final parts = raw.split(RegExp(r'[\s,·]+'));
  final out = <String>{};
  for (final p in parts) {
    final h = normalizeHashtag(p);
    if (h.isNotEmpty) out.add(h);
  }
  return out.toList();
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
    required this.province,
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
  /// Sede / provincia del estudiante.
  final CampusProvince province;
  final String? photoUrl;
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
    CampusProvince? province,
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
      province: province ?? this.province,
      photoUrl: photoUrl ?? this.photoUrl,
      localPhotoPath:
          clearLocalPhoto ? null : (localPhotoPath ?? this.localPhotoPath),
    );
  }
}

class InterestRequest {
  InterestRequest({
    required this.id,
    required this.from,
    required this.note,
    required this.at,
  });

  final String id;
  Student from;
  final String note;
  final DateTime at;
}

class ProjectIdea {
  ProjectIdea({
    required this.id,
    required this.author,
    required this.codeName,
    required this.title,
    required this.about,
    required this.why,
    required this.motivation,
    required this.lookingForPeople,
    required this.hashtags,
    required this.knowledgeAreas,
    required this.modality,
    required this.province,
    this.coverUrl,
    this.localCoverPath,
    this.isPublished = true,
    this.targetMembers = 4,
    List<Student>? members,
    List<InterestRequest>? pendingRequests,
  })  : members = members ?? [author],
        pendingRequests = pendingRequests ?? [];

  final String id;
  Student author;
  final String codeName;
  final String title;
  final String about;
  final String why;
  final String motivation;
  final String lookingForPeople;
  /// Hashtags de comunidad: #emprendimiento #social …
  final List<String> hashtags;
  final List<String> knowledgeAreas;
  final Modality modality;
  /// Provincia / sede donde se desarrolla o se busca equipo.
  final CampusProvince province;
  final String? coverUrl;
  final String? localCoverPath;
  bool isPublished;
  final int targetMembers;
  final List<Student> members;
  final List<InterestRequest> pendingRequests;

  bool get hasCover =>
      (localCoverPath != null && localCoverPath!.isNotEmpty) ||
      (coverUrl != null && coverUrl!.isNotEmpty);

  int get memberCount => members.length;

  bool get hasEnoughMembers => memberCount >= targetMembers;

  bool isMember(String studentId) => members.any((m) => m.id == studentId);

  /// Alias legacy para UI que aún diga categories.
  List<String> get categories => hashtags;
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
    required this.connectionId,
    required this.modality,
    required this.dateLabel,
    required this.timeLabel,
    required this.placeOrLink,
    required this.message,
  });

  final String connectionId;
  final Modality modality;
  final String dateLabel;
  final String timeLabel;
  final String placeOrLink;
  final String message;
}
