import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetailsScreen extends StatelessWidget {
  final dynamic movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenshots = (movie.screenshots as List?) ?? [];
    final similar = (movie.similar as List?) ?? [];
    final cast = (movie.cast as List?) ?? [];
    final genres = (movie.genres as List?) ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movie Detials',
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(.55),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),

              _TopPosterSection(movie: movie),

              const SizedBox(height: 10),

              _SectionTitle(title: 'Screen Shots'),
              const SizedBox(height: 6),

              ...screenshots.map(
                    (image) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _ScreenshotCard(imagePath: image.toString()),
                ),
              ),

              const SizedBox(height: 4),

              _SectionTitle(title: 'Similar'),
              const SizedBox(height: 8),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: similar.length > 4 ? 4 : similar.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  return _SimilarPosterCard(
                    imagePath: similar[index].toString(),
                    rating: movie.ratingText,
                  );
                },
              ),

              const SizedBox(height: 10),

              _SectionTitle(title: 'Summary'),
              const SizedBox(height: 6),

              Text(
                movie.summary ?? '',
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(.72),
                  fontSize: 9.5,
                  height: 1.55,
                ),
              ),

              const SizedBox(height: 12),

              _SectionTitle(title: 'Cast'),
              const SizedBox(height: 8),

              ...cast.map(
                    (member) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _CastCard(member: member),
                ),
              ),

              const SizedBox(height: 2),

              _SectionTitle(title: 'Genres'),
              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: genres
                    .map<Widget>(
                      (genre) => _GenreChip(label: genre.toString()),
                )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopPosterSection extends StatelessWidget {
  final dynamic movie;

  const _TopPosterSection({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFFF2AD4),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  movie.imagePath,
                  width: double.infinity,
                  height: 232,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(.14),
                ),
              ),

              Positioned(
                top: 8,
                left: 6,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 22,
                    width: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.28),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.bookmark_rounded,
                  color: Colors.white.withOpacity(.95),
                  size: 16,
                ),
              ),

              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFC107),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFC107).withOpacity(.38),
                          blurRadius: 14,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
            child: Column(
              children: [
                Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.year ?? '',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(.6),
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF2E2E),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Watch',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFD54F),
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 28,
            color: const Color(0xFF242424),
            child: Row(
              children: [
                Expanded(
                  child: _BottomStat(
                    icon: Icons.favorite,
                    value: '${movie.likes ?? 0}',
                  ),
                ),
                _DividerLine(),
                Expanded(
                  child: _BottomStat(
                    icon: Icons.access_time_filled_rounded,
                    value: '${movie.runtimeMinutes ?? 0}',
                  ),
                ),
                _DividerLine(),
                Expanded(
                  child: _BottomStat(
                    icon: Icons.star_rounded,
                    value: movie.ratingText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomStat extends StatelessWidget {
  final IconData icon;
  final String value;

  const _BottomStat({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFFFFC107),
            size: 13,
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: Colors.white.withOpacity(.12),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ScreenshotCard extends StatelessWidget {
  final String imagePath;

  const _ScreenshotCard({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 72,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _SimilarPosterCard extends StatelessWidget {
  final String imagePath;
  final String rating;

  const _SimilarPosterCard({
    required this.imagePath,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.70),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    rating,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFC107),
                    size: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  final dynamic member;

  const _CastCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(member.imagePath),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 8.5,
                  height: 1.45,
                ),
                children: [
                  const TextSpan(
                    text: 'Name : ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: member.name),
                  const TextSpan(text: '\n'),
                  const TextSpan(
                    text: 'Character : ',
                    style: TextStyle(fontWeight: FontWeight.w700),
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

class _GenreChip extends StatelessWidget {
  final String label;

  const _GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: Colors.white.withOpacity(.9),
          fontSize: 8.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}