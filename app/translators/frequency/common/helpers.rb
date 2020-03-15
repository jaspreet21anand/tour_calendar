module Frequency
  module Common
    module Helpers

      def numbers_within_range?(array, start, _end)
        array.all? { |number| (number >= start && number <= _end) }
      end

      def is_attribute_an_array?(attribute)
        attribute.is_a? Array
      end
    end
  end
end