class TourCreator
  attr_reader :tour

  def initialize(title, description, contact_details)
    @tour = Tour.new(title: title, description: description, contact_details: contact_details)
  end

  def occurs_on_specific_date(start_date:)
    availability = @tour.availabilities.build(start_date: start_date, repeats: false)
  end

  def repeat_every_n_weeks_on_days(n: 1, days:, start_date:)
    availability = @tour.availabilities.build(start_date: start_date, repeats: true)
    freq_json_creator = Frequency::Creator::Weekly.new
    freq_json_creator.repeats_every(n).on_day_numbers(days)
    availability.build_frequency_rule(frequency_type: :weekly, specifics: freq_json_creator.to_json)
  end

  def repeat_every_n_months_on_dates(n: 1, dates:, start_date:)
    availability = @tour.availabilities.build(start_date: start_date, repeats: true)
    freq_json_creator = Frequency::Creator::Monthly.new
    freq_json_creator.repeats_every(n).on_dates(dates)
    availability.build_frequency_rule(frequency_type: :monthly, specifics: freq_json_creator.to_json)
  end

  def repeat_every_n_months_on_nth_weeks_and_m_days(n: 1, weeks:, days:, start_date:)
    availability = @tour.availabilities.build(start_date: start_date, repeats: true)
    freq_json_creator = Frequency::Creator::Monthly.new
    freq_json_creator.repeats_every(n).on_n_weeks_and_m_days(weeks, days)
    availability.build_frequency_rule(frequency_type: :monthly, specifics: freq_json_creator.to_json)
  end

  def persist_tour
    @tour.save
    @tour
  end
end