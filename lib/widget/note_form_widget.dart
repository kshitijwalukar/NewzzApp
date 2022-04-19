import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final String? country;
  final String? language;
  final String? arrange;
  final String? timeranges;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedCountry;
  final ValueChanged<String> onChangedLanguage;
  final ValueChanged<String> onChangedArrange;
  final ValueChanged<String> onChangedtimeranges;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    this.country = '',
    this.language = '',
    this.arrange = '',
    this.timeranges = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedCountry,
    required this.onChangedLanguage,
    required this.onChangedArrange,
    required this.onChangedtimeranges,
  }) : super(key: key);


  static const countries = {
    '': 'All',
    'ae': 'United Arab Emirates',
    'ar': 'Argentina',
    'at': 'Austria',
    'au': 'Australia',
    'be': 'Belgium',
    'bg': 'Bulgaria',
    'br': 'Brazil',
    'ca': 'Canada',
    'ch': 'Switzerland',
    'cn': 'China',
    'cz': 'Czechia',
    'de': 'Germany',
    'eg': 'Egypt',
    'fr': 'France',
    'gb': 'United Kingdom',
    'gr': 'Greece',
    'hk': 'Hong Kong',
    'hu': 'Hungary',
    'id': 'Indonesia',
    'ie': 'Ireland',
    'il': 'Israel',
    'in': 'India',
    'it': 'Italy',
    'jp': 'Japan',
    'kr': 'South Korea',
    'lt': 'Lithuania',
    'lv': 'Latvia',
    'ma': 'Morocco',
    'mx': 'Mexico',
    'my': 'Malaysia',
    'ng': 'Nigeria',
    'nl': 'Netherlands',
    'no': 'Norway',
    'nz': 'New Zealand',
    'ph': 'Philippines',
    'pl': 'Poland',
    'pt': 'Portugal',
    'ro': 'Romania',
    'rs': 'Serbia',
    'ru': 'Russia',
    'sa': 'South Africa',
    'se': 'Sweden',
    'sg': 'Singapore',
    'si': 'Slovenia',
    'sk': 'Slovakia',
    'th': 'Thailand',
    'tr': 'Turkey',
    'tw': 'Taiwan',
    'ua': 'Ukraine',
    'us': 'United States',
    've': 'Venezuela',
    'za': 'Zambia'
  };


  static const languages = {
    '': 'Default',
    'ar': 'Arabic',
    'de': 'Deutsch',
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'he': 'Hebrew',
    'it': 'Italian',
    'nl': 'Dutch',
    'no': 'Norwegian',
    'pt': 'Portuguese',
    'ru': 'Russian',
    'se': 'Northern Sami',
    'ud': 'Urdu',
    'zh': 'Chinese'
  };

  static const arranging = {
    '': 'Default',
    'relevancy' : 'Relevancy',
    'popularity': 'popularity',
    'publishedAt': 'publishedAt'
  };

  static const timevalues = {
    '': 'Default',
    'Last30days' : 'Last 30 days',
    'Last15days': 'Last 15 days',
    'Last10days': 'Last 10 days',
    'Last1Week': 'Last 1 Week',
    'Yesterday': 'Yesterday'
  };

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'CREATE CUSTOM NEWS',
            style: TextStyle(
                color: Colors.green,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
            ),
          ),
          Divider(),
          SizedBox(height: 8),
          buildTitle(),
          SizedBox(height: 8),
          buildDescription(),
          SizedBox(height: 8),
          Row(
            children: [
              Text('   '),
              Icon(Icons.flag, color: Colors.green, size: 25),
              Text(
                '  Country:   ',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600
                ),
              ),
              DropdownButton(
                value: country,
                elevation: 8,
                style: const TextStyle(color: Colors.green, fontSize: 20, fontStyle: FontStyle.italic),
                underline: Container(
                  height: 2,
                  color: Colors.green,
                ),
                onChanged: (country) => onChangedCountry(country.toString()),
                items: countries.entries
                    .map<DropdownMenuItem<String>>(
                        (MapEntry<String, String> e) => DropdownMenuItem<String>(
                      value: e.key,
                      child: Text(e.value),
                    ))
                    .toList(),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text('   '),
              Icon(Icons.language,color: Colors.green, size: 25),
              Text(
                '  Language:   ',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600
                ),
              ),
              DropdownButton(
                value: language,
                elevation: 8,
                style: const TextStyle(color: Colors.green, fontSize: 20, fontStyle: FontStyle.italic),
                underline: Container(
                  height: 2,
                  color: Colors.green,
                ),
                onChanged: (language) => onChangedLanguage(language.toString()),
                items: languages.entries
                    .map<DropdownMenuItem<String>>(
                        (MapEntry<String, String> e) => DropdownMenuItem<String>(
                      value: e.key,
                      child: Text(e.value),
                    ))
                    .toList(),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text('   '),
              Icon(Icons.sort, color: Colors.green, size: 25),
              Text(
                '  Sort By:   ',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600
                ),
              ),
              DropdownButton(
                value: arrange,
                elevation: 8,
                style: const TextStyle(color: Colors.green, fontSize: 20, fontStyle: FontStyle.italic),
                underline: Container(
                  height: 2,
                  color: Colors.green,
                ),
                onChanged: (arrange) => onChangedArrange(arrange.toString()),
                items: arranging.entries
                    .map<DropdownMenuItem<String>>(
                        (MapEntry<String, String> e) => DropdownMenuItem<String>(
                      value: e.key,
                      child: Text(e.value),
                    ))
                    .toList(),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text('   '),
              Icon(Icons.calendar_month, color: Colors.green, size: 25),
              Text(
                '  Time Range:  ',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600
                ),
              ),
              DropdownButton(
                value: timeranges,
                elevation: 8,
                style: const TextStyle(color: Colors.green, fontSize: 20, fontStyle: FontStyle.italic),
                underline: Container(
                  height: 2,
                  color: Colors.green,
                ),
                onChanged: (timeranges) => onChangedtimeranges(timeranges.toString()),
                items: timevalues.entries
                    .map<DropdownMenuItem<String>>(
                        (MapEntry<String, String> e) => DropdownMenuItem<String>(
                      value: e.key,
                      child: Text(e.value),
                    ))
                    .toList(),
              )
            ],
          ),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    cursorColor: Colors.green,
    style: TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'News Title',
      prefixIcon: Icon(Icons.text_fields, color: Colors.green, size: 30),
      hintStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedTitle,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 1,
    initialValue: description,
    cursorColor: Colors.green,
    style: TextStyle(color: Colors.green, fontSize: 20),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Description...',
      prefixIcon: Icon(Icons.description, color: Colors.green, size: 25),
      hintStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty'
        : null,
    onChanged: onChangedDescription,
  );

}