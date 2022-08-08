class PlotPlantsController < ApplicationController
  def destroy
    plot = Plot.find(params[:plot_id])
    plant = plot.plot_plants.find_by(plant_id: params[:plant_id])
    plant.destroy
    redirect_to '/plots'
  end
end