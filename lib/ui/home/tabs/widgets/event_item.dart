import 'package:final_project/firebase_utils.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/model/event.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:final_project/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      height: height * .30,
      padding: EdgeInsets.symmetric(
        horizontal: width * .02,
        vertical: height * .01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2, color: Theme.of(context).dividerColor),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(event.eventImage),
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
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Text(
              //todo add date
              DateFormat('dd MMM').format(event.eventDate).toString(),
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
                  //todo add title
                  Text(
                    event.eventTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  IconButton(
                    onPressed: () {
                      String successMsg = AppLocalizations.of(context)!
                          .event_updated_successfully;
                      //todo add to favourite
                      FirebaseUtils.updateIsFavourite(event)
                          .then((onValue) {
                            ToastUtils.toastMgs(
                              msg: successMsg,
                              backgroundColor: AppColors.greenColor,
                              textColor: AppColors.whiteColor,
                            );
                          })
                          .catchError((onError) {
                            ToastUtils.toastMgs(
                              msg: onError.toString(),
                              backgroundColor: AppColors.redColor,
                              textColor: AppColors.whiteColor,
                            );
                          });
                    },
                    icon: Icon(event.isFavorite?
                        Icons.favorite
                     : Icons.favorite_outline_outlined,
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
