import 'package:flutter/material.dart';
import 'package:funkies_flutter/controllers/EventController.dart';
import 'package:funkies_flutter/models/event.dart';
import 'package:funkies_flutter/pages/event_page.dart';
import 'package:funkies_flutter/widgets/text.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {

  List<Event> allEvents = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final events = await getEvents();

      setState(() {
        allEvents = events;
        _isLoading = false;
      });
      print("====>>>>Successfully loaded ${events.length} events");

    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load events: $e';
        _isLoading = false;
      });

      print("=======>>>>>>Error loading events: $e");
    }
  }

  List<Event> searchEvents(String query) {
    if (query.isEmpty) return [];

    final lowerQuery = query.toLowerCase().trim();

    return allEvents.where((event) {
      return [
        event.name,
        event.category,
        event.county,
        event.level,
        event.subject,
        event.participation_mode,
        event.sponsors,
        event.venue,
        event.hosts,
      ].any(
        (field) => field != null && field.toLowerCase().contains(lowerQuery),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(text: _errorMessage, textVariant: "normal"),
            ElevatedButton(onPressed: _fetchEvents, child: const Text('Retry')),
          ],
        ),
      );
    }

    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          hintText: "Search events",
          hintStyle: WidgetStateProperty.all(
            TextStyle(color: Colors.grey)
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
                style: BorderStyle.solid
              ),
            )
          ),
          leading: const Icon(Icons.search),
          trailing: [
              IconButton(onPressed: (){
                controller.clear();
              }, icon: Icon(Icons.clear)),
          ],
          onTap: (){
            controller.openView();
          },
          onChanged: (_){
            controller.openView();
          },
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller){
        final query = controller.text;
        final results = searchEvents(query);

        print("=====>>>>> Search query: $query");
        print("======>>>>> Filtered events: ${results.length}");

        if(results.isEmpty){
          return [
            Padding(padding: EdgeInsets.all(16),
              child: Center(
                child: TextWidget(text: "No events found matching '${controller.text}'", textVariant: "normal"),
              ),
            )
          ];
        }

        return results.map((event) => _buildEventTile(context, event, controller)).toList();
      },
    );
  }

  Widget _buildEventTile(BuildContext context, Event event, SearchController controller) {
    return ListTile(
      leading:
          event.posterUrl != null
              ? Image.network(
                event.posterUrl!,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
                errorBuilder:
                    (context, error, stackTrace) =>
                        Icon(Icons.image_not_supported),
              )
              : Icon(Icons.event),
      title: TextWidget(text: event.name!, textVariant: "normal"),
      subtitle: TextWidget(
        text: event.startDate?.toString() ?? 'No date',
        textVariant: "light",
      ),
      onTap: () {
        controller.closeView(event.name);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventPage(event: event)),
        );
      },
    );
  }
}
