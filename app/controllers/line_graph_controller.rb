# app/controllers/line_graph_controller.rb
class LineGraphController < ApplicationController
  def data
    data = (0..29).map { |i| { x: i, y: rand(0..5) } }
    render json: data
  end
end
