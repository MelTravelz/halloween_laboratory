require 'rails_helper'

RSpec.describe Experiment, type: :model do
  describe "relationships" do
    it { should have_many(:scientist_experiments) }
    it { should have_many(:scientists).through(:scientist_experiments) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :objective }
    it { should validate_presence_of :num_months }
  end

  describe "class methods" do
    before (:each) do
      @exp_1 = Experiment.create!(name: "Radio-waves", objective: "understand them", num_months: 6)
      @exp_2 = Experiment.create!(name: "My hand hurts", objective: "understand why", num_months: 4)
      @exp_3 = Experiment.create!(name: "Monster", objective: "electic-life", num_months: 7)
      @exp_4 = Experiment.create!(name: "Reduced Sleep", objective: "who am I?", num_months: 2)  
      @exp_5 = Experiment.create!(name: "Even More Reduced Sleep", objective: "who am I now?", num_months: 10)  
    end
    
    describe "#find_long_experiments" do
      it "returns all experiments that run longer than 6 months" do
        expect(Experiment.find_long_experiments).to eq([@exp_3, @exp_5])
      end
    end
  end
end
