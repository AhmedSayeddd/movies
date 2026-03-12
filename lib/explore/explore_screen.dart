import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/widgets/category_movie_card.dart';
import 'cubit/explore_cubit.dart';
import 'cubit/explore_state.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<String> _genres = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Horror',
    'Romance',
    'Sci-Fi',
    'Thriller',
  ];

  String _selectedGenre = 'Action';

  @override
  void initState() {
    super.initState();
    context.read<ExploreCubit>().fetchMoviesByGenre(_selectedGenre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Browse',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _genres.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final genre = _genres[index];
                final isSelected = _selectedGenre == genre;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGenre = genre;
                    });
                    context.read<ExploreCubit>().fetchMoviesByGenre(genre);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFFFBB3B)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFFFBB3B)
                            : const Color.fromARGB(255, 255, 211, 37),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        genre,
                        style: GoogleFonts.poppins(
                          color: isSelected
                              ? Colors.black
                              : const Color.fromARGB(255, 255, 220, 20),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<ExploreCubit, ExploreState>(
              builder: (context, state) {
                if (state is ExploreLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
                  );
                } else if (state is ExploreError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 186, 26),
                      ),
                    ),
                  );
                } else if (state is ExploreLoaded) {
                  if (state.movies.isEmpty) {
                    return const Center(
                      child: Text(
                        'No movies found in this genre',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.68,
                        ),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return CategoryMovieCard(
                        movie: state.movies[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/movieDetails',
                            arguments: state.movies[index],
                          );
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
