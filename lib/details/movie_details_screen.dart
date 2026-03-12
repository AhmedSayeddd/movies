import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/profile/cubit/profile_cubit.dart';
import 'package:movies/profile/cubit/profile_state.dart';
import 'package:movies/home/cubit/movie_cubit.dart';
import 'package:movies/home/cubit/movie_state.dart';
import 'package:movies/home/models/movie_model.dart';
import 'models/movie_details_model.dart';
import 'widgets/cast_item.dart';
import 'widgets/genres_wrap.dart';
import 'widgets/movie_stats_row.dart';
import 'widgets/poster_header.dart';
import 'widgets/screenshot_list.dart';
import 'widgets/similar_movies_section.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = '/movieDetails';

  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final passedMovie =
          ModalRoute.of(context)?.settings.arguments as MovieModel?;
      if (passedMovie != null) {
        context.read<MovieCubit>().fetchMovieDetails(passedMovie.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final passedMovie =
        ModalRoute.of(context)?.settings.arguments as MovieModel?;

    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        MovieDetailsModel? details;
        bool isLoading = state is MovieDetailsLoading || state is MovieInitial;
        bool isError = state is MovieDetailsError;
        String errorMsg = '';

        if (state is MovieDetailsLoaded) {
          details = state.movieDetails;
        } else if (state is MovieDetailsError) {
          errorMsg = state.message;
        }

        final displayPoster = details?.poster ?? passedMovie?.poster ?? '';
        final displayTitle = details?.title ?? passedMovie?.title ?? '';
        final displayRating = details?.rating ?? passedMovie?.rating ?? 0.0;
        final displayYear = details?.year ?? passedMovie?.year ?? 0;

        final headerMovie = MovieDetailsModel(
          id: passedMovie?.id ?? 0,
          title: displayTitle,
          poster: displayPoster,
          year: displayYear,
          rating: displayRating,
          likes: 0,
          views: 0,
          runtime: 0,
          summary: '',
          screenshots: const [],
          genres: const [],
          cast: const [],
          similarMovies: const [],
        );

        return Scaffold(
          backgroundColor: const Color(0xFF141414),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    PosterHeader(movie: headerMovie),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 8,
                      left: 10,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).maybePop(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 8,
                      right: 10,
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, profileState) {
                          bool isInWatchlist = false;
                          if (profileState is ProfileLoaded) {
                            isInWatchlist = profileState.user.watchlist.any(
                              (m) => m.id == (passedMovie?.id ?? 0),
                            );
                          }
                          return Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                isInWatchlist
                                    ? Icons.bookmark_rounded
                                    : Icons.bookmark_border_rounded,
                                color: isInWatchlist
                                    ? const Color(0xFFFFBB3B)
                                    : Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                if (passedMovie != null) {
                                  context.read<ProfileCubit>().toggleWatchlist(
                                    passedMovie,
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFBB3B),
                      ),
                    ),
                  )
                else if (isError)
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Center(
                      child: Text(
                        errorMsg,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else if (details != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MovieStatsRow(movie: details),
                  ),
                  const SizedBox(height: 22),
                  if (details.screenshots.isNotEmpty) ...[
                    const _SectionTitle(title: 'Screen Shots'),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ScreenshotList(screenshots: details.screenshots),
                    ),
                    const SizedBox(height: 22),
                  ],
                  if (details.similarMovies.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SimilarMoviesSection(
                        movies: details.similarMovies,
                        onMovieTap: (movie) {
                          Navigator.pushNamed(
                            context,
                            MovieDetailsScreen.routeName,
                            arguments: movie,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                  ],
                  if (details.summary.isNotEmpty) ...[
                    const _SectionTitle(title: 'Summary'),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        details.summary,
                        style: GoogleFonts.poppins(
                          color: Colors.white.withValues(alpha: 0.65),
                          fontSize: 12,
                          height: 1.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                  ],
                  if (details.cast.isNotEmpty) ...[
                    const _SectionTitle(title: 'Cast'),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: details.cast
                            .map((m) => CastItem(member: m))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 22),
                  ],
                  if (details.genres.isNotEmpty) ...[
                    const _SectionTitle(title: 'Genres'),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GenresWrap(genres: details.genres),
                    ),
                  ],
                ],
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
