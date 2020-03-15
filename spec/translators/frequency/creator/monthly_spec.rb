require 'rails_helper'

RSpec.describe Frequency::Creator::Monthly do
  describe "When values of repetition param -every- is accepted as input" do
    context "when a non number string is entered, subject.errors" do
      subject { Frequency::Creator::Monthly.new }
      it do
        subject.repeats_every('a')
        subject.valid?
        expect(subject.errors.full_messages).to include("Every is not a number")
      end
    end

    context "when a string number is entered, subject.errors" do
      subject { Frequency::Creator::Monthly.new }
      it do
        subject.repeats_every('2')
        subject.valid?
        expect(subject.errors.full_messages).to_not include("Every is not a number")
      end
    end

    context "when a correct number is entered, subject.errors" do
      subject { Frequency::Creator::Monthly.new }
      before { subject.repeats_every(1).on_dates([5, 21]) }

      it { expect(subject.errors.full_messages).to be_empty }

      it 'object should be valid' do
        expect(subject.valid?).to be_truthy
      end

      it do
        expect(subject.errors.full_messages).to_not include("Every is not a number")
      end
    end

    context "when an out of range number is entered, subject.errors" do
      subject { Frequency::Creator::Monthly.new }
      it do
        subject.repeats_every(7)
        subject.valid?
        expect(subject.errors.full_messages).to include("Every value should be between 1 and #{ Frequency::Creator::Monthly::MAX_MONTH_NUMBER }")
      end
    end
  end

  describe "When both the dates and week_rules are not supplied" do
    subject { Frequency::Creator::Monthly.new }
    it do
      subject.repeats_every(1)
      subject.valid?
      expect(subject.errors.full_messages).to include("Either dates or week_rules should exist")
    end
  end

  describe "When week_rules are supplied" do
    subject { Frequency::Creator::Monthly.new }
    context "only week_numbers are supplied" do
      it do
        subject.repeats_every(1).on_n_weeks_and_m_days([1, 3], [])
        subject.valid?
        expect(subject.errors.full_messages).to include("Both week_numbers and day_numbers should have values")
      end
    end

    context "both week_numbers and day_numbers are supplied" do
      before { subject.repeats_every(1).on_n_weeks_and_m_days([1, 3], [2]) }

      it { expect(subject.valid?).to be_truthy }
      it do
        subject.valid?
        expect(subject.errors.full_messages).to be_empty
      end
    end
  end

  describe "when empty json is passed" do
    subject { Frequency::Creator::Monthly.new }
    before { subject.load_params_from_json({}) }
    it 'object should not be valid' do
      expect(subject.valid?).to be_falsey
    end

    it 'object should contain errors' do
      subject.valid?
      expect(subject.errors.full_messages.count).not_to be_zero
    end
  end
end