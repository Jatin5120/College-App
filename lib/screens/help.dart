import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/modals/modals.dart';
import 'package:college_app/utils.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.help),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          final HelpModal helpModal = HelpModal.fromJson(snapShot.data);
          return HelpPage(helpModal: helpModal);
        } else {
          return _BuildLoadingHelp();
        }
      },
    );
  }
}

class _BuildLoadingHelp extends StatelessWidget {
  const _BuildLoadingHelp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MyShimmerEffect(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: size.height / 10),
          ShaderWidget(
            borderRadius: UIConfigurations.appBarBorderRadius,
            aspectRatio: 5 / 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.smallCardBorderRadius,
            aspectRatio: 7 / 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.bgCardBorderRadius,
            aspectRatio: 9 / 5,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.bgCardBorderRadius,
            aspectRatio: 7 / 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.bgCardBorderRadius,
            aspectRatio: 3 / 2,
          ),
        ],
      ),
    );
  }
}

class HelpPage extends StatefulWidget {
  const HelpPage({
    Key? key,
    required this.helpModal,
  }) : super(key: key);

  final HelpModal helpModal;

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late FAQProvider faqProvider;
  late List<String?>? phones;
  late List<String?>? emails;
  late SocialMedia? socialMedia;
  late List<UsefulLinks?>? usefulLinks;
  late List<Faq?>? faqs;

  @override
  void initState() {
    super.initState();
    faqProvider = Provider.of<FAQProvider>(context, listen: false);
    phones = widget.helpModal.phones;
    emails = widget.helpModal.emails;
    socialMedia = widget.helpModal.socialMedia;
    usefulLinks = widget.helpModal.usefulLinks;
    faqs = widget.helpModal.faq;
    faqProvider.setItemCount(faqs!.length);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    final double marginHorizontal = (size.width / 15).roundToDouble();
    final double marginVertical = (size.height / 40).roundToDouble();
    final EdgeInsets margin = UIConfigurations.margin(
      horizontal: marginHorizontal,
      vertical: marginVertical,
    );
    return ListView(
      children: [
        UIConfigurations.spaceTop(size),
        CTAButton(
          padding: padding,
          link: widget.helpModal.website!,
          text: 'Visit Website',
          toolTip: 'Open Official Website',
        ),
        BuildSubHeader(title: 'Contact us at', padding: padding),
        BuildContacts(
          padding: padding,
          address: widget.helpModal.address!,
          phones: phones,
          emails: emails,
          socialMedia: socialMedia,
        ),
        BuildSubHeader(title: 'Useful Links', padding: padding),
        Padding(
          padding: margin,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: padding * 2,
            runSpacing: padding,
            children: usefulLinks!
                .map(
                  (link) => ElevatedButton(
                    onPressed: () => Utils.openLink(url: link!.url!),
                    child: Text(link!.text!),
                  ),
                )
                .toList(),
          ),
        ),
        BuildSubHeader(title: 'FAQs', padding: padding),
        Consumer<FAQProvider>(
          builder: (context, faqProvider, child) {
            return ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: faqs!.length,
              itemBuilder: (context, index) {
                final Faq faq = faqs![index]!;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: UIConfigurations.smallCardBorderRadius,
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: marginHorizontal,
                      vertical: marginVertical / 2),
                  child: Padding(
                    padding: EdgeInsets.all(padding * 2),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              faqProvider.switchExpansion(index: index),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  faq.question!,
                                  style: textTheme.headline6,
                                ),
                              ),
                              Icon(faqProvider.expanded[index]
                                  ? MyIcons.arrow_up
                                  : MyIcons.arrow_down)
                            ],
                          ),
                        ),
                        if (faqProvider.expanded[index])
                          Column(
                            children: [
                              Divider(),
                              Text(
                                'ANS: ${faq.answer!}',
                                style: textTheme.bodyText1,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        UIConfigurations.spaceBottom(size),
      ],
    );
  }
}
