# tour_calendar
This repository describes core models and test cases for setting up tour calendar
=======

* Entry point files
  * `app/services/tour_creator.rb`
  * `app/services/tour_viewer.rb`

* TourCreator example
```
tour_creator = TourCreator.new("African Safari", "In Jungles of Ghana", "+91-77880988788")
tour_creator.occurs_on_specific_date(start_date: Date.tomorrow)
tour_creator.repeat_every_n_weeks_on_days(n: 1, days: [1,3,5], start_date: Date.today)
tour_creator.repeat_every_n_months_on_dates(n: 2, dates: [25, 27], start_date: Date.tomorrow)

# when creating tours for "every second Wednesday of month"
tour_creator.repeat_every_n_months_on_nth_weeks_and_m_days(n: 1, weeks: [2], days: [3],
  start_date: Date.tomorrow)

# to save the tour
tour_creator.persist_tour
```

* TourViewer example
```
tour = Tour.last
tour_viewer = TourViewer.new(tour)
puts tour_viewer.show_availabilities

# output
starts on 2020-03-16
every week on Monday, Wednesday, and Friday
on 25th and 27th of every 2nd months
2nd Wednesday of every month
```

* Steps to setup app
  * `bundle`
  * `rake db:create` Note: setup your database.yml before running this step
  * `rake db:migrate`
  * `rspec -fd`
  * `rails c`