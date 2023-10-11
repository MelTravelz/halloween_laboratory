require 'rails_helper'

RSpec.describe Lab do
  describe "relationships" do
    it { should have_many(:scientists) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "instance methods" do
    before (:each) do
      @nuclear = Lab.create!(name: "Nuclear Lab")
      @electric = Lab.create!(name: "Electric Lab")
      
      @curie = Scientist.create!(lab: @nuclear, name: "Marie Curie", specialty: "radioactivity", university: "University of Paris")
      @franky = Scientist.create!(lab: @nuclear, name: "Victor Frankenstein", specialty: "electrical-biology", university: "University of Ingolstadt")
      @oppie = Scientist.create!(lab: @nuclear, name: "J. Robert Oppenheimer", specialty: "the big boom & quick maths", university: "Harvard University")
      @jekyll = Scientist.create!(lab: @electric, name: "Dr. Jekyll or Mr. Hyde", specialty: "sleep deprivation", university: "University of London")

      @exp_1 = Experiment.create!(name: "Radio-waves", objective: "understand them", num_months: 6)
      @exp_2 = Experiment.create!(name: "My Hand Hurts", objective: "understand why", num_months: 14)
      @exp_3 = Experiment.create!(name: "Monster", objective: "electic-life", num_months: 7)
  
      ScientistExperiment.create!(scientist: @curie, experiment: @exp_1)
  
      ScientistExperiment.create!(scientist: @franky, experiment: @exp_1)
      ScientistExperiment.create!(scientist: @franky, experiment: @exp_2)

      ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_1)
      ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_3)  
    end

    it "returns all scientists associated with a lab (even if they have zero experiments)" do
      expect(@nuclear.find_scientists_by_experiment_total).to match_array([@curie, @franky, @oppie])
    end

    it "returns all scientists ordered by experiment totals" do
      expected_order = [@franky, @curie, @oppie].sort_by { |scientist| scientist.experiments.size }.reverse
      expect(@nuclear.find_scientists_by_experiment_total).to eq(expected_order)
    end
  end
end