class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def show
    @flight = Flight.find(params[:id])
    @data_points = @flight.data_points
  end

  def create
      p flight_params
      Flight::import_habhub_from_url(flight_params[:address])
      redirect_to flights_path
  end

  def import
    Flight.import(params[:file])
    redirect_to root_url, notice: "Your flight has been imported."
  end

  private
    def flight_params
      params.require(:new_flight).permit(:address)
    end
end