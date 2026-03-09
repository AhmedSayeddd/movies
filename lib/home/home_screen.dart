import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/app_assets.dart';
import 'package:movies/core/app_color.dart';
import 'movie_details_screen.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _featuredController;
  double _currentPage = 1;
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _featuredController = PageController(
      viewportFraction: 0.58,
      initialPage: 1,
    );

    _featuredController.addListener(() {
      if (!mounted) return;
      setState(() {
        _currentPage = _featuredController.page ?? 1;
      });
    });
  }

  @override
  void dispose() {
    _featuredController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (_selectedNavIndex == index) return;

    Widget page;
    switch (index) {
      case 0:
        page = const HomeScreen();
        break;
      case 1:
        page = const SearchScreen();
        break;
      case 2:
        page = const BrowseScreen();
        break;
      case 3:
        page = const ProfileScreen();
        break;
      default:
        page = const HomeScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void _openMovieDetails(MovieItem movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailsScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeData = HomeResponse(
      featuredMovies: const [
        MovieItem(
          id: '1',
          title: 'Doctor Strange in the Multiverse of Madness',
          imagePath: AppAssets.Drstrange,
          rating: 7.7,
          tagline: 'TIME IS THE ENEMY',
          year: '2022',
          summary:
          'Doctor Strange teams up with a mysterious teenage girl who can travel across multiverses, to battle powerful threats that could destroy countless realities.',
          screenshots: [
            AppAssets.Drstrange,
            AppAssets.poster5,
            AppAssets.Acengers,
          ],
          similar: [
            AppAssets.poster5,
            AppAssets.Acengers,
            AppAssets.Drstrange,
            AppAssets.poster5,
          ],
          cast: [
            CastItem(
              name: 'Benedict Cumberbatch',
              role: 'Doctor Strange',
              imagePath: AppAssets.Drstrange,
            ),
            CastItem(
              name: 'Elizabeth Olsen',
              role: 'Wanda Maximoff',
              imagePath: AppAssets.Drstrange,
            ),
            CastItem(
              name: 'Benedict Wong',
              role: 'Wong',
              imagePath: AppAssets.Drstrange,
            ),
          ],
          genres: ['Action', 'Sci-Fi', 'Adventure', 'Fantasy', 'Horror'],
          likes: 15,
          runtimeMinutes: 126,
        ),
        MovieItem(
          id: '2',
          title: '1917',
          imagePath: AppAssets.poster5,
          rating: 7.6,
          tagline: 'TIME IS THE ENEMY',
          year: '2019',
          summary:
          'Two young British soldiers during the First World War are given an impossible mission to deliver a message that will stop a deadly attack.',
          screenshots: [
            AppAssets.poster5,
            AppAssets.Drstrange,
            AppAssets.Acengers,
          ],
          similar: [
            AppAssets.Drstrange,
            AppAssets.Acengers,
            AppAssets.poster5,
            AppAssets.Drstrange,
          ],
          cast: [
            CastItem(
              name: 'George MacKay',
              role: 'Schofield',
              imagePath: AppAssets.poster5,
            ),
            CastItem(
              name: 'Dean-Charles Chapman',
              role: 'Blake',
              imagePath: AppAssets.poster5,
            ),
          ],
          genres: ['War', 'Drama', 'Action'],
          likes: 12,
          runtimeMinutes: 119,
        ),
        MovieItem(
          id: '3',
          title: 'Avengers: Endgame',
          imagePath: AppAssets.Acengers,
          rating: 7.9,
          tagline: 'TIME IS THE ENEMY',
          year: '2019',
          summary:
          'After the devastating events caused by Thanos, the Avengers assemble once more to restore balance to the universe.',
          screenshots: [
            AppAssets.Acengers,
            AppAssets.poster5,
            AppAssets.Drstrange,
          ],
          similar: [
            AppAssets.Drstrange,
            AppAssets.poster5,
            AppAssets.Acengers,
            AppAssets.Drstrange,
          ],
          cast: [
            CastItem(
              name: 'Robert Downey Jr.',
              role: 'Iron Man',
              imagePath: AppAssets.Acengers,
            ),
            CastItem(
              name: 'Chris Evans',
              role: 'Captain America',
              imagePath: AppAssets.Acengers,
            ),
            CastItem(
              name: 'Scarlett Johansson',
              role: 'Black Widow',
              imagePath: AppAssets.Acengers,
            ),
          ],
          genres: ['Action', 'Sci-Fi', 'Adventure'],
          likes: 20,
          runtimeMinutes: 181,
        ),
      ],
      actionMovies: const [
        MovieItem(
          id: '4',
          title: 'Avengers',
          imagePath: AppAssets.Acengers,
          rating: 7.7,
          year: '2019',
          summary: 'The Avengers assemble once more to save the universe.',
          screenshots: [
            AppAssets.Acengers,
            AppAssets.poster5,
            AppAssets.Drstrange,
          ],
          similar: [
            AppAssets.poster5,
            AppAssets.Drstrange,
            AppAssets.Acengers,
            AppAssets.poster5,
          ],
          cast: [
            CastItem(
              name: 'Chris Evans',
              role: 'Captain America',
              imagePath: AppAssets.Acengers,
            ),
          ],
          genres: ['Action', 'Sci-Fi'],
          likes: 15,
          runtimeMinutes: 110,
        ),
        MovieItem(
          id: '5',
          title: 'Doctor Strange',
          imagePath: AppAssets.Drstrange,
          rating: 7.7,
          year: '2022',
          summary: 'Strange enters the multiverse to stop powerful threats.',
          screenshots: [
            AppAssets.Drstrange,
            AppAssets.poster5,
            AppAssets.Acengers,
          ],
          similar: [
            AppAssets.Acengers,
            AppAssets.poster5,
            AppAssets.Drstrange,
            AppAssets.Acengers,
          ],
          cast: [
            CastItem(
              name: 'Benedict Cumberbatch',
              role: 'Doctor Strange',
              imagePath: AppAssets.Drstrange,
            ),
          ],
          genres: ['Action', 'Fantasy'],
          likes: 17,
          runtimeMinutes: 95,
        ),
        MovieItem(
          id: '6',
          title: '1917',
          imagePath: AppAssets.poster5,
          rating: 7.7,
          year: '2019',
          summary: 'A dangerous mission in wartime with no time to lose.',
          screenshots: [
            AppAssets.poster5,
            AppAssets.Drstrange,
            AppAssets.Acengers,
          ],
          similar: [
            AppAssets.Drstrange,
            AppAssets.Acengers,
            AppAssets.poster5,
            AppAssets.Drstrange,
          ],
          cast: [
            CastItem(
              name: 'George MacKay',
              role: 'Schofield',
              imagePath: AppAssets.poster5,
            ),
          ],
          genres: ['War', 'Drama'],
          likes: 10,
          runtimeMinutes: 101,
        ),
        MovieItem(
          id: '7',
          title: 'Avengers: Infinity War',
          imagePath: AppAssets.Acengers,
          rating: 7.8,
          year: '2018',
          summary: 'Heroes from across the universe face the ultimate threat.',
          screenshots: [
            AppAssets.Acengers,
            AppAssets.poster5,
            AppAssets.Drstrange,
          ],
          similar: [
            AppAssets.poster5,
            AppAssets.Drstrange,
            AppAssets.Acengers,
            AppAssets.poster5,
          ],
          cast: [
            CastItem(
              name: 'Chris Hemsworth',
              role: 'Thor',
              imagePath: AppAssets.Acengers,
            ),
          ],
          genres: ['Action', 'Adventure'],
          likes: 13,
          runtimeMinutes: 149,
        ),
        MovieItem(
          id: '8',
          title: 'Doctor Strange: Chaos',
          imagePath: AppAssets.Drstrange,
          rating: 7.5,
          year: '2022',
          summary: 'Magic and multiverse collide in a dangerous new journey.',
          screenshots: [
            AppAssets.Drstrange,
            AppAssets.poster5,
            AppAssets.Acengers,
          ],
          similar: [
            AppAssets.Acengers,
            AppAssets.poster5,
            AppAssets.Drstrange,
            AppAssets.Acengers,
          ],
          cast: [
            CastItem(
              name: 'Elizabeth Olsen',
              role: 'Wanda Maximoff',
              imagePath: AppAssets.Drstrange,
            ),
          ],
          genres: ['Fantasy', 'Action'],
          likes: 9,
          runtimeMinutes: 102,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/HomeBG.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Opacity(
                  opacity: 1,
                  child: Image.asset(
                    'assets/images/BG.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.22),
                        Colors.black.withOpacity(0.08),
                        Colors.black.withOpacity(0.20),
                        Colors.black.withOpacity(0.72),
                        Colors.black.withOpacity(0.92),
                      ],
                      stops: const [0.0, 0.18, 0.45, 0.78, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 118),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Image.asset(
                      'assets/images/Available Now.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 340,
                    child: PageView.builder(
                      controller: _featuredController,
                      itemCount: homeData.featuredMovies.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final movie = homeData.featuredMovies[index];
                        final diff = (index - _currentPage).abs();
                        final scale = (1 - (diff * 0.18)).clamp(0.82, 1.0);
                        final sideOffset = diff * 18;
                        final isCenter = diff < 0.5;

                        return Transform.translate(
                          offset: Offset(
                            index < _currentPage ? -sideOffset : sideOffset,
                            isCenter ? 12 : 38,
                          ),
                          child: Transform.scale(
                            scale: scale,
                            child: Opacity(
                              opacity: isCenter ? 1 : 0.88,
                              child: GestureDetector(
                                onTap: () => _openMovieDetails(movie),
                                child: _FeaturedPosterCard(
                                  imagePath: movie.imagePath,
                                  rating: movie.ratingText,
                                  width: isCenter ? 188 : 102,
                                  height: isCenter ? 252 : 176,
                                  radius: isCenter ? 28 : 22,
                                  tagline: isCenter ? movie.tagline : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 2),
                  Center(
                    child: Image.asset(
                      'assets/images/Watch Now.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'Action',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'See More',
                                  style: GoogleFonts.poppins(
                                    color: const Color(AppColor.gold),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color(AppColor.gold),
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 175,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeData.actionMovies.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final movie = homeData.actionMovies[index];
                        return GestureDetector(
                          onTap: () => _openMovieDetails(movie),
                          child: _MovieListCard(
                            imagePath: movie.imagePath,
                            rating: movie.ratingText,
                            width: 108,
                            height: 160,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _FloatingBottomNav(
              currentIndex: _selectedNavIndex,
              onTap: _onNavTap,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EmptyNavScreen(
      title: 'Search',
      currentIndex: 1,
      icon: Icons.search_rounded,
    );
  }
}

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EmptyNavScreen(
      title: 'Browse',
      currentIndex: 2,
      icon: Icons.play_circle_fill_rounded,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EmptyNavScreen(
      title: 'Profile',
      currentIndex: 3,
      icon: Icons.person_outline_rounded,
    );
  }
}

class _EmptyNavScreen extends StatelessWidget {
  final String title;
  final int currentIndex;
  final IconData icon;

  const _EmptyNavScreen({
    required this.title,
    required this.currentIndex,
    required this.icon,
  });

  void _onNavTap(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const HomeScreen();
        break;
      case 1:
        page = const SearchScreen();
        break;
      case 2:
        page = const BrowseScreen();
        break;
      case 3:
        page = const ProfileScreen();
        break;
      default:
        page = const HomeScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: const Color(AppColor.gold), size: 54),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Empty page',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(.55),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _FloatingBottomNav(
              currentIndex: currentIndex,
              onTap: (index) => _onNavTap(context, index),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeResponse {
  final List<MovieItem> featuredMovies;
  final List<MovieItem> actionMovies;

  const HomeResponse({
    required this.featuredMovies,
    required this.actionMovies,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      featuredMovies: (json['featuredMovies'] as List<dynamic>? ?? [])
          .map((e) => MovieItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      actionMovies: (json['actionMovies'] as List<dynamic>? ?? [])
          .map((e) => MovieItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MovieItem {
  final String id;
  final String title;
  final String imagePath;
  final double rating;
  final String? tagline;
  final String year;
  final String summary;
  final List<String> screenshots;
  final List<String> similar;
  final List<CastItem> cast;
  final List<String> genres;
  final int likes;
  final int runtimeMinutes;

  const MovieItem({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.rating,
    this.tagline,
    required this.year,
    required this.summary,
    required this.screenshots,
    required this.similar,
    required this.cast,
    required this.genres,
    required this.likes,
    required this.runtimeMinutes,
  });

  String get ratingText => rating.toStringAsFixed(1);

  factory MovieItem.fromJson(Map<String, dynamic> json) {
    return MovieItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imagePath: json['imagePath']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      tagline: json['tagline']?.toString(),
      year: json['year']?.toString() ?? '',
      summary: json['summary']?.toString() ?? '',
      screenshots: (json['screenshots'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      similar: (json['similar'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      cast: (json['cast'] as List<dynamic>? ?? [])
          .map((e) => CastItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      runtimeMinutes: (json['runtimeMinutes'] as num?)?.toInt() ?? 0,
    );
  }
}

class CastItem {
  final String name;
  final String role;
  final String imagePath;

  const CastItem({
    required this.name,
    required this.role,
    required this.imagePath,
  });

  factory CastItem.fromJson(Map<String, dynamic> json) {
    return CastItem(
      name: json['name']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      imagePath: json['imagePath']?.toString() ?? '',
    );
  }
}

class MovieDetailsScreen extends StatelessWidget {
  final MovieItem movie;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Movie Details',
          style: GoogleFonts.poppins(
            color: Colors.white.withOpacity(.80),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailsPosterSection(movie: movie),
            const SizedBox(height: 14),
            Text(
              'Screen Shots',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            ...movie.screenshots.map(
                  (image) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    height: 82,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Similar',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 230,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movie.similar.length > 4 ? 4 : movie.similar.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  return _SmallPosterCard(
                    imagePath: movie.similar[index],
                    rating: movie.ratingText,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Summary',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              movie.summary,
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(.72),
                fontSize: 10.5,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Cast',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            ...movie.cast.map((member) => _CastTile(member: member)),
            const SizedBox(height: 12),
            Text(
              'Genres',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: movie.genres
                  .map(
                    (genre) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    genre,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(.9),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsPosterSection extends StatelessWidget {
  final MovieItem movie;

  const _DetailsPosterSection({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFF4DDE), width: 2),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                movie.imagePath,
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 260,
                color: Colors.black.withOpacity(.18),
              ),
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFC107).withOpacity(.35),
                      blurRadius: 14,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: _RatingBadge(rating: movie.ratingText),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.bookmark_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.year,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(.6),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 24,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Watch',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 34,
            color: const Color(0xFF272727),
            child: Row(
              children: [
                _InfoStat(
                  icon: Icons.favorite,
                  value: movie.likes.toString(),
                  iconColor: const Color(0xFFFFC107),
                ),
                _divider(),
                _InfoStat(
                  icon: Icons.access_time_filled_rounded,
                  value: movie.runtimeMinutes.toString(),
                  iconColor: const Color(0xFFFFC107),
                ),
                _divider(),
                _InfoStat(
                  icon: Icons.star_rounded,
                  value: movie.ratingText,
                  iconColor: const Color(0xFFFFC107),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 20,
      color: Colors.white.withOpacity(.15),
    );
  }
}

class _InfoStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color iconColor;

  const _InfoStat({
    required this.icon,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 14),
            const SizedBox(width: 6),
            Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedPosterCard extends StatelessWidget {
  final String imagePath;
  final String rating;
  final double width;
  final double height;
  final double radius;
  final String? tagline;

  const _FeaturedPosterCard({
    required this.imagePath,
    required this.rating,
    required this.width,
    required this.height,
    required this.radius,
    this.tagline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.42),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: _RatingBadge(rating: rating),
          ),
          if (tagline != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 14,
              child: Center(
                child: Text(
                  tagline!,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.96),
                    fontSize: 7.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MovieListCard extends StatelessWidget {
  final String imagePath;
  final String rating;
  final double width;
  final double height;

  const _MovieListCard({
    required this.imagePath,
    required this.rating,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.20),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            child: _RatingBadge(rating: rating),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(.88),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallPosterCard extends StatelessWidget {
  final String imagePath;
  final String rating;

  const _SmallPosterCard({
    required this.imagePath,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 4,
            left: 4,
            child: _RatingBadge(rating: rating),
          ),
        ],
      ),
    );
  }
}

class _CastTile extends StatelessWidget {
  final CastItem member;

  const _CastTile({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(member.imagePath),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 10,
                ),
                children: [
                  const TextSpan(
                    text: 'Name : ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: member.name),
                  const TextSpan(text: '\n'),
                  const TextSpan(
                    text: 'Character : ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: member.role),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final String rating;

  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C).withOpacity(.85),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 3),
          const Icon(
            Icons.star_rounded,
            color: Color(0xFFFFC107),
            size: 14,
          ),
        ],
      ),
    );
  }
}

class _FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2D2B),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.35),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            icon: Icons.home_filled,
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavBarItem(
            icon: Icons.search_rounded,
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavBarItem(
            icon: Icons.play_circle_fill_rounded,
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavBarItem(
            icon: Icons.person_outline_rounded,
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          size: 25,
          color: isActive ? const Color(AppColor.gold) : Colors.white,
        ),
      ),
    );
  }
}