import 'package:final_project/firebase_utils.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/model/event.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/ui/add_event/widget/custom_date_time_widget.dart';
import 'package:final_project/ui/home/tabs/widgets/tab_item.dart';
import 'package:final_project/ui/widgets/custom_elevated_button.dart';
import 'package:final_project/ui/widgets/custom_text_field.dart';
import 'package:final_project/utils/app_assets.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/app_routes.dart';
import 'package:final_project/utils/app_styles.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:final_project/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  List<String> eventImageDarkList = [
    AppAssets.sportDarkImage,
    AppAssets.birthdayDarkImage,
    AppAssets.meetingDarkImage,
    AppAssets.bookClubDarkImage,
    AppAssets.exhibitionDarkImage,
  ];

  List<String> eventImageLightList = [
    AppAssets.sportLightImage,
    AppAssets.birthdayLightImage,
    AppAssets.meetingLightImage,
    AppAssets.bookClubLightImage,
    AppAssets.exhibitionLightImage,
  ];

  List<String> eventNameList = [];

  var formKey = GlobalKey<FormState>();

  late Event originalEvent;
  bool isInitialized = false;

  int selectedIndex = 0;
  String title = '';
  String description = '';
  DateTime? selectedDate;
  String formateDate = '';
  TimeOfDay? selectedTime;
  String formateTime = '';
  String selectedEventName = '';
  String selectedEventImage = '';

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      originalEvent = ModalRoute.of(context)!.settings.arguments as Event;

      titleController.text = originalEvent.eventTitle;
      title = originalEvent.eventTitle;

      descriptionController.text = originalEvent.eventDescription;
      description = originalEvent.eventDescription;

      selectedIndex = originalEvent.eventCategoryIndex;
      selectedDate = originalEvent.eventDate;
      selectedTime = TimeOfDay.fromDateTime(originalEvent.eventDate);

      formateDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    eventNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];

    selectedEventName = eventNameList[selectedIndex];
    selectedEventImage = themeProvider.isDark()
        ? eventImageDarkList[selectedIndex]
        : eventImageLightList[selectedIndex];

    var height = context.height;
    var width = context.width;

     if (selectedTime != null) {
      formateTime = selectedTime!.format(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.edit_event,
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .04,
            vertical: height * .01,
          ),
          child: Form(
            key: formKey,
            child: Column(
              spacing: height * .02,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      image: AssetImage(selectedEventImage),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: TabItem(
                          isSelected: selectedIndex == index,
                          eventName: eventNameList[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * .02);
                    },
                    itemCount: eventNameList.length,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextField(
                  filled: true,
                  controller: titleController,
                  fillcolor: Theme.of(context).highlightColor,
                  hintText: AppLocalizations.of(context)!.event_title,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  onChanged: (text) {
                    title = text;
                  },
                  validator: (p0) {
                    if (p0 == null || p0.trim().isEmpty) {
                      return AppLocalizations.of(context)!.please_title;
                    }
                    return null;
                  },
                ),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextField(
                  filled: true,
                  controller: descriptionController,
                  fillcolor: Theme.of(context).highlightColor,
                  hintText: AppLocalizations.of(context)!.event_description,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 3,
                  onChanged: (text) {
                    description = text;
                  },
                  validator: (p0) {
                    if (p0 == null || p0.trim().isEmpty) {
                      return AppLocalizations.of(context)!.please_description;
                    }
                    return null;
                  },
                ),
                Column(
                  children: [
                    CustomDateTimeWidget(
                      icon: Icon(
                        Icons.date_range_outlined,
                        size: 25,
                        color: Theme.of(context).cardColor,
                      ),
                      eventDateOrTime: AppLocalizations.of(context)!.event_date,
                      onPressed: chooseDate,
                      chooseDateOrTime: selectedDate == null
                          ? AppLocalizations.of(context)!.choose_date
                          : formateDate,
                    ),
                    CustomDateTimeWidget(
                      icon: Icon(
                        Icons.timer_outlined,
                        size: 25,
                        color: Theme.of(context).cardColor,
                      ),
                      eventDateOrTime: AppLocalizations.of(context)!.event_time,
                      onPressed: chooseTime,
                      chooseDateOrTime: selectedTime == null
                          ? AppLocalizations.of(context)!.choose_time
                          : formateTime,
                    ),
                  ],
                ),
                CustomElevatedButton(
                  onPressed: updateEvent,
                  child: Text(
                    AppLocalizations.of(context)!.update_event,
                    style: AppStyles.medium20White,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: selectedDate ?? DateTime.now(),
    );
    if (chooseDate != null) {
      selectedDate = chooseDate;
      formateDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      setState(() {});
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (chooseTime != null) {
      selectedTime = chooseTime;
      formateTime = selectedTime!.format(context);
      setState(() {});
    }
  }

  void updateEvent() {
    if (formKey.currentState?.validate() == true) {
      Event eventToUpdate = Event(
        id: originalEvent.id,
        isFavorite: originalEvent.isFavorite,
        eventImage: selectedEventImage,
        eventName: selectedEventName,
        eventTitle: title,
        eventCategoryIndex: selectedIndex,
        eventDescription: description,
        eventDate: DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        ),
      );

      FirebaseUtils.updateEventInFirestore(eventToUpdate)
          .then((value) {
            ToastUtils.toastMgs(
              msg: AppLocalizations.of(context)!.event_updated_successfully,
              backgroundColor: Theme.of(context).cardColor,
              textColor: AppColors.whiteColor,
            );
             Navigator.of(context)
                .popUntil(ModalRoute.withName(AppRoutes.homeRouteName));
          })
          .catchError((onError) {
            ToastUtils.toastMgs(
              msg: onError.toString(),
              backgroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor,
            );
          });
    }
  }
}
