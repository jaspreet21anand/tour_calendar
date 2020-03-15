require 'rails_helper'

RSpec.describe FrequencyTranslator::ToHuman::Weekly do
  let(:start_date) { Date.new(2020, 1, 3) }

  describe "reverse translation from frequency rule when frequency is set to" do
    context 'Tuesday every week' do
      let(:freq_rule) { { every: 1, days: [2] } }
      subject { FrequencyTranslator::ToHuman::Weekly.new(freq_rule, start_date) }

      it 'should return -- every week on Tuesday' do
        expect(subject.humanized_frequency).to eq('every week on Tuesday')
      end
    end

    context 'Wednesday every 2 weeks' do
      let(:freq_rule) { { every: 2, days: [3] } }
      subject { FrequencyTranslator::ToHuman::Weekly.new(freq_rule, start_date) }

      it 'should return -- every 2 weeks on Wednesday' do
        expect(subject.humanized_frequency).to eq('every 2 weeks on Wednesday')
      end
    end

    context 'Wednesday and Thursday every 2 weeks' do
      let(:freq_rule) { { every: 2, days: [3, 4] } }
      subject { FrequencyTranslator::ToHuman::Weekly.new(freq_rule, start_date) }

      it 'should return -- every 2 weeks on Wednesday and Thursday' do
        expect(subject.humanized_frequency).to eq('every 2 weeks on Wednesday and Thursday')
      end
    end
  end
end
