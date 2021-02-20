import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin_auth/core/view_model/auth_view_model..dart';

final authViewModelProvider =
    ChangeNotifierProvider.autoDispose<AuthViewModel>((ref) => AuthViewModel());
