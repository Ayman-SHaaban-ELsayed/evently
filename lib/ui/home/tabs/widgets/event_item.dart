import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/utils/app_assets.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      height: height * .22,
      padding: EdgeInsets.symmetric(
        horizontal: width * .02,
        vertical: height * .01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2, color: Theme.of(context).dividerColor),
        image: DecorationImage(
         fit: BoxFit.fill,
          image: AssetImage(
            themeProvider.isDark()
                ? AppAssets.birthdayDarkImage
                : AppAssets.birthdayLightImage,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .005,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Text(
              '21 jan',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * .02,
              //vertical: height * .005,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Align(
              alignment: AlignmentGeometry.bottomStart,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'This is a birthday Party',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  IconButton(
                    onPressed: () {
                      //todo add to favourite
                    },
                    icon: Icon(
                      Icons.favorite_outline_outlined,
                      size: 25,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
