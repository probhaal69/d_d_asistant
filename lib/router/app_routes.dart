import 'package:flutter/material.dart';
import 'package:d_d_asistant/screens/login_registrer/auth.dart';
import 'package:d_d_asistant/models/models.dart';
import 'package:d_d_asistant/screens/apis_screen/_screens.dart';
import 'package:d_d_asistant/screens/partidas/screens.dart';


class AppRoutes {

  static const initialRoute = '/login';

  static final menuDesplegable = <MenuOption>[
    MenuOption(
        route: 'partidas',
        name: 'Partidas',
        screen: const Partidas(),
        icon: Image.asset('assets/abilityScores.png')),
    // MenuOption(
    //     route: 'Bestiary',
    //     name: 'Bestiario',
    //     screen: const BestiaryDnD(),
    //     icon: Icons.add_alert_outlined),
  ];

  static final menuOptions = <MenuOption>[

    // MenuOption(
    //     route: 'ability_scores',
    //     name: 'Caracteristicas',
    //     screen: const AbilityDnD(),
    //     icon: Icons.list_alt),
    // MenuOption(
    //     route: 'acciones',
    //     name: 'Acciones',
    //     screen: const ActionsDnD(),
    //     icon: Icons.list),
    // MenuOption(
    //     route: 'alignments',
    //     name: 'Alineamientos',
    //     screen: const AlignmentsDnD(),
    //     icon: Icons.list),
    // MenuOption(
    //     route: 'backgrounds',
    //     name: 'Trasfondos',
    //     screen: const BackgroundsDnD(),
    //     icon: Icons.add_alert_outlined),
    // MenuOption(
    //     route: 'Bestiary',
    //     name: 'Bestiario',
    //     screen: const BestiaryDnD(),
    //     icon: Icons.add_alert_outlined),
    // MenuOption(
    //     route: 'Boons',
    //     name: 'Bendiciones',
    //     screen: const BoonsDnD(),
    //     icon: Icons.add_alert_outlined),
    // MenuOption(
    //     route: 'clases',
    //     name: 'Clases',
    //     screen: const ClasesDnD(),
    //     icon: Icons.credit_card),
    // MenuOption(
    //     route: 'Conditions',
    //     name: 'Condiciones y enfermedades',
    //     screen: const ConditionsDiseasesDnD(),
    //     icon: Icons.credit_card),
    // MenuOption(
    //     route: 'Cults',
    //     name: 'Cultos',
    //     screen: const CultsDnD(),
    //     icon: Icons.credit_card),
    // MenuOption(
    //     route: 'Deities',
    //     name: 'Deidades',
    //     screen: const DeitiesDnD(),
    //     icon: Icons.credit_card),
    // MenuOption(
    //     route: 'Encounters',
    //     name: 'Encuentros',
    //     screen: const EncountersDnD(),
    //     icon: Icons.credit_card),
    // MenuOption(
    //     route: 'feats',
    //     name: 'Dotes',
    //     screen: const FeatsDnD(),
    //     icon: Icons.details),
    // MenuOption(
    //     route: 'items_base',
    //     name: 'Items_base',
    //     screen: const ItemBaseDnD(),
    //     icon: Icons.details),
    // MenuOption(
    //     route: 'items',
    //     name: 'Items',
    //     screen: const ItemsDnD(),
    //     icon: Icons.details),
    // MenuOption(
    //     route: 'languages',
    //     name: 'Idiomas',
    //     screen: const LanguagesDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'loot',
    //     name: 'Recompensas',
    //     screen: const LootDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'magicvariants',
    //     name: 'Variantes magicas',
    //     screen: const MagicvariantsDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'monsterfeatures',
    //     name: 'Caraceristicas de monstruos',
    //     screen: const MonsterfeaturesDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'names',
    //     name: 'Nombres',
    //     screen: const NamesDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'objects',
    //     name: 'Objetos',
    //     screen: const ObjectsDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'races',
    //     name: 'Razas',
    //     screen: const RacesDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'senses',
    //     name: 'Sentidos',
    //     screen: const SensesDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'skills',
    //     name: 'Habilidades',
    //     screen: const SkillsDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'spells',
    //     name: 'Hechizos',
    //     screen: const SpellsDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'subclasses',
    //     name: 'Subclasses',
    //     screen: const SubClassesDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'subraces',
    //     name: 'Subrazas',
    //     screen: const SubRacesDnD(),
    //     icon: Icons.build_circle_outlined),
    // MenuOption(
    //     route: 'tables',
    //     name: 'Tablas',
    //     screen: const TablesDnD(),
    //     icon: Icons.build_circle_outlined),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes
        .addAll({
          'home': (BuildContext context) => const PaginaPrincipal(),
          '/register':(BuildContext context) => const RegisterScreen(),
          '/login':(BuildContext context) => LoginScreen(),
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
