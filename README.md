# LocalHeroTransform ![](https://img.shields.io/badge/build-1.0.6-brightgreen)   [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
local hero transform is A Flutter package for creating seamless hero transitions between grid and list views with enhanced customization and performance for optimize user experience .


## ScreenShots
| ![Image 1](https://github.com/najeebaslan/social_media_file_for_project/blob/main/videos/local_hero_transform_package/base_local_hero.gif?raw=true) | ![Image 2](https://github.com/najeebaslan/social_media_file_for_project/blob/main/videos/local_hero_transform_package/custom_local_hero.gif?raw=true) | ![Image 3](https://github.com/najeebaslan/social_media_file_for_project/blob/main/videos/local_hero_transform_package/local_hero_without_hero_transform.gif?raw=true) |
|:--------------------------------------------:|:--------------------------------------------:|:--------------------------------------------:|
| ** source code [here](https://github.com/najeebaslan/local_hero_transform/blob/main/example/lib/main.dart)**                                  | **                                  | ** source code [here](https://github.com/najeebaslan/local_hero_transform/blob/main/example/lib/local_hero_without_hero_transform.dart)**                                  |

## Platform Support
| Android | iOS | MacOS  | Web | Linux | Windows |
| :-----: | :-: | :---:  | :-: | :---: | :-----: |
|   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️  |

## ✨Features
- **Seamless Transitions**: Beautiful hero animations between grid and list views
- **Highly Customizable**: Full control over card content and styling
- **Responsive Design**: Works on all screen sizes and devices
- **Performance Optimized**: Smooth animations even with many items
- **Flexible API**: Adapts to various use cases and designs

## Installation

Add `local_hero_transform` to your `pubspec.yaml` file:

```yaml
dependencies:
local_hero_transform: ^1.0.6
```
## Usage

Example
Here's a basic example of how to implement Local Hero Transform in your Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:local_hero_transform/local_hero_transform.dart';

class MyHomePage extends StatelessWidget {
final TabController tabController;
final  List<DateModel> itemsMode;// Your model

MyHomePage({required this.tabController,required this.itemsMode});

@override
Widget build(BuildContext context) {
return  LocalHeroViews(
      tabController: tabController,
      textDirection: TextDirection.ltr,
      itemCount: itemsMode.length,
      itemsModel:(index) => ItemsModel(
      name: Text(itemsMode[index].name),
      title: Text(itemsMode[index].title),
      subTitle: Text(itemsMode[index].subTitle),
      favoriteIconButton: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      subTitleIcon: const Icon(Icons.location_on_outlined, color: Color(0xFF95979A), size: 10),
      image:  DecorationImage(image: NetworkImage(itemsMode[index].imageUri)),
     ),
   );
  }
 }
```

## Card Loading, Themes, and Image Loading
![Image 1](https://raw.githubusercontent.com/najeebaslan/social_media_file_for_project/refs/heads/main/videos/local_hero_transform_package/loading_page.gif)
### isLoading

The `isLoading` property in `CardStyleMode` determines whether the card should display a loading shimmer effect instead of its normal content. This is useful for indicating loading states while data is being fetched.

**Example:**
```dart
ItemsModel(
  // ... other properties ...
  cardStyleMode: CardStyleMode(
    isLoading: true, // Show shimmer loading effect
  ),
  // ...
)
```

### isDarkMode

The `isDarkMode` property in `CardStyleMode` switches the card's appearance between dark and light themes. It affects background, shimmer, and item colors for better visibility and style consistency.

**Example:**
```dart
ItemsModel(
  // ... other properties ...
  cardStyleMode: CardStyleMode(
    isDarkMode: true, // Use dark theme colors for the card
  ),
  // ...
)
```

You can dynamically set this based on your app's theme:
```dart
final isDarkMode = Theme.of(context).brightness == Brightness.dark;
ItemsModel(
  // ...
  cardStyleMode: CardStyleMode(isDarkMode: isDarkMode),
  // ...
)
```

### loadingImageBuilder

The `loadingImageBuilder` property in `ItemsModel` allows you to customize the widget shown while the card's image is loading. This is especially useful for showing shimmer or placeholder widgets.

**Example:**
```dart
ItemsModel(
  // ... other properties ...
  loadingImageBuilder: (context, child, loadingProgress) {
    return CustomShimmer(isDark: true); // Show shimmer while loading image
  },
  // ...
)
```

**Full Example:**
```dart
ItemsModel(
  name: Text('Location Name'),
  title: Text('Place'),
  subTitle: Text('Subtitle'),
  image: DecorationImage(image: NetworkImage('https://example.com/image.png')),
  favoriteIconButton: Icon(Icons.favorite_border),
  cardStyleMode: CardStyleMode(
    isLoading: false, // Set true to show shimmer
    isDarkMode: Theme.of(context).brightness == Brightness.dark,
  ),
  loadingImageBuilder: (context, child, loadingProgress) {
    return CustomShimmer(isDark: Theme.of(context).brightness == Brightness.dark);
  },
)
``` 

## Customization
You can customize the transition duration and design size as follows:

```dart
LocalHeroViews(
tabController: _controller,
transitionDuration: Duration(milliseconds: 500),
designSize: Size(360, 640),
 itemCount: itemsMode.length,
itemsModel:(index) => ItemsModel(
name: Text(itemsMode[index].name),
title: Text(itemsMode[index].title),
subTitle: Text(itemsMode[index].subTitle),
favoriteIconButton: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
subTitleIcon: const Icon(Icons.location_on_outlined, color: Color(0xFF95979A), size: 10),
image: DecorationImage(image: NetworkImage(itemsMode[index].imageUri)),
),
)
```

# 🎨 Advanced Customization
see example code [here](https://github.com/najeebaslan/local_hero_transform/blob/main/example/lib/local_hero_without_hero_transform.dart)  

## 🤝 Contributing
We welcome contributions! Please follow these steps:

Fork the repository

Create your feature branch (git checkout -b feature/AmazingFeature)

Commit your changes (git commit -m 'Add some AmazingFeature')

Push to the branch (git push origin feature/AmazingFeature)

Open a Pull Request