import 'dart:ui';

import 'package:flutter/material.dart';

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
            : Center(
                child: Icon(Icons.not_interested_outlined),
              ),
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
                  : Icon(Icons.not_interested_rounded),
            ),
          ),
        ),
      ],
    );
  }
}
