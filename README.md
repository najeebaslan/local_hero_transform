# LocalHeroTransform ![](https://img.shields.io/badge/build-1.0.2-brightgreen)   [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
local hero transform is A Flutter package for creating seamless hero transitions between grid and list views with enhanced customization and performance for optimize user experience .


## Screen Shoots
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
local_hero_transform: ^1.0.2
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

### ⚠️ Important Notes
This package does not support full responsiveness on web and desktop platforms due to the wide variety of use cases.
As such, the package cannot manage all scenarios effectively. However,
it does provide the flexibility to customize any widget with the animations of your choice.
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

# Frequently Asked Questions❓
Q: How do I handle different layouts for different screen sizes?
A: Use the ScreenUtilInit Package to define responsive layouts:


```dart 
   ScreenUtilInit(
   designSize:
   widget.designSize ?? const Size(428, 926), // Set design size for responsive layout.
   minTextAdapt: true, // Allow text to adapt to screen size.
   enableScaleText: () => false, // Disable text scaling.
   splitScreenMode: true, // Enable split screen mode for responsive design.
   builder: (context, child) {
      return MaterialApp();
  });


  Container(height:100.h,width:200.w,),
  Text("example".sp),
  BorderRadius.circular(24.0.r),


```
# 🎨 Advanced Customization
see example [here](https://github.com/najeebaslan/local_hero_transform/blob/main/example/lib/local_hero_without_hero_transform.dart)  

## 🤝 Contributing
We welcome contributions! Please follow these steps:

Fork the repository

Create your feature branch (git checkout -b feature/AmazingFeature)

Commit your changes (git commit -m 'Add some AmazingFeature')

Push to the branch (git push origin feature/AmazingFeature)

Open a Pull Request