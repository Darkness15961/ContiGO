import '../models/models.dart';

/// Datos simulados para el MVP ContiGO.
class MockRepository {
  MockRepository() {
    _seed();
  }

  late Student currentUser;
  late List<ProjectIdea> projects;
  late List<TeamConnection> connections;
  final Map<String, List<ChatMessage>> chats = {};
  final Set<String> interestedProjectIds = {};
  final List<String> categories = const [
    'Educación',
    'Tecnología',
    'Emprendimiento',
    'Social',
    'Salud',
    'Ambiente',
  ];

  bool profileComplete = true;
  MeetingProposal? lastMeeting;

  void _seed() {
    currentUser = const Student(
      id: 'eduardo',
      name: 'Eduardo Ñaupa',
      career: 'Ingeniería de Sistemas',
      email: '60859960@continental.edu.pe',
      description: 'Estudiante apasionado por construir productos con sentido.',
      passions: 'Ideas, equipos multidisciplinarios y aprender haciendo.',
      whatMovesYou:
          'Soy una persona apasionada por los proyectos. Me enamoro muy fácilmente de las ideas y cuando algo realmente me interesa puedo pasar mucho tiempo pensando cómo hacerlo realidad. Lo que más me motiva no es solamente terminar un proyecto, sino encontrar personas que también puedan emocionarse con la idea y quieran construirla conmigo.',
      skills: ['Flutter', 'Laravel', 'Bases de datos'],
      interests: ['IA', 'Emprendimiento', 'Educación'],
      wantsToLearn: ['Diseño', 'UX research', 'Emprendimiento'],
      availability: 'Fines de semana y noches entre semana',
      modality: Modality.hibrida,
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
      interests: ['Inclusión', 'Juegos', 'Educación'],
      wantsToLearn: ['Desarrollo móvil', 'Animación'],
      availability: 'Tardes entre semana',
      modality: Modality.hibrida,
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
      interests: ['Diseño de producto', 'Narrativa'],
      wantsToLearn: ['Frontend', 'Investigación'],
      availability: 'Mañanas flexibles',
      modality: Modality.virtual,
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
      interests: ['Clima', 'Ciudad', 'Comunidad'],
      wantsToLearn: ['Apps móviles', 'Comunicación'],
      availability: 'Noches',
      modality: Modality.presencial,
    );

    const maria = Student(
      id: 'maria',
      name: 'María Torres',
      career: 'Psicología',
      email: 'maria.torres@continental.edu.pe',
      description: 'Facilito que las personas se organicen alrededor de lo que importa.',
      passions: 'Bienestar, equipos y hábitos.',
      whatMovesYou:
          'La motivación compartida me parece más poderosa que cualquier skill aislada.',
      skills: ['Facilitación', 'Escucha activa'],
      interests: ['Bienestar', 'Equipos', 'Hábitos'],
      wantsToLearn: ['Producto digital'],
      availability: 'Fines de semana',
      modality: Modality.virtual,
    );

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
            'Busco personas curiosas, comprometidas y que no tengan miedo de aprender algo nuevo. No es necesario que conozcan todo desde el principio.',
        categories: ['Educación', 'Social'],
        knowledgeAreas: ['Educación', 'Electrónica', 'Diseño'],
        modality: Modality.hibrida,
      ),
      ProjectIdea(
        id: 'contigo-meta',
        author: currentUser,
        codeName: 'CONTIGO',
        title: 'Plataforma para conectar estudiantes alrededor de ideas',
        about:
            'Un espacio donde una idea encuentra a las personas que quieren hacerla realidad, priorizando afinidad y motivación.',
        why:
            'Encontrar personas que realmente conecten con la idea suele ser más difícil que desarrollar la solución.',
        motivation:
            'Quiero que conectar con una idea sea el primer paso, no el checklist de skills.',
        lookingForPeople:
            'Personas de cualquier carrera que se identifiquen con el problema. Si la idea te mueve, hablemos.',
        categories: ['Tecnología', 'Emprendimiento'],
        knowledgeAreas: ['Producto', 'UX', 'Backend'],
        modality: Modality.hibrida,
      ),
      ProjectIdea(
        id: 'huertos',
        author: diego,
        codeName: 'HUERTA+',
        title: 'Mapa colaborativo de huertos urbanos del barrio',
        about:
            'Conecta a quienes quieren compostar con quienes tienen espacio, alrededor de una herramienta simple y visible.',
        why:
            'Hay gente con ganas y gente con espacio, pero no se encuentran.',
        motivation: 'Prefiero compromiso a expertise.',
        lookingForPeople:
            'Alguien con ganas de salir a conversar con la comunidad y construir algo concreto.',
        categories: ['Ambiente', 'Social'],
        knowledgeAreas: ['Mapas', 'Móvil', 'Comunicación'],
        modality: Modality.presencial,
      ),
      ProjectIdea(
        id: 'habit',
        author: maria,
        codeName: 'PARES',
        title: 'Acompañamiento entre pares para hábitos de estudio sin culpa',
        about:
            'Parejas de accountability elegidas por afinidad, no por rachas perfectas.',
        why: 'Muchas apps de hábitos parecen castigar.',
        motivation: 'Algo más humano para sostenerse juntos.',
        lookingForPeople:
            'Personas empáticas que quieran prototipar dinámicas de acompañamiento.',
        categories: ['Educación', 'Social'],
        knowledgeAreas: ['Facilitación', 'UI simple'],
        modality: Modality.virtual,
      ),
      ProjectIdea(
        id: 'portfolio',
        author: luis,
        codeName: 'PORQUÉ',
        title: 'Portafolio vivo donde el “por qué” pesa más que las pantallas',
        about:
            'Un formato que cuenta motivación, proceso y con quién quieres construir lo siguiente.',
        why: 'Estoy cansado de portfolios que solo muestran habilidades.',
        motivation: 'La identidad de un creador es su historia, no solo su skill list.',
        lookingForPeople:
            'Alguien que quiera experimentar formatos narrativos, aunque no diseñe.',
        categories: ['Tecnología', 'Emprendimiento'],
        knowledgeAreas: ['Copy', 'Web', 'Motion'],
        modality: Modality.virtual,
      ),
    ];

    connections = [
      TeamConnection(
        id: 'c1',
        project: projects.firstWhere((p) => p.id == 'brailit'),
        members: [currentUser, ana, luis],
        bucket: ConnectionBucket.enConversacion,
        lastMessage: '¿Te parece si conversamos mañana?',
      ),
      TeamConnection(
        id: 'c2',
        project: projects.firstWhere((p) => p.id == 'huertos'),
        members: [currentUser, diego],
        bucket: ConnectionBucket.nuevas,
        lastMessage: 'Ambos quieren conocer más sobre este proyecto.',
      ),
    ];

    interestedProjectIds.addAll(['brailit', 'huertos']);

    chats['c1'] = [
      ChatMessage(
        fromId: 'ana',
        text: 'Hola Eduardo, vi tu perfil y me encantó cómo hablas de construir juntos.',
        at: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      ChatMessage(
        fromId: 'eduardo',
        text: '¡Hola Ana! Me interesa bastante BRAILIT. No sé Braille, pero quiero aprender.',
        at: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      ChatMessage(
        fromId: 'ana',
        text: '¿Te parece si conversamos mañana?',
        at: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];
  }

  List<ProjectIdea> recommended() =>
      projects.where((p) => p.author.id != currentUser.id).toList();

  List<ProjectIdea> explore({String query = '', String? category}) {
    final q = query.trim().toLowerCase();
    return projects.where((p) {
      final matchCat =
          category == null || p.categories.any((c) => c == category);
      final matchQ = q.isEmpty ||
          p.codeName.toLowerCase().contains(q) ||
          p.title.toLowerCase().contains(q) ||
          p.about.toLowerCase().contains(q);
      return matchCat && matchQ;
    }).toList();
  }

  void expressInterest(String projectId, String note) {
    interestedProjectIds.add(projectId);
    final project = projects.firstWhere((p) => p.id == projectId);
    if (connections.any((c) => c.project.id == projectId)) return;
    connections.insert(
      0,
      TeamConnection(
        id: 'c-${DateTime.now().millisecondsSinceEpoch}',
        project: project,
        members: [currentUser, project.author],
        bucket: ConnectionBucket.nuevas,
        lastMessage: note,
      ),
    );
  }

  void addMessage(String connectionId, String text) {
    chats.putIfAbsent(connectionId, () => []);
    chats[connectionId]!.add(
      ChatMessage(fromId: currentUser.id, text: text, at: DateTime.now()),
    );
    final idx = connections.indexWhere((c) => c.id == connectionId);
    if (idx >= 0) {
      final c = connections[idx];
      connections[idx] = TeamConnection(
        id: c.id,
        project: c.project,
        members: c.members,
        bucket: ConnectionBucket.enConversacion,
        lastMessage: text,
      );
    }
  }

  void publishProject(ProjectIdea project) {
    projects.insert(0, project);
  }

  void updateProfile(Student student) {
    currentUser = student;
    profileComplete = true;
  }

  void proposeMeeting(MeetingProposal proposal) {
    lastMeeting = proposal;
  }
}
