# LocalHeroTransform ![](https://img.shields.io/badge/build-0.0.3-brightgreen)   [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
local hero transform is a powerful Flutter package designed to simplify the creation of seamless transitions between items in grid and list views. By leveraging local hero animations, this package enhances the visual appeal of your app while providing a smooth user experience.

## Screen Shoots
| ![Image 1](https://github.com/najeebaslan/social_media_file_for_project/blob/main/videos/local_hero_transform_package/base_local_hero.gif?raw=true) | ![Image 2](https://github.com/najeebaslan/social_media_file_for_project/blob/main/videos/local_hero_transform_package/custom_local_hero.gif?raw=true) | ![Image 3](https://github.com/najeebaslan/social_media_file_for_project/blob/main/videos/local_hero_transform_package/local_hero_without_hero_transform.gif?raw=true) |
|:--------------------------------------------:|:--------------------------------------------:|:--------------------------------------------:|
| ** source code [here](https://github.com/najeebaslan/local_hero_transform/blob/main/example/lib/main.dart)**                                  | ** source code [here](https://github.com/najeebaslan/local_hero_transform/blob/main/example/lib/custom_local_hero.dart)**                                  | ** source code [here](https://github.com/najeebaslan/local_hero_transform/blob/main/example/lib/local_hero_without_hero_transform.dart)**                                  |

## Platform Support
| Android | iOS | MacOS  | Web | Linux | Windows |
| :-----: | :-: | :---:  | :-: | :---: | :-----: |
|   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️  |

## ✨Features
- Easy Integration: Effortlessly integrate local hero animations in your Flutter applications with minimal setup.
- Dynamic Page Transitions: Create engaging transitions between items in both grid and list layouts, enhancing user interaction.
- Customizable Animation And Widgets: Control the duration and design size and position widgets of transitions to fit the overall style of your app.
- Nested Navigation: Utilize a nested Navigator to maintain the general navigation state of your app while providing fluid page switching.
- Responsive Design: Built with responsiveness in mind, ensuring your animations look great on all screen sizes in mobiles apps.

## Installation

Add `local_hero_transform` to your `pubspec.yaml` file:

```yaml
dependencies:
local_hero_transform: ^0.0.3
```
## Usage

Example
Here's a basic example of how to implement Local Hero Transform in your Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:local_hero_transform/local_hero_transform.dart';

class MyHomePage extends StatelessWidget {
final TabController _controller;

MyHomePage(this._controller);

@override
Widget build(BuildContext context) {
return LocalHero(
controller: _controller,
pages: [/* Your pages with hero tags here */],
);
}
}
```

### ⚠️ Important Notes
This package does not support full responsiveness on web and desktop platforms due to the wide variety of use cases.
As such, the package cannot manage all scenarios effectively. However,
it does provide the flexibility to customize any widget with the animations of your choice.
## Customization
You can customize the transition duration and design size as follows:

```dart
LocalHero(
controller: _controller,
transitionDuration: Duration(milliseconds: 500),
designSize: Size(360, 640),
pages: [
/* Your pages with hero tags here */
CardGridView(),CardGridView(),
],
)
```

- Customization widgets in ` BaseHeroCardOptionalParameters `
```dart
CardGridView(
index: index,// Unique tag for the hero animation based on the index.
textDirection: textDirection,
cardModel: HeroCardModel(
name: locations[index].name,
title: locations[index].place,
imageUrl: locations[index].imageUrl,
subTitle: locations[index].place,
),
optionalParameters:BaseHeroCardOptionalParameters(
onPressedFavoriteIcon: () => log('favorite'),
favoriteIconButton: ,
imageWidget: ,
nameWidget: ,
subtitleWidget: ,
titleWidget: ,
),
);
```
- Base CardListView
```dart
CardListView(
index: index,// Unique tag for the hero animation based on the index.
textDirection: textDirection,
cardModel: HeroCardModel(
name: locations[index].name,
title: locations[index].place,
imageUrl: locations[index].imageUrl,
subTitle: locations[index].place,
),
optionalParameters:BaseHeroCardOptionalParameters(
onPressedFavoriteIcon: () => log('favorite'),
favoriteIconButton: ,
imageWidget: ,
nameWidget: ,
subtitleWidget: ,
titleWidget: ,
),
);
```

## Additional information
This package supports customizable UI for both web and desktop with mobile applications. You can explore its capabilities by testing the provided example
[here](https://github.com/najeebaslan/local_hero_transform/blob/main/example/lib/custom_local_hero.dart)  

## Contributions
Contributions are welcome! If you have suggestions or improvements, feel free to open an issue or pull request.
