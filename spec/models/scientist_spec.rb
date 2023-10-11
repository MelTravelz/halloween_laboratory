require 'rails_helper'

RSpec.describe Scientist do
  describe "relationships" do
    it { should belong_to(:lab) }
    it { should have_many(:scientist_experiments) }
    it { should have_many(:experiments).through(:scientist_experiments) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :specialty }
    it { should validate_presence_of :university }
  end

  describe "instance methods" do
    before (:each) do
      @nuclear = Lab.create!(name: "Nuclear Lab")
      
      @curie = Scientist.create!(lab: @nuclear, name: "Marie Curie", specialty: "radioactivity", university: "University of Paris")
      @franky = Scientist.create!(lab: @nuclear, name: "Victor Frankenstein", specialty: "electrical-biology", university: "University of Ingolstadt")
      @oppie = Scientist.create!(lab: @nuclear, name: "J. Robert Oppenheimer", specialty: "the big boom & quick maths", university: "Harvard University")

      @exp_1 = Experiment.create!(name: "Radio-waves", objective: "understand them", num_months: 6)
      @exp_2 = Experiment.create!(name: "My Hand Hurts", objective: "understand why", num_months: 14)
      @exp_3 = Experiment.create!(name: "Monster", objective: "electic-life", num_months: 7)
  
      ScientistExperiment.create!(scientist: @curie, experiment: @exp_1)
  
      ScientistExperiment.create!(scientist: @franky, experiment: @exp_1)
      ScientistExperiment.create!(scientist: @franky, experiment: @exp_2)
    end

    describe "#find_total_experiments" do
      it "returns a totla count of all experiments by a scientist" do 
        expect(@curie.find_total_experiments).to eq(1)
        expect(@franky.find_total_experiments).to eq(2)
        expect(@oppie.find_total_experiments).to eq(0)
      end
    end
  end
end