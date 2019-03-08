Our Attendance Tracker helps you keep track of the attendance for your class full of students. We've focussed on making it a sturdy and robust program that could be easily customized for another situation and it's specifics. Start time can be easily changed from 9:00 AM by changing a few places in the code, and the time zone can also be altered (though I won't claim that will be as simple). The teacher menu also shows some proof of concept that you could easily customize all the colors of the menu if you so choose.

Students have to be initialized, or created by a teacher. Teachers have full CRUD access to the students (and other teachers), but students only have the ability to check in, and check some stats for their personal attendance. Teachers have some broader ways to check the whole classes attendance, or they can "log in" from the teacher menu to any student's profile, and see the students stats and change their attendance time just like that student would be able to do. Teachers can also right the current attendance database out to a CSV file similar to the one we use to track attendance currently, in case they wanted a copy in that format.

We have also included a proof of concept file 'Quick_Check_In.rb' in the repository, which shows how the program could be implemented on a device such as a raspberry pi, and left (in our case) right where you get off the elevator or stairs to our floor. This would allow the student to log in, and then it would automatically check them in at that time, with no other options available. This would streamline the attendance process and make it much harder to forget about tracking your attendance.

Below is our original proposal for the project. At Josh's suggestion we rolled the admin class into the student class and just added a boolean to check whether the user is a student or teacher. We didn't add any module functionality, but it would not be hard to implement. We did not add a weather connection, because that seemed a little over the top, but is also something you could do without too much trouble.


This project was created by Adam Moran and Jack Rotta. This project is licensed under the terms of the MIT license.

************** Attendance Application ******************

 ### Our primary Models are Students, SchoolDays, and a join class Attendance. Attendances belong to Students and SchoolDays, and SchoolDays and Students have many of each other through Attendance.

Additionally, we want a Admin class. This will belong to Users if we only want one “Admin” login, or we could build out a model for multiple Admins called Teachers. This would require another join class between Students and Teachers. We also could add a Model for Class, which will have a one to many relationship with students. We also could add a model Module the User is currently in, but we may need to discuss that with you. It might be overdoing things.

Ideally, we’re imagining what it would look like to leave a computer running our CLI where students get off the elevator. Each morning, the program would run on startup a .find_or_create_by against the SchoolDay model, and if the day hasn’t been instantiated it will do that. Then a menu will pop up. Users could “login” (.find_by(pin = x)) against a 8 digit code (we’re thinking their birthdate), then afterwards press one button to run a Attendance.new(user: self, time: datetime.now, school_day: Schoolday.last). Not sure how that datetime thing works but we’ll figure it out.

For user stories, users could have the ability to change a time after first entry, or manually enter (in case they still got distracted on the way to the CLI). Admins (or just users as well) could access fun methods like ‘Check Attendance for all students one any given day’, ‘Check who’s late today’, ‘Check one student’s attendance record’, ‘Check total time missed by one student’, ‘Check attendance by module/class’, etc. If we build out the single Admin class into TCFs, we could check which TCF has the most timely students, etc. We also could implement methods that check if the User is on a “timely” streak, and congratulate them at milestones (one month no lateness, etc).

This could scrape a CSV to create the student database, and could also write back to the CSV every night (or day at 10:00am, whatever) in case flatiron hq needs that CSV. We’re considering adding an API connection to a weather database, and then you could check what attendance is like when whether is bad vs good, but that might be a stretch goal if we finish everything else.
