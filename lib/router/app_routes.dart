import 'package:flutter/material.dart';
import 'package:d_d_asistant/screens/login_registrer/auth.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/screens/apis_screen/_screens.dart';
import 'package:d_d_asistant/screens/partidas/_screens.dart';


class AppRoutes {

  static const initialRoute = '/login';

  static final menuDesplegable = <MenuOption>[
    MenuOption(
        route: 'partidas',
        name: 'Partidas',
        screen: const Partidas(),
        icon: Image.asset('assets/abilityScores.png')),
  ];

  static final menuOptions = <MenuOption>[

    MenuOption(
        route: 'ability_scores',
        name: 'Caracteristicas',
        screen: AbilityDnD(),
        icon: Image.asset('assets/abilityScores.png')),
    MenuOption(
        route: 'acciones',
        name: 'Acciones',
        screen: ActionsDnD(),
        icon: Image.asset('assets/Acciones.png')),
    MenuOption(
        route: 'alignments',
        name: 'Alineamientos',
        screen: AlignmentsDnD(),
        icon: Image.asset('assets/Alineamiento.png')),
    MenuOption(
        route: 'backgrounds',
        name: 'Trasfondos',
        screen: BackgroundsDnD(),
        icon: Image.asset('assets/Trasfondo.png')),
    MenuOption(
        route: 'Bestiary',
        name: 'Bestiario',
        screen: BestiaryDnD(),
        icon: Image.asset('assets/bestiario.png')),
    MenuOption(
        route: 'Boons',
        name: 'Bendiciones',
        screen: BoonsDnD(),
        icon: Image.asset('assets/bendiciones.png')),
    MenuOption(
        route: 'clases',
        name: 'Clases',
        screen: ClasesDnD(),
        icon: Image.asset('assets/Clases.png')),
    MenuOption(
        route: 'Conditions',
        name: 'Condiciones y enfermedades',
        screen: ConditionsDiseasesDnD(),
        icon: Image.asset('assets/Condiciones y enfermedades.png')),
    MenuOption(
        route: 'Cults',
        name: 'Cultos',
        screen: CultsDnD(),
        icon: Image.asset('assets/Cultos.png')),
    MenuOption(
        route: 'Deities',
        name: 'Deidades',
        screen: DeitiesDnD(),
        icon: Image.asset('assets/Deidades.png')),
    MenuOption(
        route: 'Encounters',
        name: 'Encuentros',
        screen: EncountersDnD(),
        icon: Image.asset('assets/Encuentros.png')),
    MenuOption(
        route: 'feats',
        name: 'Dotes',
        screen: FeatsDnD(),
        icon: Image.asset('assets/Dotes.png')),
    MenuOption(
        route: 'items_base',
        name: 'Items_base',
        screen: ItemBaseDnD(),
        icon: Image.asset('assets/Variantes mágicas.png')),
    MenuOption(
        route: 'items',
        name: 'Items',
        screen: ItemsDnD(),
        icon: Image.asset('assets/Variantes mágicas.png')),
    MenuOption(
        route: 'languages',
        name: 'Idiomas',
        screen: LanguagesDnD(),
        icon: Image.asset('assets/Idiomas.png')),
    MenuOption(
        route: 'loot',
        name: 'Recompensas',
        screen: const LootDnD(),
        icon: Image.asset('assets/Recompensas.png')),
    MenuOption(
        route: 'magicvariants',
        name: 'Variantes magicas',
        screen: MagicvariantsDnD(),
        icon: Image.asset('assets/Variantes mágicas.png')),
    MenuOption(
        route: 'monsterfeatures',
        name: 'Caraceristicas de monstruos',
        screen: MonsterfeaturesDnD(),
        icon: Image.asset('assets/Características (2).png')),
    MenuOption(
        route: 'names',
        name: 'Nombres',
        screen: NamesDnD(),
        icon: Image.asset('assets/nombres.png')),
    MenuOption(
        route: 'objects',
        name: 'Objetos',
        screen: ObjectsDnD(),
        icon: Image.asset('assets/Variantes mágicas.png')),
    MenuOption(
        route: 'races',
        name: 'Razas',
        screen: RacesDnD(),
        icon: Image.asset('assets/raza.png')),
    MenuOption(
        route: 'senses',
        name: 'Sentidos',
        screen: SensesDnD(),
        icon: Image.asset('assets/Sentidos.png')),
    MenuOption(
        route: 'skills',
        name: 'Habilidades',
        screen: SkillsDnD(),
        icon: Image.asset('assets/Habilidades.png')),
    MenuOption(
        route: 'spells',
        name: 'Hechizos',
        screen: SpellsDnD(),
        icon: Image.asset('assets/Hechizos.png')),
    MenuOption(
        route: 'subclasses',
        name: 'Subclasses',
        screen: SubClassesDnD(),
        icon: Image.asset('assets/Subrrazas.png')),
    MenuOption(
        route: 'subraces',
        name: 'Subrazas',
        screen: SubRacesDnD(),
        icon: Image.asset('assets/Subrrazas.png')),
    MenuOption(
        route: 'tables',
        name: 'Tablas',
        screen: TablesDnD(),
        icon: Image.asset('assets/Tablas.png')),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes
        .addAll({
          'home': (BuildContext context) => const PaginaPrincipal(),
          '/register':(BuildContext context) => const RegisterScreen(),
          '/login':(BuildContext context) => LoginScreen(),
          '/partidas':(BuildContext context) => const Partidas(),
          });

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    for (final option in menuDesplegable) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
