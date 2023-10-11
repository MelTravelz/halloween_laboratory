require 'rails_helper'

RSpec.describe "/experiments", type: :feature do
  before(:each) do
    @nuclear = Lab.create!(name: "Nuclear Lab")
    @electric = Lab.create!(name: "Electric Lab")
    
    @curie = Scientist.create!(lab: @nuclear, name: "Marie Curie", specialty: "radioactivity", university: "University of Paris")
    @franky = Scientist.create!(lab: @nuclear, name: "Victor Frankenstein", specialty: "electrical-biology", university: "University of Ingolstadt")
    @jekyll = Scientist.create!(lab: @electric, name: "Dr. Jekyll or Mr. Hyde", specialty: "sleep deprivation", university: "University of London")

    @exp_1 = Experiment.create!(name: "Radio-waves", objective: "understand them", num_months: 6)
    @exp_2 = Experiment.create!(name: "My hand hurts", objective: "understand why", num_months: 14)
    @exp_3 = Experiment.create!(name: "Monster", objective: "electic-life", num_months: 7)
    @exp_4 = Experiment.create!(name: "Reduced Sleep", objective: "who am I?", num_months: 2)
    @exp_5 = Experiment.create!(name: "More Reduced Sleep", objective: "who am I now?", num_months: 10)

    ScientistExperiment.create!(scientist: @curie, experiment: @exp_1)
    ScientistExperiment.create!(scientist: @curie, experiment: @exp_2)

    ScientistExperiment.create!(scientist: @franky, experiment: @exp_1)
    ScientistExperiment.create!(scientist: @franky, experiment: @exp_3)

    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_1)
    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_3)
    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_4)
    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_5)
  end

  describe "as a user, when I visit the experiment index page" do
    it "displays the names of all the long-running experiments (6 months +)" do
      visit "/experiments"

      expect(page).to have_content("Long-Running Experiments:")
      expect(page).to have_content("#{@exp_2.name}: #{@exp_2.num_months} months")
      expect(page).to have_content("#{@exp_3.name}: #{@exp_3.num_months} months")
      expect(page).to have_content("#{@exp_5.name}: #{@exp_5.num_months} months")

      expect(page).to_not have_content("#{@exp_1.name}")
    end
  end

end