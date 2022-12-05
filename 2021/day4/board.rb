class Board
  attr_reader :board

  def initialize
    @board = []
  end

  def add_row(row)
    board << row
  end

  def mark_number(num)
    board.map { |row| row[row.index(num)] = nil if row.include?(num) }
  end

  def win?
    board.map { |row| row.compact.empty? }.any? || board.transpose.map { |row| row.compact.empty? }.any?
  end

  def sum
    board.flatten.compact.sum
  end
  
  def print_board
    p board
  end
end

