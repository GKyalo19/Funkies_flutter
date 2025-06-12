import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funkies_flutter/controllers/EventController.dart';
import 'package:funkies_flutter/models/event.dart';
import 'package:funkies_flutter/router/navigator.dart';
import 'package:funkies_flutter/widgets/input.dart';
import 'package:funkies_flutter/widgets/text.dart';
import '../utility/drop_down_options.dart' as drop_down;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late bool isLoading = false;
  late Future<Event> event;
  late Future<Event> createdEvent;

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventVenueController = TextEditingController();
  final TextEditingController _eventCountyController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final TextEditingController _eventhostController = TextEditingController();
  final TextEditingController _eventCapacityController =
      TextEditingController();
  final TextEditingController _eventLinkController = TextEditingController();
  final TextEditingController _eventSponsorsController =
      TextEditingController();
  final TextEditingController _eventFeeController = TextEditingController();
  final TextEditingController _eventContactController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? _selectedPlatform;
  String? _selectedEventClass;
  String? _selectedLevel;
  String? _selectedNationalCategory;
  String? _selectedInternationalCategory;
  String? _selectedAcademicSubject;
  String? _selectedCurrency;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  File? _selectedImage;

  Future<void> _pickImage() async {
    print("======>>>>> Starting the _pickImage function");
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Dancers3.png"),
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextWidget(text: "Create Event", textVariant: "boldTitle"),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextWidget(
                        text: "Upload event poster",
                        textVariant: "normal",
                        textAlign: TextAlign.left,
                      ),
                      ImagePickerWidget(
                        diameter: 300,
                        initialImage: "assets/images/pastelBackground.jpg",
                        shape: ImagePickerWidgetShape.square,
                        isEditable: true,
                        borderRadius: Radius.circular(10),
                        fit: BoxFit.cover,
                        onChange: (File file){
                          _pickImage();
                        },
                      ),
                      
                      SizedBox(height: 20),
      
                      TextFormFieldWidget(
                        obscureText: false,
                        textController: _eventNameController,
                        hintText: "Name of event",
                        keyboardType: TextInputType.name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
      
                      TextFormFieldWidget(
                        obscureText: false,
                        textController: _eventhostController,
                        hintText: "Event Host",
                        keyboardType: TextInputType.name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
      
                      TextFormFieldWidget(
                        obscureText: false,
                        textController: _eventDescriptionController,
                        keyboardType: TextInputType.multiline,
                        hintText: "Description of event",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
      
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.none),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: CupertinoButton(
                          color: Colors.black,
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder:
                                  (BuildContext context) => Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 250,
                                      child: CupertinoDatePicker(
                                        backgroundColor: Colors.white,
                                        onDateTimeChanged: (DateTime newTime) {
                                          setState(() {
                                            _selectedStartDate = newTime;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: TextWidget(
                            text:
                                _selectedStartDate == null
                                    ? "Start date"
                                    : DateFormat(
                                      'EEEE, MMMM d, yyyy - h:mm a',
                                    ).format(_selectedStartDate!),
                            textVariant: "normal",
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
      
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.none),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: CupertinoButton(
                          color: Colors.black,
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder:
                                  (BuildContext context) => Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 250,
                                      child: CupertinoDatePicker(
                                        backgroundColor: Colors.white,
                                        onDateTimeChanged: (DateTime newTime) {
                                          setState(() {
                                            _selectedEndDate = newTime;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: TextWidget(
                            text:
                                _selectedEndDate == null
                                    ? "End date"
                                    : DateFormat(
                                      'EEEE, MMMM d, yyyy - h:mm a',
                                    ).format(_selectedEndDate!),
                            textVariant: "normal",
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
      
                      DropdownButtonFormField(  
                        decoration: const InputDecoration(
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Event platform",
                        ),
                        value: _selectedPlatform,
                        items:
                            drop_down.platform.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedPlatform = value.toString();
                          });
                        },
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return "Please select the event platform";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
      
                      _selectedPlatform == "Physical"
                          ? Column(
                            children: [
                              TextFormFieldWidget(
                                obscureText: false,
                                textController: _eventVenueController,
                                hintText: "Event Venue",
                                keyboardType: TextInputType.name,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "* required";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormFieldWidget(
                                obscureText: false,
                                textController: _eventCountyController,
                                hintText: "County where the event will be",
                                keyboardType: TextInputType.name,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "* required";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )
                          : TextFormFieldWidget(
                            obscureText: false,
                            textController: _eventLinkController,
                            hintText: "Event Link",
                            keyboardType: TextInputType.url,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "* required";
                              }
                              return null;
                            },
                          ),
      
                      SizedBox(height: 10),
      
                      DropdownButtonFormFieldWidget(
                        hintText: "Event class",
                        value: _selectedEventClass,
                        items:
                            drop_down.eventClass.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedEventClass = value.toString();
                          });
                        },
                        validationText: "Please select the event class",
                      ),
                      SizedBox(height: 10),
      
                      DropdownButtonFormFieldWidget(
                        hintText: "Event level",
                        value: _selectedLevel,
                        items:
                            drop_down.level.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedLevel = value.toString();
                          });
                        },
                        validationText: "Please select the event level",
                      ),
                      SizedBox(height: 10),
      
                      Column(
                        children: <Widget>[
                          _selectedLevel == "National"
                              ? DropdownButtonFormFieldWidget(
                                hintText: "Event category",
                                value: _selectedNationalCategory,
                                items:
                                    drop_down.nationalCategories.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedNationalCategory = value.toString();
                                  });
                                },
                                validationText:
                                    "Please select the event category",
                              )
                              : DropdownButtonFormFieldWidget(
                                hintText: "Event category",
                                value: _selectedInternationalCategory,
                                items:
                                    drop_down.internationalCategories.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedInternationalCategory =
                                        value.toString();
                                  });
                                },
                                validationText:
                                    "Please select the event category",
                              ),
                        ],
                      ),
      
                      SizedBox(height: 10),
      
                      Column(
                        children: <Widget>[
                          if (_selectedNationalCategory == "Academic" &&
                              _selectedLevel == "National")
                            DropdownButtonFormFieldWidget(
                              hintText: "Event subject",
                              value: _selectedAcademicSubject,
                              items:
                                  drop_down.academicSubjects.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedAcademicSubject = value.toString();
                                });
                              },
                              validationText: "Please select the event subject",
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
      
                      TextFormFieldWidget(
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        textController: _eventCapacityController,
                        hintText: "Event Capacity",
                        inputFormat: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
      
                      TextFormFieldWidget(
                        obscureText: false,
                        textController: _eventSponsorsController,
                        hintText:
                            "Event Sponsors (separate using commas if multiple)",
                        keyboardType: TextInputType.name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
      
                      TextFormFieldWidget(
                        obscureText: false,
                        textController: _eventContactController,
                        hintText:
                            "Phone Contact",
                        keyboardType: TextInputType.phone,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
      
                      TextFormFieldWidget(
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        textController: _eventFeeController,
                        hintText: "Registration Fee",
                        inputFormat: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
      
                      DropdownButtonFormFieldWidget(
                        hintText: "Currency",
                        value: _selectedCurrency,
                        items:
                            drop_down.currency.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCurrency = value.toString();
                          });
                        },
                        validationText: "*required",
                      ),
                      SizedBox(height: 30),
      
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            maximumSize: Size(250, 50),
                            minimumSize: Size(150, 50),
                          ),
                          child: TextWidget(
                            text: "Create Event",
                            textVariant: "normalTitle",
                          ),
                          onPressed: () async {
                            print("=======>>>>>>>>>> Starting Event Creation");
      
                            //Validate form data
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            } else {
                              return;
                            };
      
                            print("=======>>>>>>>>>> Form validated");
      
                            //Create event instance
                            final event = Event(
                              poster: _selectedImage,
                              eventClass: _selectedEventClass.toString().trim(),
                              level: _selectedLevel.toString().trim(),
                              category:
                                  _selectedLevel.toString() == "National"
                                      ? _selectedNationalCategory
                                          .toString()
                                          .trim()
                                      : _selectedInternationalCategory
                                          .toString()
                                          .trim(),
                              subject:
                                  _selectedAcademicSubject.toString().toString(),
                              name: _eventNameController.text.trim(),
                              participation_mode:
                                  _selectedPlatform.toString().trim(),
                              venue: _eventVenueController.text.trim(),
                              county: _eventCountyController.text.trim(),
                              link: _eventLinkController.text.trim(),
                              description:
                                  _eventDescriptionController.text.trim(),
                              startDate: _selectedStartDate ?? DateTime.now(),
                              endDate: _selectedEndDate ?? DateTime.now(),
                              hosts: _eventhostController.text.trim(),
                              sponsors: _eventSponsorsController.text.trim(),
                              capacity: int.parse(_eventCapacityController.text),
                              registration_fee: int.parse(
                                _eventFeeController.text,
                              ),
                              contact_number: int.parse(
                                _eventContactController.text,
                              ),
                              currency: _selectedCurrency.toString().trim(),
                            );
      
                            print("=======>>>>>>>>>> New Event instance created");
      
                            //Snackbar to distract user from loading process
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.amber[900],
                                content: Text("Processing Data"),
                              ),
                            );
      
                            //Run create event logic
                            try {
                              print("====>>>> Starting event submission");
                              final createdEvent = await createEvent(event);
      
                              print("====>>>>> Event data: $createdEvent");
      
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.amber[900],
                                  content: Text("Event created successfully!"),
                                ),
                              );
      
                              if (mounted) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MyNavigator(index: 1),
                                  ),
                                );
                              }
                            } catch (e) {
                              print(
                                "=====>>>>>Failed to create event because of this error: $e",
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.amber[900],
                                  content: Text("Failed to create event"),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
