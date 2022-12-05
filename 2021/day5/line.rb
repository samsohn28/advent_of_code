require './Point'

class Line
  attr_accessor :start, :finish
  def initialize(point1, point2)
    @start = point1
    @finish = point2
  end
end