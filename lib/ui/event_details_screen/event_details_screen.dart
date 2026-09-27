import 'package:final_project/firebase_utils.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/model/event.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/app_routes.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:final_project/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    var event = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .02,
            vertical: height * .01,
          ),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).highlightColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
                side: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: themeProvider.isDark()
                  ? AppColors.whiteColor
                  : AppColors.mainLightColor,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // الانتقال لشاشة التعديل وتمرير الحدث الحالي
              Navigator.of(context)
                  .pushNamed(AppRoutes.editEventScreen, arguments: event);
            },
            icon: Icon(
              Icons.edit_outlined,
              color: themeProvider.isDark()
                  ? AppColors.whiteColor
                  : AppColors.mainLightColor,
            ),
          ),
          IconButton(
            onPressed: () {
              FirebaseUtils.deleteEvent(event.id)
                  .then((value) {
                    ToastUtils.toastMgs(
                      msg: 'Event deleted successfully',
                      backgroundColor: AppColors.greenColor,
                      textColor: AppColors.whiteColor,
                    );
                    Navigator.pop(context);
                  })
                  .catchError((error) {
                    ToastUtils.toastMgs(
                      msg: error.toString(),
                      backgroundColor: AppColors.redColor,
                      textColor: AppColors.whiteColor,
                    );
                  });
            },
            icon: const Icon(
              Icons.delete_outline_outlined,
              color: AppColors.redColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .04,
            vertical: height * .01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: height * .02,
            children: [
              Container(
                height: height * .25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).dividerColor,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(event.eventImage),
                  ),
                ),
              ),
              Text(
                event.eventTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .04,
                  vertical: height * .02,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    SizedBox(width: width * .04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy').format(event.eventDate),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          DateFormat('hh:mm a').format(event.eventDate),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * .04,
                  vertical: height * .02,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: Text(
                  event.eventDescription,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
