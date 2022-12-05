class Point
  attr_accessor :x, :y
  def initialize(x_s, y_s)
    @x = x_s.to_i
    @y = y_s.to_i
  end
end