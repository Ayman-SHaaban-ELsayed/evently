import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/ui/home/tabs/widgets/event_item.dart';
import 'package:final_project/ui/widgets/custom_text_field.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

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
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return EventItem();
                },
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
