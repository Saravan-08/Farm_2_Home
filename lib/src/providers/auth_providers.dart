import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authStateProvider = StreamProvider((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final currentUserProvider = Provider((ref) {
  return ref.watch(authServiceProvider).currentUser;
});