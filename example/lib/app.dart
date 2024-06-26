import 'package:example/providers/navigation.dart';
import 'package:example/providers/pui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pui/pui.dart';

class AppPage extends ConsumerStatefulWidget {
  const AppPage({
    required this.state,
    required this.navigationTabs,
    required this.child,
    super.key,
  });
  final GoRouterState state;
  final Widget child;

  final List<NavigationTab> navigationTabs;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppPageState();
}

class _AppPageState extends ConsumerState<AppPage> {
  @override
  Widget build(BuildContext context) {
    final puiEnabled = ref.watch(providerPuiEnabled);

    return AppNavigation(
      routerState: widget.state,
      routes: widget.navigationTabs,
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
            text: 'PUI Gallery',
          ),
        ),
        actions: [
          const Text('PUI Theme'),
          const Gap(4),
          Switch(
            value: puiEnabled,
            onChanged: (value) =>
                ref.read(providerPuiEnabled.notifier).state = value,
          ),
          const Gap(4),
        ],
      ),
      showAppBar: ref.watch(providerShowAppBar),
      bottomBar: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bottom Bar'),
            Text('Bottom Bar'),
            Text('Bottom Bar'),
          ],
        ),
      ),
      showBottomBar: ref.watch(providerShowBottomBar),
      bottomBarHeight: ref.watch(providerBottomBarHeight),
      borderColor: puiEnabled ? null : Colors.transparent,
      child: widget.child,
    );
  }
}
