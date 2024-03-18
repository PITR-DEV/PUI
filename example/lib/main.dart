import 'package:example/providers/noise.dart';
import 'package:example/providers/pui.dart';
import 'package:example/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:pui/pui.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Layout(
        child: ExampleApp(),
      ),
    ),
  );
}

class ExampleApp extends ConsumerWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puiEnabled = ref.watch(providerPuiEnabled);

    var theme = stockMaterialTheme();
    if (puiEnabled) theme = theme.applyPUI();

    return MaterialApp.router(
      title: 'PUI Gallery',
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: getRouterConfig,
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            if (ref.watch(providerGlobalNoiseEnabled) && puiEnabled)
              IgnorePointer(
                child: NoiseOverlay(
                  opacity: ref.watch(providerGlobalNoiseOpacity),
                  colored: ref.watch(providerGlobalNoiseColored),
                  scale: ref.watch(providerGlobalNoiseScale),
                ),
              ),
          ],
        );
      },
    );
  }

  ThemeData stockMaterialTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        brightness: Brightness.dark,
      ),
    );
  }
}
