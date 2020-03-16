module Frequency
  module Creator
    class Monthly
      include Frequency::Common::Validators
      include ActiveModel::Validations

      # we have 52 weeks in a year, allowing half the total
      # ideally we can allow any number here, but restricting as per use case
      MAX_MONTH_NUMBER = 6

      validates :every, presence: true
      validates :every, numericality: { only_integer: true, greater_than: 0 }
      validate :either_dates_or_week_rules_should_exist
      validate :day_numbers_is_an_array, :day_numbers_are_within_range,
        :day_numbers_are_only_numeric, if: :day_numbers
      validate :value_of_every_is_within_range
      validate :week_numbers_are_within_range, if: :week_numbers
      validate :week_numbers_and_days_coexist, if: -> { week_numbers || day_numbers }
      validate :dates_is_an_array, :dates_are_within_range, if: :dates

      attr_reader :dates, :week_numbers, :day_numbers, :every

      def to_json
        json = { every: every }
        if week_rules
          json[:week_rules] = week_rules
        elsif dates
          json[:dates] = dates
        end
        json
      end

      def load_params_from_json(json)
        json = ActiveSupport::HashWithIndifferentAccess.new(json)
        @every, @dates = json[:every], json[:dates]
        if !@dates && (week_rules = json[:week_rules])
          @week_numbers, @day_numbers = week_rules[:week_numbers], week_rules[:day_numbers]
        end
      end

      # Utility methods
      # return self so chaining of methods is possible
      def repeats_every(number_of_months)
        @every = number_of_months
        self
      end

      def on_dates(array_of_dates)
        @dates = array_of_dates
        self
      end

      def on_n_weeks_and_m_days(array_of_week_numbers, array_of_m_days)
        @week_numbers = array_of_week_numbers
        @day_numbers = array_of_m_days
        self
      end

      private
        def week_rules
          if @week_numbers && @day_numbers
            { week_numbers: week_numbers, day_numbers: day_numbers }
          end
        end

        def either_dates_or_week_rules_should_exist
          if dates.blank? && (week_numbers.blank? && day_numbers.blank?)
            errors.add(:base, 'Either dates or week_rules should exist')
          end
        end

        def value_of_every_is_within_range
          if (every.is_a? Numeric) && !numbers_within_range?([every], 1, MAX_MONTH_NUMBER)
            errors.add(:every, "value should be between 1 and #{ MAX_MONTH_NUMBER }")
          end
        end

        def week_numbers_are_within_range
          if (is_attribute_an_array?(week_numbers)) && !numbers_within_range?(week_numbers, 1, 4)
            errors.add(:week_numbers, "can range from 1 to 4")
          end
        end

        def week_numbers_and_days_coexist
          if week_numbers.blank? || day_numbers.blank?
            errors.add(:base, 'Both week_numbers and day_numbers should have values')
          end
        end
    end
  end
end
