require 'rails_helper'

RSpec.describe '/scientists/:id', type: :feature do
  before(:each) do
    @nuclear = Lab.create!(name: "Nuclear Lab")
    @electric = Lab.create!(name: "Electric Lab")
    
    @curie = Scientist.create!(lab: @nuclear, name: "Marie Curie", specialty: "radioactivity", university: "University of Paris")
    @franky = Scientist.create!(lab: @nuclear, name: "Victor Frankenstein", specialty: "electrical-biology", university: "University of Ingolstadt")
    @jekyll = Scientist.create!(lab: @electric, name: "Dr. Jekyll or Mr. Hyde", specialty: "sleep deprivation", university: "University of London")

    @exp_curie_1 = Experiment.create!(name: "Radio-waves", objective: "understand them", num_months: 6)
    @exp_curie_2 = Experiment.create!(name: "My hand hurts", objective: "understand why", num_months: 4)
    @exp_franky_3 = Experiment.create!(name: "Monster", objective: "electic-life", num_months: 5)
    @exp_jekyll_4 = Experiment.create!(name: "Reduced Sleep", objective: "who am I?", num_months: 2)
    @exp_jekyll_5 = Experiment.create!(name: "More Reduced Sleep", objective: "who am I now?", num_months: 3)

    ScientistExperiment.create!(scientist: @curie, experiment: @exp_curie_1)
    ScientistExperiment.create!(scientist: @curie, experiment: @exp_curie_2)
    ScientistExperiment.create!(scientist: @franky, experiment: @exp_franky_3)
    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_jekyll_4)
    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_jekyll_5)
  end

  describe "as a user, when I visit a scientist's show page" do
    it "displays that scientist's name, speciality, and university" do
      visit "/scientists/#{@curie.id}"

      expect(page).to have_content("Name: #{@curie.name}")
      expect(page).to have_content("Specialty: #{@curie.specialty}")
      expect(page).to have_content("University: #{@curie.university}")

      expect(page).to_not have_content("Name: #{@franky.name}")
    end

    it "displays the name of the lab where this scientist workds" do
      art_lab = Lab.create!(name: "Art Lab")

      visit "/scientists/#{@curie.id}"

      expect(page).to have_content("Current Lab: #{@curie.lab.name}")

      expect(page).to_not have_content("Current Lab: Art Lab")
    end
  end
end