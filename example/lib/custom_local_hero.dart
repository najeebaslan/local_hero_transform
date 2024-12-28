import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_hero_transform/local_hero_transform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      enableScaleText: () => false,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: darkBlue,
          ),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        );
      },
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
    _changeLanguage = ValueNotifier(TextDirection.rtl);
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
      appBar: AppBar(
        backgroundColor: darkBlue,
        surfaceTintColor: darkBlue,
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
      ),
      body: ValueListenableBuilder(
        valueListenable: _changeLanguage,
        builder: (context, textDirection, child) {
          return Directionality(
            textDirection: textDirection,
            child: LocalHero(
              controller: _tabController,
              pages: [
                ListViewItems(
                  textDirection: textDirection,
                ),
                GridViewItems(
                  textDirection: textDirection,
                ),
              ],
            ),
          );
        },
      ),
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

class GridViewItems extends StatelessWidget {
  const GridViewItems({super.key, required this.textDirection});
  final TextDirection textDirection;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 16 / 21.5,
      padding: const EdgeInsets.all(8.0),
      children: List.generate(
        locations.length,
        (index) => CustomCardGridView(
          index: index,
          location: locations[index],
          textDirection: textDirection,
        ),
      ),
    );
  }
}

class ListViewItems extends StatelessWidget {
  const ListViewItems({super.key, required this.textDirection});
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return CustomCardListView(
          index: index,
          textDirection: textDirection,
          location: locations[index],
        );
      },
    );
  }
}

class CustomCardGridView extends StatelessWidget {
  final int index;
  final Location location;
  final TextDirection textDirection;
  const CustomCardGridView({
    required this.location,
    required this.index,
    required this.textDirection,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      flightShuttleBuilder:
          (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
        final positionRight = Tween<double>(begin: 100, end: 10).animate(animation);
        final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);

        // Get size for the to hero widget or from hero widget size
        RenderBox? renderBoxFrom = fromHeroContext.findRenderObject() as RenderBox?;
        RenderBox? renderBoxTo = toHeroContext.findRenderObject() as RenderBox?;
        final animationHeight =
            Tween<double>(begin: 90, end: renderBoxTo!.size.height * 0.67).animate(animation);

        final animationWidth =
            Tween<double>(begin: 80, end: renderBoxTo.size.width * 0.9).animate(animation);
        final favoriteIconPosition =
            Tween<double>(begin: renderBoxFrom!.size.width - 72, end: 20).animate(animation);
        final favoriteIconHeightPosition =
            Tween<double>(begin: renderBoxFrom.size.height - 72, end: 20).animate(animation);

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return BaseFavoriteCard(
              textDirection: textDirection,
              favoriteIconHeightPosition: favoriteIconHeightPosition.value,
              favoriteIconPosition: favoriteIconPosition.value,
              location: location,
              index: index,
              heightImage: animationHeight.value,
              widthImage: animationWidth.value,
              bottomTitle: positionBottom.value,
              rightTitle: positionRight.value,
              rightPrice: positionRight.value,
            );
          },
        );
      },
      createRectTween: (Rect? begin, Rect? end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return BaseFavoriteCard(
          textDirection: textDirection,
          favoriteIconHeightPosition: 20,
          favoriteIconPosition: 20,
          location: location,
          index: index,
          heightImage: constraints.maxHeight * 0.67,
          widthImage: 180,
          bottomTitle: 50,
          rightTitle: 10,
          rightPrice: 10,
        );
      }),
    );
  }
}

class CustomCardListView extends StatelessWidget {
  final int index;
  final Location location;
  final TextDirection textDirection;
  const CustomCardListView({
    super.key,
    required this.index,
    required this.textDirection,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      flightShuttleBuilder:
          (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
        final positionRight = Tween<double>(begin: 10, end: 100).animate(animation);
        final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);
        // Get size for the to hero widget or from hero widget size
        RenderBox? renderBoxTo = toHeroContext.findRenderObject() as RenderBox?;
        RenderBox? renderBoxFrom = fromHeroContext.findRenderObject() as RenderBox?;
        final animationHeight =
            Tween<double>(begin: renderBoxFrom!.size.height * 0.67, end: 90).animate(animation);
        final animationWidth =
            Tween<double>(begin: renderBoxFrom.size.width * 0.9, end: 80).animate(animation);
        final favoriteIconPosition =
            Tween<double>(begin: 20, end: renderBoxTo!.size.width - 72).animate(animation);
        final favoriteIconHeightPosition =
            Tween<double>(begin: 20, end: renderBoxTo.size.height - 72).animate(animation);

        return AnimatedBuilder(
          animation: animationHeight,
          builder: (context, child) {
            return BaseFavoriteCard(
              textDirection: textDirection,
              location: location,
              index: index,
              heightImage: animationHeight.value,
              widthImage: animationWidth.value,
              bottomTitle: positionBottom.value,
              rightTitle: positionRight.value,
              rightPrice: positionRight.value,
              favoriteIconPosition: favoriteIconPosition.value,
              favoriteIconHeightPosition: favoriteIconHeightPosition.value,
            );
          },
        );
      },
      createRectTween: (Rect? begin, Rect? end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      child: BaseFavoriteCard(
        textDirection: textDirection,
        favoriteIconHeightPosition: 100 - 72,
        favoriteIconPosition: MediaQuery.sizeOf(context).width - 72,
        location: location,
        index: index,
        heightImage: 100,
        widthImage: 80,
        bottomTitle: 50,
        rightTitle: 100,
        rightPrice: 100,
      ),
    );
  }
}

class BaseFavoriteCard extends StatelessWidget {
  final int index;
  final double heightImage;
  final double widthImage;
  final double bottomTitle;
  final double rightTitle;
  final double rightPrice;
  final double favoriteIconPosition;
  final double favoriteIconHeightPosition;
  final Location location;
  final TextDirection textDirection;
  const BaseFavoriteCard({
    super.key,
    required this.index,
    required this.heightImage,
    required this.widthImage,
    required this.bottomTitle,
    required this.rightTitle,
    required this.rightPrice,
    required this.location,
    required this.textDirection,
    required this.favoriteIconPosition,
    required this.favoriteIconHeightPosition,
  });

  @override
  Widget build(BuildContext context) {
    bool isRtl = textDirection == TextDirection.rtl;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: heightImage),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color(0xFF3A5160).withValues(alpha: 0.1),
              offset: const Offset(0, 5),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Stack(
          children: [
            _buildImage(height: heightImage, width: widthImage),
            Positioned(
              top: favoriteIconHeightPosition.abs(),
              right: isRtl ? favoriteIconPosition : null,
              left: !isRtl ? favoriteIconPosition : null,
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                ),
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {},
              ),
            ),
            Positioned(
              bottom: bottomTitle,
              right: isRtl ? rightTitle : 10.w,
              left: !isRtl ? rightTitle : 10.w,
              child: Row(
                children: [
                  Text(
                    location.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Positioned(
              bottom: (bottomTitle / 1.6).h,
              right: isRtl ? rightPrice : null,
              left: !isRtl ? rightPrice : null,
              child: RichText(
                text: TextSpan(
                  text: location.place.toString(),
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    WidgetSpan(child: SizedBox(width: 3.w)),
                    TextSpan(
                      text: 'sar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: bottomTitle / 6,
              right: isRtl ? rightPrice : null,
              left: !isRtl ? rightPrice : null,
              child: _buildLocation(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage({double? height, double? width}) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.network(
          location.imageUrl,
          height: height?.h ?? 200,
          width: width?.w ?? 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Row _buildLocation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: const Color(0xFF95979A),
          size: 10,
        ),
        SizedBox(width: 1.w),
        Text(
          location.name,
          style: TextStyle(
            color: const Color(0xFF95979A),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class Location {
  const Location({required this.name, required this.place, required this.imageUrl});
  final String name;
  final String place;
  final String imageUrl;
}

const urlPrefix = 'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
const locations = [
  Location(name: 'Mount ', place: 'U.S.A', imageUrl: '$urlPrefix/01-mount-rushmore.jpg'),
  Location(name: 'Gardens ', place: 'Singapore', imageUrl: '$urlPrefix/02-singapore.jpg'),
  Location(name: 'Machu Picchu', place: 'Peru', imageUrl: '$urlPrefix/03-machu-picchu.jpg'),
  Location(name: 'Vitznau', place: 'Switzerland', imageUrl: '$urlPrefix/04-vitznau.jpg'),
  Location(name: 'Bali', place: 'Indonesia', imageUrl: '$urlPrefix/05-bali.jpg'),
  Location(name: 'Mexico City', place: 'Mexico', imageUrl: '$urlPrefix/06-mexico-city.jpg'),
  Location(name: 'Cairo', place: 'Egypt', imageUrl: '$urlPrefix/07-cairo.jpg'),
  Location(name: 'Yemen', place: "Sana'a", imageUrl: '$urlPrefix/07-cairo.jpg'),
];

const darkBlue = Color(0xFFF2F3F8);
enum FavoriteShape { gird, list }
