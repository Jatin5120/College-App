import 'dart:ui';

import 'package:college_app/constants/colors.dart';
import 'package:college_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowImage extends StatelessWidget {
  final String? imageUrl;

  const ShowImage(
    this.imageUrl, {
    Key? key,
  }) : super(key: key);
  final String baseUrl =
      "https://raw.githubusercontent.com/Jatin5120/College-Images/main/";
  @override
  Widget build(BuildContext context) {
    final String url = "$baseUrl$imageUrl";
    return Stack(
      children: [
        imageUrl != null
            ? Positioned.fill(
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              )
            : ImageNotFound(),
        Container(
          height: double.infinity,
          width: double.infinity,
          // color: Theme.of(context).cardColor.withOpacity(0.5),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Center(
              child: imageUrl != null
                  ? Image.network(
                      url,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.image),
                                LinearProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Text(
                      'Image Not Available',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/image_not_found.png',
            fit: BoxFit.cover,
          ),
        ),
        Consumer<CurrentTheme>(
          builder: (context, currentTheme, child) {
            final Color overlayColor =
                currentTheme.currentThemeMode == ThemeMode.dark
                    ? MyColors.darkShadowColor
                    : currentTheme.currentThemeMode == ThemeMode.light
                        ? MyColors.lightForeground
                        : MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? MyColors.darkShadowColor
                            : MyColors.lightForeground;
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: overlayColor.withOpacity(0.5),
            );
          },
        ),
      ],
    );
  }
}
