************** Attendance Application ******************

 ### Our primary Models are Students, SchoolDays, and a join class Attendance. Attendances belong to Students and SchoolDays, and SchoolDays and Students have many of each other through Attendance.

Additionally, we want a Admin class. This will belong to Users if we only want one “Admin” login, or we could build out a model for multiple Admins called Teachers. This would require another join class between Students and Teachers. We also could add a Model for Class, which will have a one to many relationship with students. We also could add a model Module the User is currently in, but we may need to discuss that with you. It might be overdoing things.

Ideally, we’re imagining what it would look like to leave a computer running our CLI where students get off the elevator. Each morning, the program would run on startup a .find_or_create_by against the SchoolDay model, and if the day hasn’t been instantiated it will do that. Then a menu will pop up. Users could “login” (.find_by(pin = x)) against a 8 digit code (we’re thinking their birthdate), then afterwards press one button to run a Attendance.new(user: self, time: datetime.now, school_day: Schoolday.last). Not sure how that datetime thing works but we’ll figure it out.

For user stories, users could have the ability to change a time after first entry, or manually enter (in case they still got distracted on the way to the CLI). Admins (or just users as well) could access fun methods like ‘Check Attendance for all students one any given day’, ‘Check who’s late today’, ‘Check one student’s attendance record’, ‘Check total time missed by one student’, ‘Check attendance by module/class’, etc. If we build out the single Admin class into TCFs, we could check which TCF has the most timely students, etc. We also could implement methods that check if the User is on a “timely” streak, and congratulate them at milestones (one month no lateness, etc).

This could scrape a CSV to create the student database, and could also write back to the CSV every night (or day at 10:00am, whatever) in case flatiron hq needs that CSV. We’re considering adding an API connection to a weather database, and then you could check what attendance is like when whether is bad vs good, but that might be a stretch goal if we finish everything else.


