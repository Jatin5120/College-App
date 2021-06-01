import 'package:college_app/constants/constants.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BuildSwipableImageCard extends StatelessWidget {
  const BuildSwipableImageCard({
    Key? key,
    required this.item,
    required this.padding,
  }) : super(key: key);

  final Map<String, dynamic> item;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: UIConfigurations.bgCardBorderRadius,
        ),
        child: ClipRRect(
          borderRadius: UIConfigurations.bgCardBorderRadius,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: UIConfigurations.bgCardBorderRadius,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: item['images'].length,
                    itemBuilder: (context, index) {
                      return ShowImage(item['images'][index]);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding * 2,
                  vertical: padding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['title'] ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: padding),
                    Text(
                      item['description'] ?? '',
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
