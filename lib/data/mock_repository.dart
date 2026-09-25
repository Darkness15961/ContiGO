import '../models/models.dart';

/// Datos simulados. Sin backend todavía.
class MockRepository {
  MockRepository() {
    _seed();
  }

  late final Student currentUser;
  late final List<ProjectIdea> ideas;
  late final List<AffinityMatch> matches;
  final Set<String> connectedIdeaIds = {};
  final Set<String> savedIdeaIds = {};
  final Map<String, List<ConnectionReason>> connectionReasons = {};

  void _seed() {
    currentUser = const Student(
      id: 'eduardo',
      name: 'Eduardo Vargas',
      career: 'Ingeniería de Sistemas',
      year: 2024,
      whatMovesYou:
          'Soy una persona apasionada por los proyectos. Me enamoro muy fácilmente de las ideas y cuando algo realmente me interesa puedo pasar mucho tiempo pensando cómo hacerlo realidad. Me gusta investigar, cuestionar las posibilidades y buscar diferentes caminos. Lo que más me motiva no es solamente terminar un proyecto, sino encontrar personas que también puedan emocionarse con la idea y quieran construirla conmigo.',
      interests: ['educación', 'impacto social', 'tecnología', 'comunidades'],
      canTeach: ['desarrollo de apps', 'arquitectura', 'gestión técnica'],
      wantsToLearn: ['diseño', 'investigación de usuarios', 'emprendimiento'],
      workStyle: 'Explorar y experimentar',
      availability: 'Fines de semana y noches entre semana',
    );

    const ana = Student(
      id: 'ana',
      name: 'Ana Quispe',
      career: 'Educación Especial',
      year: 2023,
      whatMovesYou:
          'Creo que el acceso al aprendizaje no debería depender de si alguien puede ver o no. Me mueve la inclusión real: no caridad, sino herramientas dignas y divertidas.',
      interests: ['inclusión', 'juegos', 'educación', 'accesibilidad'],
      canTeach: ['pedagogía', 'diseño de actividades'],
      wantsToLearn: ['desarrollo móvil', 'animación'],
      workStyle: 'Prototipar rápido y probar con usuarios',
      availability: 'Tardes entre semana',
    );

    const luis = Student(
      id: 'luis',
      name: 'Luis Mendoza',
      career: 'Diseño Gráfico',
      year: 2022,
      whatMovesYou:
          'Me emociona cuando una idea empieza fea y termina siendo algo que la gente quiere usar. Me gusta el proceso de darle forma visual a algo que aún no existe.',
      interests: ['diseño de producto', 'identidad', 'storytelling'],
      canTeach: ['UI', 'branding', 'Figma'],
      wantsToLearn: ['frontend', 'investigación'],
      workStyle: 'Iterar con feedback constante',
      availability: 'Mañanas flexibles',
    );

    const maria = Student(
      id: 'maria',
      name: 'María Torres',
      career: 'Psicología',
      year: 2024,
      whatMovesYou:
          'Me interesa cómo las personas se organizan cuando algo les importa de verdad. La motivación compartida me parece más poderosa que cualquier skill aislada.',
      interests: ['bienestar', 'equipos', 'hábitos', 'comunidad'],
      canTeach: ['facilitación', 'escucha activa'],
      wantsToLearn: ['producto digital', 'análisis de datos'],
      workStyle: 'Conversar primero, construir después',
      availability: 'Fines de semana',
    );

    const diego = Student(
      id: 'diego',
      name: 'Diego Ríos',
      career: 'Ingeniería Ambiental',
      year: 2021,
      whatMovesYou:
          'Quiero que la tecnología sirva al territorio, no al revés. Me conecto con ideas que tienen impacto local medible.',
      interests: ['clima', 'datos abiertos', 'ciudad'],
      canTeach: ['SIG', 'análisis ambiental'],
      wantsToLearn: ['apps móviles', 'comunicación'],
      workStyle: 'Trabajo por hitos claros',
      availability: 'Noches',
    );

    ideas = [
      ProjectIdea(
        id: 'idea-braille',
        author: ana,
        title:
            'Quiero desarrollar una herramienta para enseñar Braille mediante juegos.',
        why:
            'He visto cómo niños pierden motivación cuando el aprendizaje se siente como obligación. Quiero que aprender Braille sea tan adictivo como un juego bien hecho. No busco a alguien que “sepa Braille”: busco a alguien que se enamore del problema.',
        lookingFor:
            'Busco personas curiosas, comprometidas y que no tengan miedo de aprender algo nuevo. No es necesario que conozcan todo desde el principio; quiero personas que quieran involucrarse realmente con la idea.',
        themeTags: ['educación', 'inclusión', 'juegos'],
        motivationTags: ['impacto social', 'aprender juntos'],
        skillsNiceToHave: ['Flutter', 'game design', 'ilustración'],
        canTeach: ['pedagogía', 'diseño de actividades'],
        wantsToLearn: ['desarrollo', 'animación'],
      ),
      ProjectIdea(
        id: 'idea-contigo-meta',
        author: currentUser,
        title:
            'Quiero crear una plataforma para conectar estudiantes de diferentes carreras.',
        why:
            'Siempre he tenido ideas y proyectos que me apasionan, pero muchas veces encontrar personas que realmente conecten con la idea es más difícil que desarrollar la propia solución. Quiero crear algo que permita que una idea encuentre a las personas que quieran hacerla realidad.',
        lookingFor:
            'Personas que se identifiquen con este problema. Me da igual si vienen de sistemas, diseño, psicología o administración: si la idea te mueve, hablemos.',
        themeTags: ['comunidades', 'tecnología', 'universidades'],
        motivationTags: ['conexión humana', 'construir juntos'],
        skillsNiceToHave: ['producto', 'UX research', 'backend'],
        canTeach: ['desarrollo', 'arquitectura'],
        wantsToLearn: ['diseño', 'emprendimiento'],
      ),
      ProjectIdea(
        id: 'idea-huertos',
        author: diego,
        title:
            'Mapa colaborativo de huertos urbanos y residuos orgánicos del barrio.',
        why:
            'Hay gente que quiere compostar y gente que tiene espacio, pero no se encuentran. Quiero que vecinos y estudiantes se organicen alrededor de algo concreto y visible.',
        lookingFor:
            'Alguien con ganas de salir a conversar con la comunidad y construir una herramienta simple. Prefiero compromiso a expertise.',
        themeTags: ['ciudad', 'ambiente', 'comunidad'],
        motivationTags: ['impacto local', 'colaboración'],
        skillsNiceToHave: ['mapas', 'móvil', 'comunicación'],
        canTeach: ['SIG', 'contexto ambiental'],
        wantsToLearn: ['apps', 'diseño de encuestas'],
      ),
      ProjectIdea(
        id: 'idea-habit',
        author: maria,
        title:
            'Un acompañamiento entre pares para sostener hábitos de estudio sin culpa.',
        why:
            'Muchas apps de hábitos parecen castigar. Quiero algo más humano: parejas de accountability que se elijan por afinidad, no por racha perfecta.',
        lookingFor:
            'Personas empáticas que quieran prototipar dinámicas de acompañamiento. Si te interesa la psicología + producto, perfecto; si solo te mueve el problema, también.',
        themeTags: ['bienestar', 'estudiantes', 'hábitos'],
        motivationTags: ['cuidado', 'sostenerse juntos'],
        skillsNiceToHave: ['facilitación', 'UI simple'],
        canTeach: ['escucha', 'dinámicas de grupo'],
        wantsToLearn: ['producto digital'],
      ),
      ProjectIdea(
        id: 'idea-portfolio',
        author: luis,
        title:
            'Portafolio vivo donde el “por qué” del proyecto pesa más que las pantallas bonitas.',
        why:
            'Estoy cansado de ver portfolios que solo muestran habilidades. Quiero un formato que cuente la motivación, el proceso y con quién te gustaría construir lo siguiente.',
        lookingFor:
            'Alguien que quiera experimentar formatos narrativos. Ideal si te gusta escribir o investigar, aunque no diseñes.',
        themeTags: ['diseño', 'narrativa', 'carreras creativas'],
        motivationTags: ['identidad', 'proceso'],
        skillsNiceToHave: ['copy', 'web', 'motion'],
        canTeach: ['UI', 'branding'],
        wantsToLearn: ['frontend', 'research'],
      ),
    ];

    matches = [
      AffinityMatch(
        id: 'm1',
        idea: ideas.firstWhere((i) => i.id == 'idea-braille'),
        other: ana,
        reasons: const [ConnectionReason.problem, ConnectionReason.learn],
        status: MatchStatus.mutual,
        note:
            'Me encanta el problema. No sé Braille, pero quiero aprender y ayudar a construirla.',
      ),
      AffinityMatch(
        id: 'm2',
        idea: ideas.firstWhere((i) => i.id == 'idea-huertos'),
        other: diego,
        reasons: const [ConnectionReason.motivation],
        status: MatchStatus.pending,
        note: 'Me identifico con el impacto local.',
      ),
    ];

    connectedIdeaIds.addAll(['idea-braille', 'idea-huertos']);
    connectionReasons['idea-braille'] = [
      ConnectionReason.problem,
      ConnectionReason.learn,
    ];
    connectionReasons['idea-huertos'] = [ConnectionReason.motivation];
  }

  List<ProjectIdea> feedIdeas() {
    final others = ideas.where((i) => i.author.id != currentUser.id).toList();
    final mine = ideas.where((i) => i.author.id == currentUser.id).toList();
    return [...others, ...mine];
  }

  void connectToIdea(String ideaId, List<ConnectionReason> reasons) {
    connectedIdeaIds.add(ideaId);
    connectionReasons[ideaId] = reasons;
    final idea = ideas.firstWhere((i) => i.id == ideaId);
    if (matches.any((m) => m.idea.id == ideaId)) return;
    matches.insert(
      0,
      AffinityMatch(
        id: 'm-${DateTime.now().millisecondsSinceEpoch}',
        idea: idea,
        other: idea.author,
        reasons: reasons,
        status: MatchStatus.pending,
      ),
    );
  }

  void saveIdea(String ideaId) {
    if (savedIdeaIds.contains(ideaId)) {
      savedIdeaIds.remove(ideaId);
    } else {
      savedIdeaIds.add(ideaId);
    }
  }
}
