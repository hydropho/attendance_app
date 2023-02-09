class Attendance {
  final DateTime date;
  final String status;

  const Attendance(this.date, this.status);
}

class Attendances {
  final List<Attendance> attendances;

  const Attendances(this.attendances);
}
