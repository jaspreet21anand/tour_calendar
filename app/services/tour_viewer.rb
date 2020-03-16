class TourViewer
  attr_reader :tour

  def initialize(tour)
    @tour = tour
  end

  def show_availabilities
    printable_rows = tour.availabilities.map do |availability|
      human_readable_availability(availability)
    end
  end

  private
    def human_readable_availability(availability)
      if availability.repeats
        frequency_rule = availability.frequency_rule
        specifics = frequency_rule.specifics
        case frequency_rule.frequency_type
        when "weekly"
          f_t = Frequency::Translator::Weekly.new(specifics, availability.start_date)
          f_t.humanized_frequency
        when "monthly"
          f_t = Frequency::Translator::Monthly.new(specifics, availability.start_date)
          f_t.humanized_frequency
        end
      else
        "starts on #{ availability.start_date }"
      end
    end
end