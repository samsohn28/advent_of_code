
class Dial
  def initialize
    @position = 50
    @zeroes = 0
  end

  def move(direction, distance)
    if direction == "R"
      @position += distance
    else
      @position -= distance
    end

    @position = @position % 100
    
    if @position == 0
      @zeroes += 1
    end
  end

  def position
    @position
  end

  def zeroes
    @zeroes
  end
end

dial = Dial.new
input = File.readlines("input.txt")
input.each do |line|
  dir = line[0]
  distance = line[1..].to_i
  dial.move(dir, distance)
end

puts dial.position
puts dial.zeroes
