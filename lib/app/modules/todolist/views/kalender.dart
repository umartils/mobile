import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/todolist/controllers/todolist_controller.dart';
import 'package:puu1/global.dart';
import 'package:table_calendar/table_calendar.dart';

class Kalender extends StatefulWidget {
  const Kalender({super.key});

  @override
  _KalenderState createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  final TodolistController controller = Get.put(TodolistController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 280,
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            
            TableCalendar(
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle:
                      GoogleFonts.sora(color: Colors.white, fontSize: 12),
                  weekendStyle:
                      GoogleFonts.sora(color: Colors.white, fontSize: 12)),
              calendarStyle: CalendarStyle(
                defaultTextStyle:
                    GoogleFonts.sora(color: Colors.white, fontSize: 12),
                todayTextStyle:
                    GoogleFonts.sora(color: Colors.white, fontSize: 12),
                outsideTextStyle:
                    GoogleFonts.sora(color: Colors.white, fontSize: 12),
                weekendTextStyle:
                    GoogleFonts.sora(color: Colors.white, fontSize: 12),
              ),
              locale: 'id_ID',
              rowHeight: 31,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                    GoogleFonts.sora(color: Colors.white, fontSize: 16),
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white, // Warna ikon panah kiri
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: Colors.white, // Warna ikon panah kanan
                ),
              ),
              selectedDayPredicate: (day) => isSameDay(day, controller.today),
              focusedDay: controller.today,
              availableGestures: AvailableGestures.all,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 10, 16),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  controller.onDaySelected(selectedDay, focusedDay);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
