file = File.open('input.txt').read.split("\n")

numbers = file.shift.split(',')

class Board
  def initialize
    @board = []
  end

  def board_complete?
    @board.size == 5
  end

  def add_row(row)
    @board << row
  end

  def mark_number(num)
    @board.map { |row| row[row.index(num)] = "x" if row.include?(num) }
  end

  def win?
    # horizontal win
    return true if @board.map { |row| row.uniq.size == 1 }.any?

    # vertical win
    (0..4).each do |x|
      return true if [@board[0][x], @board[1][x], @board[2][x], @board[3][x], @board[4][x]].uniq.size == 1
    end

    # # diagonal win
    # diagonals = [
    #   [@board[0][0], @board[1][1], @board[2][2], @board[3][3], @board[4][4]],
    #   [@board[0][4], @board[1][3], @board[2][2], @board[3][1], @board[4][0]]]
    # return true if diagonals.map { |row| row.uniq.size == 1 }.any?

    # no win
    return false
  end

  def sum_of_remaining
    @board.flatten.reject { |x| x == "x" }.map(&:to_i).sum
  end
  
  def print_board
    p @board
  end
end

boards = []
current_board = nil
file.each do |row|
  if row.empty?
    boards << current_board unless current_board.nil?
    current_board = Board.new
    next
  else
    current_board.add_row(row.split)
  end
end

win = false
numbers.each do |n|
  boards.each do |board|
    board.mark_number(n)
    if board.win?
      board.print_board
      puts board.sum_of_remaining * n.to_i
      win = true
      break
    end
  end
  break if win
end