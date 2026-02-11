import 'package:audioplayers/audioplayers.dart';

class MusicPlayer {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isPlaying = false;
  static bool _specialMode = false;

  static bool get isPlaying => _isPlaying;

  static Future<void> playNormal() async {
    _specialMode = false;
    await _player.stop();
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(0.6);
    await _player.play(AssetSource('music/Sugar_Eyes.mp3'));
    _isPlaying = true;
  }

  static Future<void> playSpecial() async {
    _specialMode = true;
    await _player.stop();
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(0.8);
    await _player.play(AssetSource('music/Hers-little_by_little.mp3'));
    _isPlaying = true;
  }

  static Future<void> pause() async {
    await _player.pause();
    _isPlaying = false;
  }
}
