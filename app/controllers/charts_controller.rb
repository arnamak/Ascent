class ChartsController < ApplicationController
  def index
  end

  def show
  	@flight = Flight.find(params[:id])
  	@points = []
  	data_points = @flight.data_points
  	data_points.each do |p|
      @points << { x: (time_from_first_point(p, data_points[0])),
  					 y: p[:data]['altitude'],
  					 temp: p[:data]['temperature'],
             latitude: p[:data]['latitude'],
             longitude: p[:data]['longitude'],
             pressure: p[:data]['pressure']}
  	end

  	respond_to do |format|
  	  format.json { render json: @points, status: :ok}
  	end
  end

  def format_time(point)
    point.data['time'].to_datetime.strftime('%Q').to_i
  end

  def time_from_first_point(point1, point2)
    format_time(point1) - format_time(point2)
  end

end