module Frequency
  module Creator
    class Weekly
      include Frequency::Common::Validators
      include ActiveModel::Validations

      # we have 52 weeks in a year, allowing half the total
      # ideally we can allow any number here, but restricting as per use case
      MAX_WEEK_NUMBER = 26

      validates :day_numbers, :every, presence: true
      validates :every, numericality: { only_integer: true, greater_than: 0 }
      validate :day_numbers_is_an_array, :day_numbers_are_within_range,
        :value_of_every_is_within_range, :day_numbers_are_only_numeric

      attr_reader :day_numbers, :every

      def to_json
        { every: every, day_numbers: day_numbers }
      end

      def load_params_from_json(json)
        json = ActiveSupport::HashWithIndifferentAccess.new(json)
        @every = json[:every]
        @day_numbers = json[:day_numbers]
      end

      # Utility methods
      # return self so chaining of methods is possible
      def repeats_every(number_of_weeks)
        @every = number_of_weeks
        self
      end

      def on_day_numbers(array_of_day_numbers)
        @day_numbers = array_of_day_numbers
        self
      end

      private

        def value_of_every_is_within_range
          if (every.is_a? Numeric) && !numbers_within_range?([every], 1, MAX_WEEK_NUMBER)
            errors.add(:every, "value should be between 1 and #{ MAX_WEEK_NUMBER }")
          end
        end
    end
  end
end
