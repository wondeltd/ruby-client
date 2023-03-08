# Wonde Ruby Client
Documentation https://wonde.com/docs/api/1.0/

## Installation

Native gem:

```bash
gem install wondeclient
```

When using [bundler](http://bundler.io/) place this to your `Gemfile`:

```ruby
gem 'wondeclient'
```

Or if you want to use latest github `master`

```ruby
gem 'wondeclient', github: 'wondeltd/ruby-client'
```

... and run `$ bundle install`

## Early Release

If you wish to get early access to new endpoints / improvements please set your package version to `dev-master`.

**Important Note:** Wonde strongly recommends locking to a stable version on production.

## Endpoints

### Client

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')
```

### Schools

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

# Loop through the schools your account has access to
client.schools.all().each do |school|
  # Display school name
  p school.name
end
```

### Single School
```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

# Get single school
school = client.schools.get('SCHOOL_ID_GOES_HERE')
```

### Pending Schools

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

client.schools.pending().each do |school|
  # Display school name
  p school.name
end

```

### Search Schools

```ruby
client = Wonde::Client.new('TOKEN_GOES_HERE')

# Search for schools with a postcode starting CB21
client.schools.search(Hash.new, {'postcode': 'CB21'}).each do |school|
  # Display school name
  p school.name
end

# Search for schools with the establishment number = 6006
client.schools.search(Hash.new, {'establishment_number': '6006'}).each do |school|
  # Display school name
  p school.name
end
```

### Request Access

Provide the school ID to request access to a school's data.

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')
client.requestAccess("A0000000000")
```

### Revoke Access

Provide the school ID to access already approve or pending approval.

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')
client.revokeAccess('A0000000000')
```

### Students

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get students
school.students.all().each do |student|
    p student.forename + ' ' + student.surname
end

# Get single student
student = school.students.get('STUDENT_ID_GOES_HERE')

# Get students and include contact_details object
school.students.all(['contact_details']).each do |student|
    #print students first and last name
    p student.forename + ' ' + student.surname
end

# Get students and include contacts array
school.students.all(['contacts']).each do |student|
    #print students first and last name
    p student.forename + ' ' + student.surname
end

# Get students, include contact_details object, include extended_details object and filter by updated after date
school.students.all(['contact_details', 'extended_details'], {'updated_after': '2016-06-24 00:00:00'}).each do |student|
    #print students first and last name
    p student.forename + ' ' + student.surname
end
```

### Achievements

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get achievements
school.achievements.all().each do |achievement|
    p achievement.comment
end
```
### Assessment - (BETA)
This endpoint is included in the stable release but is likely to change in the future. Please contact support for more information.

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get aspects
school.assessment.aspects.all().each do |aspect|
    p aspect.id
end

# Get templates
school.assessment.templates.all().each do |templates|
    p templates.id
end

# Get result sets
school.assessment.templates.all().each do |resultsets|
    p resultsets.id
end

# Get results
school.assessment.results.all().each do |results|
    p results.id
end

# Get marksheets
school.assessment.marksheets.all().each do |marksheets|
    p marksheets.id
end
```

### Attendance

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get attendance
school.attendance.all().each do |attendance|
    p attendance.comment
end
```

### POST Attendance

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

# Initiate a new register
register = Wonde::SessionRegister.new()

# Initiate a new attendance record
attendance = Wonde::SessionAttendanceRecord.new()

# Set fields
attendance.setStudentId('STUDENT_ID_GOES_HERE')
attendance.setDate('2017-01-01')
attendance.setSession('AM') # AM or PM
attendance.setAttendanceCodeId('ATTENDANCE_CODE_ID_GOES_HERE')
attendance.setComment('Comment here.')
attendance.setComment('Comment here.')
attendance.setMinutesLate('minutes late here')
attendance.setEmployeeId('employee id here')

# Add attendance mark to register
register.add(attendance)

# Save the session register to pre-existing school object from client.school('ID')
result = school.attendance().session_register(register)

# Writeback id is part of the response
p result.writeback_id
```

### Attendance Codes

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

# Get attendance codes
client.attendanceCodes.all().each do |attendanceCode|
    p attendanceCode.code
 end
```

### Behaviours

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get behaviours
school.behaviours.all().each do |behaviour|
    p behaviour.incident
    #or maybe:
    #p behaviour.incident_date or p behaviour.comment
end
```

### Classes

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get classes
#class is a reserved word in ruby, so use classobj instead
school.classes.all().each do |classobj|
    p classobj.name
end
```

### Contacts

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get contacts
school.contacts.all().each do |contacts|
    p contacts.forename + ' ' + contacts.surname
end
```

### Counts

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get counts
counts = school.counts.all(['students','contacts'])
p counts.students.data.count
p counts.contacts.data.count
```

### Deletions

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get deletions
school.deletions.all().each do |deletions|
    p deletions.id
end
```

### Employees

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get employees
school.employees.all().each do |employee|
    p employee.forename + ' ' + employee.surname
end
```

### Events

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get events
school.events.all().each do |event|
    p event.id
end
```

### Groups

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get groups
school.groups.all().each do |group|
    p group.name
end
```

### Lessons

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get lessons
school.lessons.all().each do |lesson|
    p lesson.period_instance_id + '-' + lesson.id
end
```

### Lesson Attendance

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get lesson attendance
school.lessonAttendance.all().each do |lessonAttendance|
    p lessonAttendance.comment
end
```

### POST Lesson Attendance

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

# Initiate a new register
register = Wonde::LessonRegister.new()

# Initiate a new attendance record
attendance = Wonde::LessonAttendanceRecord.new()

# Set fields
attendance.setStudentId('STUDENT_ID_GOES_HERE')
attendance.setLessonId('LESSON_ID_GOES_HERE')
attendance.setAttendanceCodeId('ATTENDANCE_CODE_ID_GOES_HERE')

# Add attendance mark to register
register.add(attendance)

# Save the lesson register to pre-existing school object from client.school('ID')
result = school.lessonAttendance().lesson_register(register)

# Writeback id is part of the response
p result.writeback_id
```

### Medical Conditions

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get medical conditions
school.medicalConditions.all().each do |medicalCondition|
    p medicalCondition.description
end
```

### Medical Events

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get medical events
school.medicalEvents.all().each do |medicalEvent|
    p medicalEvent.description
end
```

### Medical Notes

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get medical notes
school.medicalNotes.all().each do |medicalNote|
    p medicalNote.title
end
```

### Periods

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get periods
school.periods.all().each do |period|
    p period.name
end
```

### Photos

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get photos
school.photos.all().each do |photo|
    p photo.hash
end
```

### Rooms

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get rooms
school.rooms.all().each do |room|
    p room.name
end
```

### Subjects

```ruby
require 'wondeclient'
client = Wonde::Client.new('TOKEN_GOES_HERE')

school = client.school('SCHOOL_ID_GOES_HERE')

# Get subjects
school.subjects.all().each do |subject|
    p subject.name
end
```
