require 'rails_helper'

RSpec.describe '/labs/:id', type: :feature do
  before(:each) do
    @nuclear = Lab.create!(name: "Nuclear Lab")
    @electric = Lab.create!(name: "Electric Lab")
    
    @curie = Scientist.create!(lab: @nuclear, name: "Marie Curie", specialty: "radioactivity", university: "University of Paris")
    @franky = Scientist.create!(lab: @nuclear, name: "Victor Frankenstein", specialty: "electrical-biology", university: "University of Ingolstadt")
    @oppie = Scientist.create!(lab: @nuclear, name: "J. Robert Oppenheimer", specialty: "the big boom & quick maths", university: "Harvard University")
    @jekyll = Scientist.create!(lab: @electric, name: "Dr. Jekyll or Mr. Hyde", specialty: "sleep deprivation", university: "University of London")

    @exp_1 = Experiment.create!(name: "Radio-waves", objective: "understand them", num_months: 6)
    @exp_2 = Experiment.create!(name: "My Hand Hurts", objective: "understand why", num_months: 14)
    @exp_3 = Experiment.create!(name: "Monster", objective: "electic-life", num_months: 7)
    @exp_4 = Experiment.create!(name: "Reduced Sleep", objective: "who am I?", num_months: 2)
    @exp_5 = Experiment.create!(name: "More Reduced Sleep", objective: "who am I now?", num_months: 10)

    ScientistExperiment.create!(scientist: @curie, experiment: @exp_1)
    ScientistExperiment.create!(scientist: @curie, experiment: @exp_2)

    ScientistExperiment.create!(scientist: @franky, experiment: @exp_1)
    ScientistExperiment.create!(scientist: @franky, experiment: @exp_3)
    ScientistExperiment.create!(scientist: @franky, experiment: @exp_4)

    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_1)
    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_3)
    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_4)
    ScientistExperiment.create!(scientist: @jekyll, experiment: @exp_5)

    ScientistExperiment.create!(scientist: @oppie, experiment: @exp_1)
    ScientistExperiment.create!(scientist: @oppie, experiment: @exp_2)
    ScientistExperiment.create!(scientist: @oppie, experiment: @exp_4)
    ScientistExperiment.create!(scientist: @oppie, experiment: @exp_5)
  end

  describe "as a user, when I visit a lab's show page" do
    it "displays the labs name" do
      visit "/labs/#{@nuclear.id}"

      expect(page).to have_content(@nuclear.name)
    end

    it "displays the names of all scientists that work at that lab" do
      visit "/labs/#{@nuclear.id}"

      expect(page).to have_content("Current Scientists")
      expect(page).to have_content(@curie.name)
      expect(page).to have_content(@franky.name)
      expect(page).to have_content(@oppie.name)

      expect(page).to_not have_content(@jekyll.name)
    end

    it "displays the number of experiments next to each scientist" do
      visit "/labs/#{@nuclear.id}"

      expect(page).to have_content("Current Scientists & Total Experiments:")
      expect(page).to have_content("#{@curie.name}: 2")
      expect(page).to have_content("#{@franky.name}: 3")
      expect(page).to have_content("#{@oppie.name}: 4")
    end

    it "displays scientists by order of most to least experiments" do
      visit "/labs/#{@nuclear.id}"

      expect(@oppie.name).to appear_before(@franky.name)
      expect(@franky.name).to appear_before(@curie.name)
    end
  end
end