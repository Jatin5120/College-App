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
      child: CustomCard(
        borderRadius: UIConfigurations.bgCardBorderRadius,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: UIConfigurations.bgCardBorderRadius,
                child: PageView.builder(
                  itemCount: item['images'].length,
                  itemBuilder: (context, index) {
                    return ShowImage(item['images'][index]);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: padding),
                  Text(
                    item['description'] ?? '',
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
