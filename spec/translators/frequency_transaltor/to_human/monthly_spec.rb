require 'rails_helper'

RSpec.describe FrequencyTranslator::ToHuman::Monthly do
  let(:start_date) { Date.new(2020, 1, 3) }

  describe "reverse translation from frequency rule when frequency is set to" do
    context "5th, 7th and 21st of every month" do
      let(:freq_rule) { { every: 1, dates: [5, 7, 21] } }
      subject { FrequencyTranslator::ToHuman::Monthly.new(freq_rule, start_date) }

      it do
        expect(subject.humanized_frequency).to eq("on 5th, 7th, and 21st of every month")
      end
    end

    context "first Monday of every month" do
      let(:freq_rule) { { every: 1, week_rules: { week_numbers: [1], day_numbers: [1] } } }
      subject { FrequencyTranslator::ToHuman::Monthly.new(freq_rule, start_date) }

      it do
        expect(subject.humanized_frequency).to eq("1st Monday of every month")
      end
    end

    context "2nd and 4th, Tuesday and Saturday of every month" do
      let(:freq_rule) { { every: 1, week_rules: { week_numbers: [2, 4], day_numbers: [2, 6] } } }
      subject { FrequencyTranslator::ToHuman::Monthly.new(freq_rule, start_date) }

      it do
        expect(subject.humanized_frequency).to eq("2nd and 4th Tuesday and Saturday of every month")
      end
    end
  end

  describe "if both dates and weekly rules are set, priority will be given to dates" do
    context "dates set are 3rd of every month, and weekly are set for 2nd Tuesday" do
      let(:freq_rule) { { every: 1, dates: [3], week_rules: { week_numbers: [2], day_numbers: [2] } } }
      subject { FrequencyTranslator::ToHuman::Monthly.new(freq_rule, start_date) }

      it do
        expect(subject.humanized_frequency).to eq("on 3rd of every month")
      end
    end
  end
end
