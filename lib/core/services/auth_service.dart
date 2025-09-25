import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';
import '../models/auth_models.dart';
import 'package:dio/dio.dart';

class AuthService {
  static const String _userDataKey = "user_data";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiClient _apiClient = ApiClient.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  bool get isLoggedIn => currentUser != null;

  // =========  FOTOĞRAF URL: KULLANICIYA ÖZEL LOCAL CACHE  =========

  String? _currentUid() => _firebaseAuth.currentUser?.uid;

  Future<void> savePhotoUrlForCurrentUser(String url) async {
    final uid = _currentUid();
    if (uid == null || url.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('photo_url_$uid', url);
  }

  Future<String?> getPhotoUrlForCurrentUser() async {
    final uid = _currentUid();
    if (uid == null) return null;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('photo_url_$uid');
  }

  Future<void> clearPhotoUrlForCurrentUser() async {
    final uid = _currentUid();
    if (uid == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('photo_url_$uid');
  }

  // ================================================================

  // Email/Password Login
  Future<AuthResponse> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Firebase authentication failed');
      }

      final loginRequest = LoginRequest(email: email, password: password);
      final response = await _apiClient.apiService.login(loginRequest);

      await _apiClient.saveToken(response.token);
      await _saveUserData(response.user);

      // Sunucudan photoUrl geldiyse kullanıcıya özel cache’e yaz
      if (response.user.photoUrl != null &&
          response.user.photoUrl!.isNotEmpty) {
        await savePhotoUrlForCurrentUser(response.user.photoUrl!);
      }

      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Email/Password Register
  Future<AuthResponse> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Firebase user creation failed');
      }

      await credential.user!.updateDisplayName(name);

      final registerRequest =
          RegisterRequest(email: email, password: password, name: name);

      final response = await _apiClient.apiService.register(registerRequest);

      await _apiClient.saveToken(response.token);
      await _saveUserData(response.user);

      // Sunucudan photoUrl geldiyse kullanıcıya özel cache’e yaz
      if (response.user.photoUrl != null &&
          response.user.photoUrl!.isNotEmpty) {
        await savePhotoUrlForCurrentUser(response.user.photoUrl!);
      }

      return response;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Google Sign In
  Future<AuthResponse> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Google sign in cancelled');

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user == null) {
        throw Exception('Firebase authentication failed');
      }

      final tempPassword = 'google_${userCredential.user!.uid}';
      final email = userCredential.user!.email;
      final name = userCredential.user!.displayName ?? 'Google User';

      if (email == null || email.isEmpty) {
        throw Exception(
            'Google hesabı email paylaşmıyor. Lütfen başka bir hesap deneyin.');
      }

      AuthResponse response;
      try {
        final loginRequest = LoginRequest(email: email, password: tempPassword);
        response = await _apiClient.apiService.login(loginRequest);
      } on DioException catch (e) {
        if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
          final registerRequest =
              RegisterRequest(email: email, password: tempPassword, name: name);
          response = await _apiClient.apiService.register(registerRequest);
        } else {
          rethrow;
        }
      }

      await _apiClient.saveToken(response.token);
      await _saveUserData(response.user);

      // photoUrl geldiyse kullanıcıya özel yaz
      if (response.user.photoUrl != null &&
          response.user.photoUrl!.isNotEmpty) {
        await savePhotoUrlForCurrentUser(response.user.photoUrl!);
      }

      return response;
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  // Facebook Sign In
  Future<AuthResponse> signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status != LoginStatus.success) {
        throw Exception('Facebook login failed: ${result.status}');
      }

      final facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final userCredential =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      if (userCredential.user == null) {
        throw Exception('Firebase authentication failed');
      }

      final userData = await FacebookAuth.instance.getUserData();
      final tempPassword = 'facebook_${userCredential.user!.uid}';
      final email = userCredential.user!.email;
      final name = userData['name'] ??
          userCredential.user!.displayName ??
          'Facebook User';

      if (email == null || email.isEmpty) {
        throw Exception(
            'Facebook hesabı email paylaşmıyor. Lütfen başka bir hesap deneyin.');
      }

      AuthResponse response;
      try {
        final loginRequest = LoginRequest(email: email, password: tempPassword);
        response = await _apiClient.apiService.login(loginRequest);
      } on DioException catch (e) {
        if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
          final registerRequest =
              RegisterRequest(email: email, password: tempPassword, name: name);
          response = await _apiClient.apiService.register(registerRequest);
        } else {
          rethrow;
        }
      }

      await _apiClient.saveToken(response.token);
      await _saveUserData(response.user);

      // photoUrl geldiyse kullanıcıya özel yaz
      if (response.user.photoUrl != null &&
          response.user.photoUrl!.isNotEmpty) {
        await savePhotoUrlForCurrentUser(response.user.photoUrl!);
      }

      return response;
    } catch (e) {
      throw Exception('Facebook sign in failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await clearPhotoUrlForCurrentUser();

      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      await _apiClient.logout();
      await _clearUserData();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<UserProfile> getUserProfile() async {
    try {
      final token = await _apiClient.getToken();
      if (token == null) throw Exception('No authentication token found');
      final profile = await _apiClient.apiService.getProfile('Bearer $token');

      // Sunucudaki photoUrl’i varsa güncel cache’e yaz
      if (profile.photoUrl != null && profile.photoUrl!.isNotEmpty) {
        await savePhotoUrlForCurrentUser(profile.photoUrl!);
      }
      return profile;
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  // FOTOĞRAF YÜKLEME artık UploadPhotoPage içinde (Dio + multipart) yapılıyor.

  Future<void> _saveUserData(UserProfile user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, user.toJson().toString());
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
  }

  // sadece uyarıyı temiz ve güvenli bir stub bırakıyoruz.
  Future<UserProfile?> getCachedUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final _ = prefs.getString(_userDataKey);
      return null;
    } catch (e) {
      return null;
    }
  }
}
