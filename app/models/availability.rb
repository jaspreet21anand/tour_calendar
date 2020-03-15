class Availability < ApplicationRecord
  belongs_to :tour
  has_one :frequency_rule
end
