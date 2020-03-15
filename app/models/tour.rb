class Tour < ApplicationRecord
  has_many :availabilities

  validates :title, :description, :contact_details, presence: true
end
