import 'package:final_project/firebase_utils.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/model/event.dart';
import 'package:final_project/providers/app_language_provider.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:final_project/ui/home/tabs/widgets/event_item.dart';
import 'package:final_project/ui/home/tabs/widgets/main_error_widget.dart';
import 'package:final_project/ui/home/tabs/widgets/main_loading_widget.dart';
import 'package:final_project/ui/home/tabs/widgets/tab_item.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/app_styles.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  List<Event> eventList = [];
  Stream<List<Event>>? eventStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllEvent();
    eventStream = FirebaseUtils.getAllEvent();
  }

  void updateStream(int index) {
    selectedIndex = index;
    if (selectedIndex == 0) {
      eventStream = FirebaseUtils.getAllEvent();
    } else {
      eventStream = FirebaseUtils.getFilterEvents(
        selectedIndex: selectedIndex - 1,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var userProvider=Provider.of<UserProvider>(context );
     var height = context.height;
    var width = context.width;
    List<String> eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: DefaultTabController(
          length: eventNameList.length,
          child: Column(
            spacing: height * .02,
            children: [
              Row(
                spacing: width * .02,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome_back,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        userProvider.currentUser!.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    themeProvider.isDark()
                        ? Icons.dark_mode_outlined
                        : Icons.wb_sunny_outlined,
                    size: 25,
                    color: Theme.of(context).cardColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .02,
                      vertical: height * .006,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Text(
                      languageProvider.appLanguage.toUpperCase(),
                      style: AppStyles.semi14White,
                    ),
                  ),
                ],
              ),
              TabBar(
                isScrollable: true,
                onTap: (index) {
                  updateStream(index);
                },
                dividerColor: AppColors.transparentColor,
                indicatorColor: AppColors.transparentColor,
                labelPadding: EdgeInsets.symmetric(horizontal: width * .02),
                tabAlignment: TabAlignment.start,
                tabs: eventNameList.map((eventName) {
                  return TabItem(
                    isSelected:
                        selectedIndex == eventNameList.indexOf(eventName),
                    eventName: eventName,
                  );
                }).toList(),
              ),
              Expanded(
                child: StreamBuilder<List<Event>>(
                  stream: eventStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //todo loading
                      return MainLoadingWidget();
                    } else if (snapshot.hasError) {
                      return MainErrorWidget(
                        errorMessage: ' error: ${snapshot.error.toString()}',
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return MainErrorWidget(
                        errorMessage: AppLocalizations.of(context)!
                            .no_event_found,
                      );
                    } else {
                      //todo data
                      eventList = snapshot.data!;

                      return eventList.isEmpty
                          ? MainErrorWidget(
                              errorMessage: AppLocalizations.of(context)!
                                  .no_event_found,
                            )
                          : ListView.separated(
                             padding: EdgeInsets.only(bottom:  height * .08), itemBuilder: (context, index) {
                                return EventItem(event: eventList[index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: height * .02);
                              },
                              itemCount: eventList.length,
                            );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
