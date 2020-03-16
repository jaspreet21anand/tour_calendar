module Frequency
  module Translator
    class Weekly
      include Frequency::Common::Constants
      attr_reader :day_numbers, :every, :start_date

      def initialize(weekly_frequency_rule, start_date)
        weekly_frequency_rule = ActiveSupport::HashWithIndifferentAccess.new(weekly_frequency_rule)
        @every = weekly_frequency_rule[:every]
        @day_numbers = weekly_frequency_rule[:day_numbers]
        @start_date = start_date
      end

      def humanized_frequency
        "every #{ humanized_week_text(every) } on #{ humanized_days_text(day_numbers) }"
      end

      # this method is inteded to return next n dates by calendar or the tour
      def next_n_occurences(n = 5)
      end

      private

        def humanized_week_text(every)
          every == 1 ? 'week' : "#{ every } #{ 'week'.pluralize }"
        end

        def humanized_days_text(days)
          days.map { |day_number| day_name(day_number) }.to_sentence
        end

        def day_name(day_number)
          # week start from 1 which is Monday
          DAY_MAPPING[day_number]
        end
    end
  end
end