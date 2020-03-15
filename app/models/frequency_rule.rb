class FrequencyRule < ApplicationRecord
  belongs_to :availability

  validates :frequency_type, :specifics, presence: true
  validate :specifics_json_as_per_type, if: :specifics

  enum frequency_type: { daily: 0, weekly: 1, monthly: 2, yearly: 3 }

  private
    def specifics_json_as_per_type
      case frequency_type
      when "weekly"
        translator = FrequencyTranslator::FromHuman::Weekly.new
      when "monthly"
        translator = FrequencyTranslator::FromHuman::Monthly.new
      else
        errors.add(:frequency_type, 'currently not supported')
        return
      end
      translator.load_params_from_json(specifics)
      unless translator.valid?
        errors.add(:frequency_type, translator.errors.full_messages.join('. '))
      end
    end
end
