class ExperimentsController < ApplicationController
  def index
    @long_experiments = Experiment.find_long_experiments
  end
end