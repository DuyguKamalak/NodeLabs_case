import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

/// Büyük görselleri API limitini aşmayacak şekilde
/// Hedef: kısa kenar ~480px, kalite ~60. Çıktı: base64 (JPEG).
Future<String> compressToBase64(Uint8List originalBytes) async {
  final decoded = img.decodeImage(originalBytes);
  if (decoded == null) {
    throw Exception('Görsel çözümlenemedi');
  }

  // Ölçek: kısa kenarı 480'e çek
  const targetShort = 480;
  final short = decoded.width < decoded.height ? decoded.width : decoded.height;
  final scale = short > targetShort ? targetShort / short : 1.0;

  final resized = scale < 1.0
      ? img.copyResize(decoded,
          width: (decoded.width * scale).round(),
          height: (decoded.height * scale).round())
      : decoded;

  // JPEG kalite 60
  final jpg = img.encodeJpg(resized, quality: 60);

  return base64Encode(Uint8List.fromList(jpg));
}
