require './Board'

file = File.open('input.txt').read.split("\n")

numbers = file.shift.split(',').map(&:to_i)

boards = []
current_board = nil
file.each do |row|
  if row.empty?
    boards << current_board unless current_board.nil?
    current_board = Board.new
  else
    current_board.add_row(row.split.map(&:to_i))
  end
end

last_win = 0
numbers.each do |n|
  # p "Number is: #{n}"
  boards.each do |board|
    board.mark_number(n)
    if board.win?
      last_win = board.sum * n
      boards.delete(board)
    end
  end
end

p last_win