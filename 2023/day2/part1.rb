input = File.read('input.txt').split("\n")

sum = 0
input.each do |line|
  possible = true
  header, games = line.split(":")
  game_number = header.split(" ").last.strip.to_i

  games.split(";").each do |game|
    goal = {
      "red" => 12,
      "green" => 13,
      "blue" => 14
    }
    game.split(",").each do |draw|
      cubes, color = draw.split(" ")
      goal[color.strip] -= cubes.to_i
    end
    if goal.values.any? { |value| value < 0 }
      possible = false
      break
    end
  end

  sum += game_number if possible
end
puts sum
