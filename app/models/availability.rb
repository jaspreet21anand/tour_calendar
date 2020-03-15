class Availability < ApplicationRecord
  belongs_to :tour
  has_one :frequency_rule

  validates :start_date, presence: true
  validates :repeats, inclusion: [true, false]
end
