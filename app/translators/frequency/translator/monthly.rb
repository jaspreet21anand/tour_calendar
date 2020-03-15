module Frequency
  module Translator
    class Monthly
      include Frequency::Common::Constants
      attr_reader :dates, :week_rules, :week_numbers, :day_numbers, :every, :start_date

      # assuming the monthly_frequency_rule is already validated
      # and contains atleast dates or week_rules
      def initialize(monthly_frequency_rule, start_date)
        monthly_frequency_rule = ActiveSupport::HashWithIndifferentAccess.new(monthly_frequency_rule)
        @every = monthly_frequency_rule[:every]
        @dates = monthly_frequency_rule[:dates] if monthly_frequency_rule[:dates]&.size.to_i > 0
        @week_rules = monthly_frequency_rule[:week_rules]
        unless @dates
          @week_numbers = monthly_frequency_rule[:week_rules][:week_numbers]
          @day_numbers = monthly_frequency_rule[:week_rules][:day_numbers]
        end
        @start_date = start_date
      end

      def humanized_frequency
        if date_specific?
          "on #{ humanized_dates_text } of every #{ humanized_month_text }"
        elsif ruled_weekly?
          "#{ humanized_week_numbers } #{ humanized_days_text } of every #{ humanized_month_text }"
        end
      end

      # this method is inteded to return next n dates by calendar or the tour
      def next_n_occurences(n = 5)
      end

      private

        def humanized_month_text
          every == 1 ? 'month' : "#{ every.ordinalize } #{ 'month'.pluralize(every) }"
        end

        def humanized_dates_text
          numbers_with_suffix(dates).to_sentence
        end

        def humanized_week_numbers
          numbers_with_suffix(week_numbers).to_sentence
        end

        def numbers_with_suffix(numbers)
          numbers.map(&:ordinalize)
        end

        def humanized_days_text
          day_numbers.map { |day_number| day_name(day_number) }.to_sentence
        end

        def day_name(day_number)
          # week start from 1 which is Monday
          DAY_MAPPING[day_number]
        end

        def date_specific?
          @dates.present?
        end

        def ruled_weekly?
          @week_rules.present? && @week_numbers.present?
        end
    end
  end
end