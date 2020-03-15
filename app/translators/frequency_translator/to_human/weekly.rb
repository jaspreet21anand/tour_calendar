module FrequencyTranslator
  module ToHuman
    class Weekly
      attr_reader :day_numbers, :every, :start_date
      DAY_MAPPING = {
          1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday',
          4 => 'Thursday', 5 =>'Friday', 6 => 'Saturday',
          7 => 'Sunday'
        }

      def initialize(weekly_frequency_rule, start_date)
        weekly_frequency_rule = ActiveSupport::HashWithIndifferentAccess.new(weekly_frequency_rule)
        @every = weekly_frequency_rule[:every]
        @day_numbers = weekly_frequency_rule[:days]
        @start_date = start_date
      end

      def humanized_frequency
        "every #{ humanized_week_text(every) } on #{ humanized_days_text(day_numbers) }"
      end

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