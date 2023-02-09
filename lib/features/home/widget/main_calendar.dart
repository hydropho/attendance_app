import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatefulWidget {
  const MainCalendar({super.key});

  @override
  State<MainCalendar> createState() => _MainCalendarState();
}

class _MainCalendarState extends State<MainCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
      ),
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(DateTime.now().year - 2),
      lastDay: DateTime.utc(DateTime.now().year + 2),
      currentDay: DateTime.now(),
      headerStyle: HeaderStyle(
        headerPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        formatButtonVisible: false,
        titleCentered: true,
        titleTextFormatter: (date, locale) => DateFormat.MMM().format(date),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) =>
            DateFormat.E().format(date).substring(0, 2),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
    );
  }
}
