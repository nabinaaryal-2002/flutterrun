import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/video_state.dart';
import '../services/movie_service.dart';


final videoProvider = StateNotifierProvider.family<VideoNotifier, VideoState, int>((ref, int id)
=> VideoNotifier(
    VideoState(errorMessage: '', isLoad: false,
        videos: []
    ),
    id

)
);

class VideoNotifier extends StateNotifier<VideoState> {
  VideoNotifier(super.state, this.id){
    getMovieId();
  }
  final int id;

  Future<void> getMovieId() async {
    final response = await MovieService.getMovieId(movieId: id);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l);
    }, (r) {
      state =
          state.copyWith(isLoad: false, errorMessage: '', videos: r);
    });
  }

}