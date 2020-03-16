module Frequency
  module Common
    module Validators
      include Helpers

      def day_numbers_are_numeric?
        day_numbers && day_numbers.all? { |number| number.is_a? Numeric }
      end

      def day_numbers_out_of_range?
        !numbers_within_range?(day_numbers, 1, 7)
      end

      def day_numbers_are_within_range
        if (is_attribute_an_array?(day_numbers) && day_numbers_are_numeric? && day_numbers_out_of_range?)
          errors.add(:day_numbers, 'can not be greater than 7 or less than 1')
        end
      end

      def day_numbers_is_an_array
        if !is_attribute_an_array?(day_numbers)
          errors.add(:day_numbers, "should be an array of day numbers. Considering Monday is 1")
        end
      end

      def day_numbers_are_only_numeric
        if day_numbers && !day_numbers_are_numeric?
          errors.add(:day_numbers, 'can only have numeric values')
        end
      end

      def dates_is_an_array
        if !is_attribute_an_array?(dates)
          errors.add(:dates, "should be an array of numbers. Numbers can range from 1 to 31")
        end
      end

      def dates_are_within_range
        if is_attribute_an_array?(dates) && dates_out_of_range?
          errors.add(:dates, 'can only range from 1 to 31')
        end
      end

      def dates_out_of_range?
        !numbers_within_range?(dates, 1, 31)
      end
    end
  end
end