import 'package:flutter/material.dart';
import 'package:local_hero_transform/local_hero_transform.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ValueNotifier<FavoriteShape> _switchNotifier;
  late final ValueNotifier<TextDirection> _changeLanguage;

  @override
  void initState() {
    super.initState();
    _switchNotifier = ValueNotifier(FavoriteShape.gird);
    _changeLanguage = ValueNotifier(TextDirection.ltr);
    _tabController = TabController(length: 2, vsync: this)..addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      _switchNotifier.value = _tabController.index == 0 ? FavoriteShape.gird : FavoriteShape.list;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _switchNotifier.dispose();
    _changeLanguage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ValueListenableBuilder<TextDirection>(
        valueListenable: _changeLanguage,
        builder: (context, textDirection, _) {
          return Directionality(
            textDirection: textDirection,
            child: LocalHeroViews(
              tabController: _tabController,
              onPressedCard: (index) => _navigateToDetailsScreen(
                context,
                locations[index].name,
                locations[index].imageUrl,
              ),
              textDirection: textDirection,
              itemCount: locations.length,
              itemsModel: (index) => _buildItemsModel(index),
            ),
          );
        },
      ),
    );
  }

  ItemsModel _buildItemsModel(int index) {
    return ItemsModel(
      image: DecorationImage(
        image: NetworkImage(locations[index].imageUrl),
        fit: BoxFit.cover,
      ),
      name: Text(
        locations[index].name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
      ),
      title: Text(
        locations[index].place,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subTitle: Text(
        locations[index].subtitle,
        style: const TextStyle(
          color: Color(0xFF95979A),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subTitleIcon: const Icon(
        Icons.location_on_outlined,
        color: Color(0xFF95979A),
        size: 15,
      ),
      favoriteIconButton: _buildFavoriteButton(),
    );
  }

  StatefulBuilder _buildFavoriteButton() {
    bool isFavored = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => isFavored ? Colors.redAccent : Colors.grey,
            ),
          ),
          icon: const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () => setState(() => isFavored = !isFavored),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      actions: [
        _buildLanguageButtons(),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildViewToggleButton(),
        ),
      ],
    );
  }

  Widget _buildLanguageButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildLanguageButton(TextDirection.rtl, '🇸🇦'),
          const SizedBox(width: 8),
          _buildLanguageButton(TextDirection.ltr, '🇺🇸'),
        ],
      ),
    );
  }

  IconButton _buildLanguageButton(TextDirection direction, String emoji) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Colors.grey.withValues(alpha: 0.3),
        ),
      ),
      onPressed: () => _changeLanguage.value = direction,
      icon: Text(emoji),
    );
  }

  Widget _buildViewToggleButton() {
    return ValueListenableBuilder<FavoriteShape>(
      valueListenable: _switchNotifier,
      builder: (context, value, _) {
        return ConstrainedBox(
          constraints: BoxConstraints.tight(Size(35, 35)),
          child: AspectRatio(
            aspectRatio: 1.9 / 2,
            child: RawMaterialButton(
              onPressed: _toggleView,
              elevation: 0,
              visualDensity: const VisualDensity(
                vertical: -4,
                horizontal: -4,
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              fillColor: Colors.blue,
              child: Icon(
                value == FavoriteShape.gird ? Icons.grid_view_rounded : Icons.view_agenda_outlined,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggleView() {
    final newIndex = _tabController.index == 0 ? 1 : 0;
    _tabController.animateTo(newIndex);
  }
}

void _navigateToDetailsScreen(BuildContext context, String name, String imageUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => DetailsScreen(name: name, imageUrl: imageUrl),
    ),
  );
}

const urlPrefix = 'https://docs.flutter.dev/cookbook/img-files/effects/parallax';

class Location {
  const Location({
    required this.name,
    required this.place,
    required this.imageUrl,
    required this.subtitle,
  });

  final String name;
  final String place;
  final String imageUrl;
  final String subtitle;
}

const locations = [
  Location(
    name: 'Mount ',
    place: 'U.S.A',
    imageUrl: '$urlPrefix/01-mount-rushmore.jpg',
    subtitle: 'Presidential monument',
  ),
  Location(
    name: 'Gardens ',
    place: 'Singapore',
    imageUrl: '$urlPrefix/02-singapore.jpg',
    subtitle: 'Futuristic gardens',
  ),
  Location(
    name: 'Machu Picchu',
    place: 'Peru',
    imageUrl: '$urlPrefix/03-machu-picchu.jpg',
    subtitle: 'Ancient Inca city',
  ),
  Location(
    name: 'Vitznau',
    place: 'Switzerland',
    imageUrl: '$urlPrefix/04-vitznau.jpg',
    subtitle: 'Lakeside village',
  ),
  Location(
    name: 'Bali',
    place: 'Indonesia',
    imageUrl: '$urlPrefix/05-bali.jpg',
    subtitle: 'Tropical paradise',
  ),
  Location(
    name: 'Mexico City',
    place: 'Mexico',
    imageUrl: '$urlPrefix/06-mexico-city.jpg',
    subtitle: 'Vibrant capital',
  ),
  Location(
    name: 'Cairo',
    place: 'Egypt',
    imageUrl: '$urlPrefix/07-cairo.jpg',
    subtitle: 'Pyramids city',
  ),
  Location(
    name: 'Yemen',
    place: "Sana'a",
    imageUrl: '$urlPrefix/07-cairo.jpg',
    subtitle: 'Ancient architecture',
  ),
];

const backgroundColor = Color(0xFFF2F3F8);

enum FavoriteShape { gird, list }

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(name),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 14,
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}