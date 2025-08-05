import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerContentBoxElevation = StateProvider<double>(
  (ref) => 1,
);

final providerShowAppBar = StateProvider<bool>(
  (ref) => true,
);

final providerShowActionButton = StateProvider<bool>(
  (ref) => false,
);

final providerShowBottomBar = StateProvider<bool>(
  (ref) => false,
);
final providerBottomBarHeight = StateProvider<double>(
  (ref) => 32,
);
