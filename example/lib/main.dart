import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_hero_transform/local_hero_transform.dart';

void main() {
  runApp(MyApp());
}

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ValueNotifier<FavoriteShape> _switchNotifier;
  late ValueNotifier<TextDirection> _changeLanguage;

  @override
  void initState() {
    super.initState();
    _switchNotifier = ValueNotifier(FavoriteShape.gird);
    _changeLanguage = ValueNotifier(TextDirection.ltr);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _switchNotifier.dispose();
    _changeLanguage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ValueListenableBuilder(
        valueListenable: _changeLanguage,
        builder: (context, textDirection, child) {
          return Directionality(
            textDirection: textDirection,
            child: LocalHero(
              controller: _tabController,
              pages: [
                ListViewContent(
                  textDirection: textDirection,
                  basePageContext: context,
                ),
                GridViewContent(
                  textDirection: textDirection,
                  basePageContext: context,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                onPressed: () => _changeLanguage.value = TextDirection.rtl,
                icon: Text('🇸🇦'),
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                onPressed: () => _changeLanguage.value = TextDirection.ltr,
                icon: Text('🇺🇸'),
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildSwitchGridAndListButton(),
        ),
      ],
    );
  }

  Widget _buildSwitchGridAndListButton() {
    return ValueListenableBuilder(
      valueListenable: _switchNotifier,
      builder: (context, value, child) {
        return ConstrainedBox(
          constraints: BoxConstraints.tight(Size(35, 35)),
          child: AspectRatio(
            aspectRatio: 1.9 / 2,
            child: RawMaterialButton(
              onPressed: () => _switchBetweenGridAndList(),
              elevation: 0,
              visualDensity: const VisualDensity(
                vertical: -4,
                horizontal: -4,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              fillColor: Colors.blue,
              child: Icon(
                _tabController.index == 0 ? Icons.grid_view_rounded : Icons.view_agenda_outlined,
                size: 20 - 4,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  void _switchBetweenGridAndList() {
    if (_switchNotifier.value == FavoriteShape.gird) {
      _tabController.animateTo(1);
      _switchNotifier.value = FavoriteShape.list;
    } else {
      _tabController.animateTo(0);
      _switchNotifier.value = FavoriteShape.gird;
    }
  }
}

class GridViewContent extends StatelessWidget {
  const GridViewContent({super.key, required this.textDirection, required this.basePageContext});
  final TextDirection textDirection;
  final BuildContext basePageContext;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 16 / 21.5,
      padding: const EdgeInsets.all(8.0),
      children: List.generate(
        locations.length,
        (index) {
          return CardGridView(
            tagHero: index,
            textDirection: textDirection,
            cardModel: HeroCardModel(
              name: locations[index].name,
              title: locations[index].place,
              imageUrl: locations[index].imageUrl,
              subTitle: locations[index].place,
            ),
            optionalParameters: CardOptionalParameters(
              /*  custom image */
              // image: Image.network(
              //   '$urlPrefix/06-mexico-city.jpg',
              // height: 100,
              // width: 100,
              // fit: BoxFit.cover, // Cover the entire area.
              // ),
              onPressedCard: (cardModel, cardContext) {
                _navigateToDetailsScreen(cardModel, basePageContext);
              },
              onPressedFavoriteIcon: (cardModel, cardContext) {
                onPassedCard(cardModel, cardContext);
                log(cardModel.name, name: 'onPressed Favorite Icon');
              },
            ),
          );
        },
      ),
    );
  }
}

class ListViewContent extends StatelessWidget {
  const ListViewContent({super.key, required this.textDirection, required this.basePageContext});
  final TextDirection textDirection;
  final BuildContext basePageContext;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.h, right: 10, left: 10),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return CardListView(
          index: index,
          optionalParameters: CardOptionalParameters(
            /*  custom image */
            // image: Image.network(
            //   '$urlPrefix/06-mexico-city.jpg',
            // height: 100,
            // width: 100,
            // fit: BoxFit.cover, // Cover the entire area.
            // ),
            onPressedCard: (cardModel, cardContext) {
              _navigateToDetailsScreen(cardModel, basePageContext);
            },
            onPressedFavoriteIcon: (cardModel, cardContext) {
              onPassedCard(cardModel, cardContext);
              log(cardModel.name, name: 'onPressed Favorite Icon');
            },
          ),
          textDirection: textDirection,
          cardModel: HeroCardModel(
            name: locations[index].name,
            title: locations[index].place,
            imageUrl: locations[index].imageUrl,
            subTitle: locations[index].place,
          ),
        );
      },
    );
  }
}

void onPassedCard(HeroCardModel location, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        location.name,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.indigo,
    ),
  );
}

void _navigateToDetailsScreen(HeroCardModel cardModel, BuildContext basePageContext) {
  Navigator.push(
    basePageContext,
    MaterialPageRoute(
      builder: (_) => DetailsScreen(model: cardModel),
    ),
  );
}

class Location {
  const Location({
    required this.name,
    required this.place,
    required this.imageUrl,
  });
  final String name;
  final String place;
  final String imageUrl;
}

const urlPrefix = 'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
const locations = [
  Location(name: 'Mount', place: 'U.S.A', imageUrl: '$urlPrefix/01-mount-rushmore.jpg'),
  Location(name: 'Gardens', place: 'Singapore', imageUrl: '$urlPrefix/02-singapore.jpg'),
  Location(name: 'Machu Picchu', place: 'Peru', imageUrl: '$urlPrefix/03-machu-picchu.jpg'),
  Location(name: 'Vitznau', place: 'Switzerland', imageUrl: '$urlPrefix/04-vitznau.jpg'),
  Location(name: 'Bali', place: 'Indonesia', imageUrl: '$urlPrefix/05-bali.jpg'),
  Location(name: 'Mexico City', place: 'Mexico', imageUrl: '$urlPrefix/06-mexico-city.jpg'),
  Location(name: 'Cairo', place: 'Egypt', imageUrl: '$urlPrefix/07-cairo.jpg'),
  Location(name: 'Yemen', place: "Sana'a", imageUrl: '$urlPrefix/07-cairo.jpg'),
];

const backgroundColor = Color(0xFFF2F3F8);

enum FavoriteShape { gird, list }

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.model});
  final HeroCardModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(model.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 14,
            child: Image.network(
              model.imageUrl,
            ),
          )
        ],
      ),
    );
  }
}
