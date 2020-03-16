require 'rails_helper'

RSpec.describe Frequency::Creator::Weekly do

  describe "When values of repetition param -every- is accepted as input" do
    context "when a non number string is entered, subject.errors" do
      subject { Frequency::Creator::Weekly.new }
      it do
        subject.repeats_every('b')
        subject.valid?
        expect(subject.errors.full_messages).to include("Every is not a number")
      end
    end

    context "when a string number is entered, subject.errors" do
      subject { Frequency::Creator::Weekly.new }
      it do
        subject.repeats_every('2')
        subject.valid?
        expect(subject.errors.full_messages).to_not include("Every is not a number")
      end
    end

    context "when a correct number is entered, subject.errors" do
      subject { Frequency::Creator::Weekly.new }
      it do
        subject.repeats_every(2)
        subject.valid?
        expect(subject.errors.full_messages).to_not include("Every is not a number")
      end
    end

    context "when an out of range number is entered, subject.errors" do
      subject { Frequency::Creator::Weekly.new }
      it do
        subject.repeats_every(27)
        subject.valid?
        expect(subject.errors.full_messages).to include("Every value should be between 1 and #{ Frequency::Creator::Weekly::MAX_WEEK_NUMBER }")
      end
    end
  end

  describe "When values of repetition param -day_numbers- is accepted as input" do
    context "when a non number string is entered, subject.errors" do
      subject { Frequency::Creator::Weekly.new }
      it do
        subject.repeats_every(1).on_day_numbers(['b', 'c'])
        subject.valid?
        expect(subject.errors.full_messages).to include("Day numbers can only have numeric values")
      end
    end

    context "when a valid numbers are entered, subject.errors" do
      subject { Frequency::Creator::Weekly.new }
      before { subject.repeats_every(1).on_day_numbers([1, 3]) }
      it do
        subject.valid?
        expect(subject.errors.full_messages).to be_empty
      end
    end
  end
end