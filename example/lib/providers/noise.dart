import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerGlobalNoiseEnabled = StateProvider((ref) => true);
final providerGlobalNoiseColored = StateProvider((ref) => true);
final providerGlobalNoiseOpacity = StateProvider((ref) => 0.025);
final providerGlobalNoiseScale = StateProvider((ref) => 1.0);
