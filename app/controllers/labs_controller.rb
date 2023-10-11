class LabsController < ApplicationController
  def show
    @lab = Lab.find(params[:id])
  end
end