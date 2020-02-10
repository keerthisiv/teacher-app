# README

###### How did I approach this challenge?

My approach was to create a simple Rails app by using rails generators to scaffold the Log events and devise gem for authentication with proper test cases using Rspec to cover the base scenarios. I wanted to make sure the functionality is all present and if time premits then to work on the UI design and styling. I started off first with rails 6 but I felt there lots of overhead which I dont need for this application like the front end could be a seperate app that is compiled using webpack. So I created a rails 5 app and then added devise and created the teacher model, followed by log events and then adding rspec and other dependant libraries to ensure log events are validated correctly. I would normally use the application time zone as utc but for this set to EST for easy of use given this application is used only in that time zone. Updated the Log Events Index page to show only the events for the teacher who is logged in and displayed them in descending order. After testing out various scenarios on local then prepared the application to be deployed using heroku and then fixed the root to the index for events. I felt this was good enough for satisfying the requirements and spent about 2-3 hours in total.


###### What Schema design I choose and why?

A Teacher model with attributes first name, last name, email and password. Which is a base model for any user model using authentication. Log Event model with event type, event time, description that belongs to Teacher. The event type is an enum that is either 'check_in' or 'check_out' this ensures that no other string values gets entered to the field which helps to have a clean data without typo, nils or spaces. the event time is in EST, there is a foreign key on log events for teacher, added index event_type and teacher_id. 


###### Given another day to work on this, how would I spend it? given a month?

I would like to add some styling and make the UI look better and make the workflow easier as well by having the new log event form on the index page. Also group the events per day in the UI so that user/teacher is clear about their events for the day.  Add a Location model with address and time zone and make the teacher and log events belong to location so that the time entered for the event will be parsed with the time zone before validating.
Given a month I would make the front end as a seperate app in reactjs or vuejs, have a nice datetime picker, have a profile page for the teacher with the ability to update their picture. Add enum constraint on postgresql for the log event. Have a flag on events that are mismatched for the day and highlight them to the teacher on the UI or send them an email to make sure to fix them. Have a confirmation email sent on upon registration. Create an Admin User to create many Locations that can be selected by the teacher and add one as their default location. 
