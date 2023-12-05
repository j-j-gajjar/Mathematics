import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../HomeScreen.dart';
import '../utils/colorConst.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.calculate_outlined,
          size: 50,
          color: Colors.white,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          if (kIsWeb)
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
                  (route) => false,
            );
        },
      ),
      title:  Text(
        AppLocalizations.of(context)?.appTitle ?? 'Mathematics',
        style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            letterSpacing: 2),
      ),
      backgroundColor: baseColor,
      elevation: 0,
    );
  }
}
