import '../models/models.dart';

/// Datos simulados para el MVP ContiGO.
class MockRepository {
  /// Login demo: Eduardo con CONTIGO + solicitudes pendientes.
  MockRepository() {
    _seed(demoUser: true);
  }

  /// Registro: cuenta nueva incompleta + catálogo de la comunidad.
  MockRepository.newAccount({
    required String name,
    required String email,
  }) {
    _seed(demoUser: false, name: name, email: email);
  }

  late Student currentUser;
  late List<ProjectIdea> projects;
  late List<TeamConnection> connections;
  final Map<String, List<ChatMessage>> chats = {};
  final Set<String> interestedProjectIds = {};

  /// Hashtags vivos de la comunidad (como TikTok / Yachaiya).
  final Set<String> communityHashtags = {};

  bool profileComplete = true;
  MeetingProposal? lastMeeting;

  List<String> get hashtagFeed {
    final counts = <String, int>{};
    for (final p in projects.where((p) => p.isPublished)) {
      for (final h in p.hashtags) {
        counts[h] = (counts[h] ?? 0) + 1;
      }
    }
    for (final h in communityHashtags) {
      counts.putIfAbsent(h, () => 0);
    }
    final list = counts.keys.toList()
      ..sort((a, b) => (counts[b] ?? 0).compareTo(counts[a] ?? 0));
    return list;
  }

  List<String> get categories => hashtagFeed;

  int get pendingForCreator => myProjects().fold<int>(
        0,
        (n, p) => n + p.pendingRequests.length,
      );

  static bool isProfileReady(Student s) =>
      s.name.trim().isNotEmpty &&
      s.career.trim().isNotEmpty &&
      s.whatMovesYou.trim().isNotEmpty;

  void _seed({
    required bool demoUser,
    String name = '',
    String email = '',
  }) {
    const eduardo = Student(
      id: 'eduardo',
      name: 'Eduardo Ñaupa',
      career: 'Ingeniería de Sistemas',
      email: '60859960@continental.edu.pe',
      description: 'Estudiante apasionado por construir productos con sentido.',
      passions: 'Ideas, equipos multidisciplinarios y aprender haciendo.',
      whatMovesYou:
          'Soy una persona apasionada por los proyectos. Me enamoro muy fácilmente de las ideas y cuando algo realmente me interesa puedo pasar mucho tiempo pensando cómo hacerlo realidad. Lo que más me motiva no es solamente terminar un proyecto, sino encontrar personas que también puedan emocionarse con la idea y quieran construirla conmigo.',
      skills: ['Flutter', 'Laravel', 'Bases de datos'],
      interests: ['#ia', '#emprendimiento', '#educacion'],
      wantsToLearn: ['Diseño', 'UX research', 'Emprendimiento'],
      availability: 'Fines de semana y noches entre semana',
      modality: Modality.hibrida,
      province: CampusProvince.huancayo,
      photoUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    );

    const ana = Student(
      id: 'ana',
      name: 'Ana Quispe',
      career: 'Educación Especial',
      email: 'ana.quispe@continental.edu.pe',
      description: 'Diseño experiencias de aprendizaje inclusivas.',
      passions: 'Inclusión, juegos y pedagogía.',
      whatMovesYou:
          'Creo que el acceso al aprendizaje no debería depender de si alguien puede ver o no. Me mueve la inclusión real: no caridad, sino herramientas dignas y divertidas.',
      skills: ['Pedagogía', 'Diseño de actividades'],
      interests: ['#inclusion', '#juegos', '#educacion'],
      wantsToLearn: ['Desarrollo móvil', 'Animación'],
      availability: 'Tardes entre semana',
      modality: Modality.hibrida,
      province: CampusProvince.huancayo,
      photoUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    );

    const luis = Student(
      id: 'luis',
      name: 'Luis Mendoza',
      career: 'Diseño Gráfico',
      email: 'luis.mendoza@continental.edu.pe',
      description: 'Le doy forma visual a ideas que aún no existen.',
      passions: 'Identidad, storytelling y producto.',
      whatMovesYou:
          'Me emociona cuando una idea empieza fea y termina siendo algo que la gente quiere usar.',
      skills: ['UI', 'Branding', 'Figma'],
      interests: ['#diseno', '#narrativa'],
      wantsToLearn: ['Frontend', 'Investigación'],
      availability: 'Mañanas flexibles',
      modality: Modality.virtual,
      province: CampusProvince.cusco,
      photoUrl: 'https://randomuser.me/api/portraits/men/75.jpg',
    );

    const diego = Student(
      id: 'diego',
      name: 'Diego Ríos',
      career: 'Ingeniería Ambiental',
      email: 'diego.rios@continental.edu.pe',
      description: 'Tecnología al servicio del territorio.',
      passions: 'Impacto local y datos abiertos.',
      whatMovesYou:
          'Quiero que la tecnología sirva al territorio, no al revés. Me conecto con ideas de impacto local medible.',
      skills: ['SIG', 'Análisis ambiental'],
      interests: ['#clima', '#ciudad', '#comunidad'],
      wantsToLearn: ['Apps móviles', 'Comunicación'],
      availability: 'Noches',
      modality: Modality.presencial,
      province: CampusProvince.arequipa,
      photoUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
    );

    const maria = Student(
      id: 'maria',
      name: 'María Torres',
      career: 'Psicología',
      email: 'maria.torres@continental.edu.pe',
      description:
          'Facilito que las personas se organicen alrededor de lo que importa.',
      passions: 'Bienestar, equipos y hábitos.',
      whatMovesYou:
          'La motivación compartida me parece más poderosa que cualquier skill aislada.',
      skills: ['Facilitación', 'Escucha activa'],
      interests: ['#bienestar', '#equipos', '#habitos'],
      wantsToLearn: ['Producto digital'],
      availability: 'Fines de semana',
      modality: Modality.virtual,
      province: CampusProvince.lima,
      photoUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
    );

    if (demoUser) {
      currentUser = eduardo;
      profileComplete = true;
    } else {
      currentUser = Student(
        id: 'u-${DateTime.now().millisecondsSinceEpoch}',
        name: name.trim().isEmpty ? 'Nuevo estudiante' : name.trim(),
        career: '',
        email: email.trim(),
        description: '',
        passions: '',
        whatMovesYou: '',
        skills: const [],
        interests: const [],
        wantsToLearn: const [],
        availability: '',
        modality: Modality.hibrida,
        province: CampusProvince.huancayo,
      );
      profileComplete = false;
    }

    final me = currentUser;

    projects = [
      ProjectIdea(
        id: 'brailit',
        author: ana,
        codeName: 'BRAILIT',
        title: 'Una nueva forma de aprender Braille mediante tecnología',
        about:
            'Una herramienta lúdica para enseñar Braille con juegos, feedback táctil y progresión motivadora.',
        why:
            'He visto cómo niños pierden motivación cuando el aprendizaje se siente como obligación. Quiero que aprender Braille sea tan adictivo como un juego bien hecho.',
        motivation:
            'No busco a alguien que “sepa Braille”: busco a alguien que se enamore del problema.',
        lookingForPeople:
            'Busco personas curiosas, comprometidas y que no tengan miedo de aprender algo nuevo.',
        hashtags: const ['#educacion', '#social', '#inclusion', '#tecnologia'],
        knowledgeAreas: ['Educación', 'Electrónica', 'Diseño'],
        modality: Modality.hibrida,
        province: CampusProvince.huancayo,
        coverUrl:
            'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800&q=80',
        targetMembers: 4,
        members: [ana, luis],
        pendingRequests: demoUser
            ? [
                InterestRequest(
                  id: 'req-edu-brailit',
                  from: me,
                  note:
                      'Me encanta el problema. No sé Braille, pero quiero aprender y ayudar.',
                  at: DateTime.now().subtract(const Duration(hours: 6)),
                ),
              ]
            : [],
      ),
      if (demoUser)
        ProjectIdea(
          id: 'contigo-meta',
          author: me,
          codeName: 'CONTIGO',
          title: 'Plataforma para conectar estudiantes alrededor de ideas',
          about:
              'Un espacio donde una idea encuentra a las personas que quieren hacerla realidad.',
          why:
              'Encontrar personas que realmente conecten con la idea suele ser más difícil que desarrollar la solución.',
          motivation:
              'Quiero que conectar con una idea sea el primer paso, no el checklist de skills.',
          lookingForPeople:
              'Personas de cualquier carrera que se identifiquen con el problema.',
          hashtags: const ['#emprendimiento', '#tecnologia', '#comunidad'],
          knowledgeAreas: ['Producto', 'UX', 'Backend'],
          modality: Modality.hibrida,
          province: CampusProvince.huancayo,
          coverUrl:
              'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800&q=80',
          targetMembers: 5,
          members: [me],
          pendingRequests: [
            InterestRequest(
              id: 'req-maria-contigo',
              from: maria,
              note:
                  'Me identifico con la motivación. Quiero aportar en dinámicas de equipo.',
              at: DateTime.now().subtract(const Duration(hours: 2)),
            ),
            InterestRequest(
              id: 'req-diego-contigo',
              from: diego,
              note: 'Creo que puedo aportar desde impacto local y datos.',
              at: DateTime.now().subtract(const Duration(hours: 1)),
            ),
          ],
        ),
      ProjectIdea(
        id: 'huertos',
        author: diego,
        codeName: 'HUERTA+',
        title: 'Mapa colaborativo de huertos urbanos del barrio',
        about:
            'Conecta a quienes quieren compostar con quienes tienen espacio.',
        why: 'Hay gente con ganas y gente con espacio, pero no se encuentran.',
        motivation: 'Prefiero compromiso a expertise.',
        lookingForPeople:
            'Alguien con ganas de salir a conversar con la comunidad.',
        hashtags: const ['#ambiente', '#social', '#ciudad'],
        knowledgeAreas: ['Mapas', 'Móvil', 'Comunicación'],
        modality: Modality.presencial,
        province: CampusProvince.arequipa,
        coverUrl:
            'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=800&q=80',
        targetMembers: 3,
        members: demoUser ? [diego, me] : [diego],
      ),
      ProjectIdea(
        id: 'habit',
        author: maria,
        codeName: 'PARES',
        title: 'Acompañamiento entre pares para hábitos de estudio sin culpa',
        about: 'Parejas de accountability elegidas por afinidad.',
        why: 'Muchas apps de hábitos parecen castigar.',
        motivation: 'Algo más humano para sostenerse juntos.',
        lookingForPeople: 'Personas empáticas que quieran prototipar dinámicas.',
        hashtags: const ['#educacion', '#bienestar', '#social'],
        knowledgeAreas: ['Facilitación', 'UI simple'],
        modality: Modality.virtual,
        province: CampusProvince.lima,
        coverUrl:
            'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800&q=80',
        targetMembers: 4,
        members: [maria],
      ),
      ProjectIdea(
        id: 'portfolio',
        author: luis,
        codeName: 'PORQUÉ',
        title: 'Portafolio vivo donde el “por qué” pesa más que las pantallas',
        about: 'Un formato que cuenta motivación y proceso.',
        why: 'Estoy cansado de portfolios que solo muestran habilidades.',
        motivation: 'La identidad de un creador es su historia.',
        lookingForPeople: 'Alguien que quiera experimentar formatos narrativos.',
        hashtags: const ['#diseno', '#emprendimiento', '#narrativa'],
        knowledgeAreas: ['Copy', 'Web', 'Motion'],
        modality: Modality.virtual,
        province: CampusProvince.cusco,
        coverUrl:
            'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800&q=80',
        targetMembers: 3,
        members: [luis],
      ),
    ];

    for (final p in projects) {
      communityHashtags.addAll(p.hashtags);
    }

    if (demoUser) {
      // c1 = equipo Ana+Luis (Eduardo NO es miembro; solo tiene solicitud pendiente en BRAILIT).
      // c2 = match real Eduardo+Diego en HUERTA+.
      connections = [
        TeamConnection(
          id: 'c1',
          project: projects.firstWhere((p) => p.id == 'brailit'),
          members: [ana, luis],
          bucket: ConnectionBucket.enConversacion,
          lastMessage: '¿Te parece si conversamos mañana?',
        ),
        TeamConnection(
          id: 'c2',
          project: projects.firstWhere((p) => p.id == 'huertos'),
          members: [me, diego],
          bucket: ConnectionBucket.nuevas,
          lastMessage: 'Match registrado · ambos conectaron con HUERTA+.',
        ),
      ];
      interestedProjectIds.addAll(['brailit', 'huertos']);
      chats['c1'] = [
        ChatMessage(
          fromId: 'ana',
          text: 'Hola Luis, gracias por unirte a BRAILIT.',
          at: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        ChatMessage(
          fromId: 'luis',
          text: 'Puedo ayudar con la identidad visual del juego.',
          at: DateTime.now().subtract(const Duration(hours: 4)),
        ),
        ChatMessage(
          fromId: 'ana',
          text: '¿Te parece si conversamos mañana?',
          at: DateTime.now().subtract(const Duration(hours: 3)),
        ),
      ];
      chats['c2'] = [
        ChatMessage(
          fromId: 'diego',
          text: 'Bienvenido. ¿Qué te movió de la idea de huertos?',
          at: DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ];
    } else {
      connections = [];
    }
  }

  List<ProjectIdea> myProjects() =>
      projects.where((p) => p.author.id == currentUser.id).toList();

  /// Solo conexiones donde el usuario actual es miembro.
  List<TeamConnection> myConnections({ConnectionBucket? bucket}) {
    return connections.where((c) {
      final mine = c.members.any((m) => m.id == currentUser.id);
      if (!mine) return false;
      if (bucket == null) return true;
      return c.bucket == bucket;
    }).toList();
  }

  List<ProjectIdea> explore({
    String query = '',
    String? hashtag,
    CampusProvince? province,
    Modality? modality,
  }) {
    final q = query.trim().toLowerCase();
    final tag = hashtag == null ? null : normalizeHashtag(hashtag);
    return projects.where((p) {
      if (!p.isPublished && p.author.id != currentUser.id) return false;
      final matchTag = tag == null || p.hashtags.any((h) => h == tag);
      final matchProvince = province == null || p.province == province;
      final matchModality = modality == null || p.modality == modality;
      final matchQ = q.isEmpty ||
          p.codeName.toLowerCase().contains(q) ||
          p.title.toLowerCase().contains(q) ||
          p.about.toLowerCase().contains(q) ||
          p.province.label.toLowerCase().contains(q) ||
          p.hashtags.any((h) => h.contains(q.replaceAll('#', '')));
      return matchTag && matchProvince && matchModality && matchQ;
    }).toList();
  }

  void expressInterest(String projectId, String note) {
    final project = projects.firstWhere((i) => i.id == projectId);
    if (!project.isPublished) return;
    if (project.author.id == currentUser.id) return;
    if (project.isMember(currentUser.id)) return;
    if (project.pendingRequests.any((r) => r.from.id == currentUser.id)) {
      return;
    }
    interestedProjectIds.add(projectId);
    project.pendingRequests.insert(
      0,
      InterestRequest(
        id: 'req-${DateTime.now().millisecondsSinceEpoch}',
        from: currentUser,
        note: note,
        at: DateTime.now(),
      ),
    );
  }

  /// El creador registra el match y vincula a la persona al proyecto.
  TeamConnection? acceptMatch(String projectId, String requestId) {
    final project = projects.firstWhere((p) => p.id == projectId);
    if (project.author.id != currentUser.id) return null;
    final idx = project.pendingRequests.indexWhere((r) => r.id == requestId);
    if (idx < 0) return null;
    final req = project.pendingRequests.removeAt(idx);
    if (!project.isMember(req.from.id)) {
      project.members.add(req.from);
    }
    interestedProjectIds.add(projectId);

    final existingIdx = connections.indexWhere(
      (c) =>
          c.project.id == projectId &&
          c.members.any((m) => m.id == req.from.id),
    );

    final bucket = project.hasEnoughMembers
        ? ConnectionBucket.equipos
        : ConnectionBucket.nuevas;
    final last =
        'Match registrado · ${req.from.name.split(' ').first} se unió al equipo';

    late final TeamConnection connection;
    if (existingIdx >= 0) {
      final prev = connections[existingIdx];
      connection = TeamConnection(
        id: prev.id,
        project: project,
        members: [
          ...{for (final m in [...prev.members, req.from]) m.id: m}.values,
        ],
        bucket: bucket,
        lastMessage: last,
      );
      connections[existingIdx] = connection;
    } else {
      connection = TeamConnection(
        id: 'c-${DateTime.now().millisecondsSinceEpoch}',
        project: project,
        members: [project.author, req.from],
        bucket: bucket,
        lastMessage: last,
      );
      connections.insert(0, connection);
    }

    chats.putIfAbsent(connection.id, () => []);
    chats[connection.id]!.add(
      ChatMessage(
        fromId: currentUser.id,
        text: last,
        at: DateTime.now(),
      ),
    );

    if (project.hasEnoughMembers && project.isPublished) {
      project.isPublished = false;
    }

    // Si el proyecto ya es equipo, promove conexiones del mismo proyecto.
    if (project.hasEnoughMembers) {
      for (var i = 0; i < connections.length; i++) {
        final c = connections[i];
        if (c.project.id == projectId) {
          connections[i] = TeamConnection(
            id: c.id,
            project: project,
            members: c.members,
            bucket: ConnectionBucket.equipos,
            lastMessage: c.lastMessage,
          );
        }
      }
    }

    return connection;
  }

  void rejectInterest(String projectId, String requestId) {
    final project = projects.firstWhere((p) => p.id == projectId);
    if (project.author.id != currentUser.id) return;
    project.pendingRequests.removeWhere((r) => r.id == requestId);
  }

  void removeMember(String projectId, String studentId) {
    final project = projects.firstWhere((p) => p.id == projectId);
    if (project.author.id != currentUser.id) return;
    if (studentId == project.author.id) return;
    project.members.removeWhere((m) => m.id == studentId);

    // Si baja del cupo, vuelve a publicar para buscar más gente.
    if (!project.hasEnoughMembers && !project.isPublished) {
      project.isPublished = true;
    }

    for (var i = connections.length - 1; i >= 0; i--) {
      final c = connections[i];
      if (c.project.id != projectId) continue;
      if (!c.members.any((m) => m.id == studentId)) continue;
      final members = c.members.where((m) => m.id != studentId).toList();
      if (members.length < 2) {
        chats.remove(c.id);
        connections.removeAt(i);
      } else {
        connections[i] = TeamConnection(
          id: c.id,
          project: project,
          members: members,
          bucket: project.hasEnoughMembers
              ? ConnectionBucket.equipos
              : ConnectionBucket.enConversacion,
          lastMessage: 'Miembro removido del proyecto',
        );
      }
    }
  }

  void setPublished(String projectId, bool published) {
    final project = projects.firstWhere((p) => p.id == projectId);
    if (project.author.id != currentUser.id) return;
    project.isPublished = published;
  }

  void addMessage(String connectionId, String text) {
    chats.putIfAbsent(connectionId, () => []);
    chats[connectionId]!.add(
      ChatMessage(fromId: currentUser.id, text: text, at: DateTime.now()),
    );
    final idx = connections.indexWhere((c) => c.id == connectionId);
    if (idx >= 0) {
      final c = connections[idx];
      final project =
          projects.firstWhere((p) => p.id == c.project.id, orElse: () => c.project);
      connections[idx] = TeamConnection(
        id: c.id,
        project: project,
        members: c.members,
        bucket: project.hasEnoughMembers
            ? ConnectionBucket.equipos
            : ConnectionBucket.enConversacion,
        lastMessage: text,
      );
    }
  }

  void publishProject(ProjectIdea project) {
    communityHashtags.addAll(project.hashtags);
    projects.insert(0, project);
  }

  void updateProfile(Student student) {
    final id = student.id;
    currentUser = student;
    profileComplete = isProfileReady(student);

    for (final p in projects) {
      if (p.author.id == id) p.author = student;
      for (var i = 0; i < p.members.length; i++) {
        if (p.members[i].id == id) p.members[i] = student;
      }
      for (final req in p.pendingRequests) {
        if (req.from.id == id) req.from = student;
      }
    }

    for (var i = 0; i < connections.length; i++) {
      final c = connections[i];
      connections[i] = TeamConnection(
        id: c.id,
        project: c.project,
        members: [
          for (final m in c.members) m.id == id ? student : m,
        ],
        bucket: c.bucket,
        lastMessage: c.lastMessage,
      );
    }
  }

  void proposeMeeting(MeetingProposal proposal) {
    lastMeeting = proposal;
    final idx = connections.indexWhere((c) => c.id == proposal.connectionId);
    if (idx < 0) return;
    final c = connections[idx];
    final project = projects.firstWhere(
      (p) => p.id == c.project.id,
      orElse: () => c.project,
    );
    final header =
        'Reunión propuesta · ${proposal.modality.label} · ${proposal.dateLabel} ${proposal.timeLabel} · ${proposal.placeOrLink}';
    final msg = proposal.message.trim();
    chats.putIfAbsent(c.id, () => []);
    chats[c.id]!.add(
      ChatMessage(fromId: currentUser.id, text: header, at: DateTime.now()),
    );
    if (msg.isNotEmpty) {
      chats[c.id]!.add(
        ChatMessage(fromId: currentUser.id, text: msg, at: DateTime.now()),
      );
    }
    final keepEquipos = project.hasEnoughMembers ||
        c.bucket == ConnectionBucket.equipos;
    connections[idx] = TeamConnection(
      id: c.id,
      project: project,
      members: c.members,
      bucket: keepEquipos
          ? ConnectionBucket.equipos
          : ConnectionBucket.enConversacion,
      lastMessage: msg.isNotEmpty ? msg : header,
    );
  }
}
