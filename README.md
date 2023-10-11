# Halloween Laboratory

The aim of this respository is to practice the basic fundamentals of the MVC software architectural pattern.

It requires and has been tested on Ruby v3.2.2 and is based on Rails 7.0.6
It's based off of a practice respository from the Turing School of Software & Design entitled Frankenstein.

## Description

Halloween Laboratory is an app that allows a user to see labs, scientists, and experiments. 

## Database information

- Labs have a name
    - Ex: name: “Fermilab”
- Scientists have a name, specialty, and university attended
    - Ex: name: “Marie Curie”, specialty: “radioactivity”, university: “University of Paris”
- Experiments have a name, objective (description), and a num_months attribute which represents the duration of the experiment
    - Ex: name: “MINERvA”, objective: “study neutrino reactions with five different nuclei”, num_months: 4
- Labs have many scientists
- Scientists belong to a lab
- Scientists have many experiments
- Experiments can have many scientists

## User Stories

```
User Story 1, Scientist Show Page

As a visitor
When I visit a scientist's show page
I see all of that scientist's information including:
 - name
 - specialty
 - university where they got their degree
And I see the name of the lab where this scientist works
And I see the names of all of the experiments this scientist is running
```

```
User Story 2, Remove an Experiment from a Scientist

As a visitor
When I visit a scientist's show page
Then next to each experiment's name, I see a button to remove that experiment from that scientist's work load
When I click that button for one experiment
I'm brought back to the scientist's show page
And I no longer see that experiment's name listed
And when I visit a different scientist's show page that is working on that same experiment,
Then I see that the experiment is still on the other scientist's work load
```

```
User Story 3, Experiment Index Page

As a visitor
When I visit the experiment index page
I see the names of all long running experiments (longer than 6 months),
And I see the names are in descending order (longest to shortest)
```

### Extensions
```
Extension, Lab Show Page

As a visitor
When I visit a lab's show page
I see the lab's name
And I see the names of all scientists that work at this lab,
And next to each scientist I see the number of experiments associated with the scientist,
And I see the list of scientists is ordered from most number of experiments to least number of experiments
(Scientist experiment counts should be a single query)
```
