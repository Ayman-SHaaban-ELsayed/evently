import 'package:final_project/firebase_utils.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/model/event.dart';
import 'package:final_project/ui/home/tabs/widgets/event_item.dart';
import 'package:final_project/ui/home/tabs/widgets/main_error_widget.dart';
import 'package:final_project/ui/home/tabs/widgets/main_loading_widget.dart';
import 'package:final_project/ui/widgets/custom_text_field.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  List<Event> favouriteEventList = [];
  Stream<List<Event>>? favouriteStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteStream = FirebaseUtils.getAllFavouriteEvents();
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04, vertical: .02),
        child: Column(
          spacing: height * .02,
          children: [
            CustomTextField(
              borderColor: Theme.of(context).dividerColor,
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              style: Theme.of(context).textTheme.bodySmall,
              suffixIcon: Icon(
                Icons.search,
                size: 25,
                color: Theme.of(context).cardColor,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Event>>(
                stream: favouriteStream,
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
                          .no_favourite_event_found,
                    );
                  } else {
                    //todo data
                    favouriteEventList = snapshot.data!;

                    return favouriteEventList.isEmpty
                        ? MainErrorWidget(
                            errorMessage: AppLocalizations.of(context)!
                                .no_favourite_event_found,
                          )
                        : ListView.separated(
                            padding: EdgeInsets.only(bottom: height * .08),
                            itemBuilder: (context, index) {
                              return EventItem(
                                event: favouriteEventList[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: height * .02);
                            },
                            itemCount: favouriteEventList.length,
                          );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
