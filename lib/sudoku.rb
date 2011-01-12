require 'rubygems'

# Forward compability hack
class String
  unless "".respond_to?(:lines)
    def lines; self; end
  end
end

class Soduku

  class ParseError < StandardError; end
  VALUES = (1..9).to_a
  POSITIONS = (0..8).to_a
  COLUMN_MAP = (0..8).map{|column| (0..8).to_a.map{|i| column + (9 * i)}}
  BOX_MAP = []

  # The surrounding positions placed in the same box
  # as the given position
  def self.box_positions(y, x)
    from_y = (y / 3) * 3
    to_y = from_y + 2
    from_x = (x / 3) * 3
    to_x = from_x + 2
    positions = []
    (from_y..to_y).each do |row|
      (from_x..to_x).each do |column|
        positions << ((row * 9) + column)
      end
    end
    return positions
  end

  POSITIONS.each do |y|
    POSITIONS.each do |x|
      BOX_MAP[(y << 4) + x] = box_positions(y, x)
    end
  end

  def initialize(board)
    @board = board
  end

  def self.from_text(text)
    raise "Not impemented"
  end

  # Values in column i
  def column(i)
    @board.values_at(*COLUMN_MAP[i])
  end

  # Values in row i
  def row(i)
    @board[i * 9, 9]
  end

  # Values in 3 x 3 box surrounding position y, x
  def box(y, x)
    @board.values_at(*BOX_MAP[(y << 4) + x])
  end

  # Free values for position y, x
  def free(y, x)
    VALUES - taken(y, x)
  end

  # Taken values for position y, x
  def taken(y, x)
    (row(y) + column(x) + box(y, x)).compact
  end

  # Is the board full?
  def full?
    @board.count{|e| e} == 81
  end

  def dup
    board = @board.dup
    Soduku.new(board)
  end

  def most_restricted_position
    positions = []
    @board.each_with_index do |value, i|
      unless value
        y, x = i.divmod(9)
        positions[free(y, x).size] = [y, x]
      end
    end
    positions.compact.first
  end

  def solve
    if $verbose
      puts to_s
      #sleep 0.5
    end
    return self if self.full?
    $iterations +=1
    y, x = most_restricted_position
    free(y, x).each do |candidate|
      attempt = self.dup
      attempt.set(y, x, candidate)
      result = attempt.solve
      return result if result
    end
    return false
  end

  def set(y, x, value)
    if taken(y, x).include? value
      raise "Position (#{y}, #{x}) can not be set to #{value}"
    end
    @board[y * 9 + x] = value
  end

  def inspect
    "\n" + to_s
  end

  def rows
    POSITIONS.map{|i| row(i)}
  end

  def to_s
    i = -1
    j = -1
    ('-' * 30) +
    rows.inject("\n") do |board, line|
      board += line.inject('') do |line, char|
        line += ' ' + (char ?  char.to_s  : ' ') + ' ' +
                ( (j += 1) % 3 == 2 ? "|" : "")
      end + "\n" + ( (i += 1) % 3 == 2 ? "\n" : "")
    end + ('-' * 30)
  end

 def self.convert(char)
    unless VALUES.include?(char.to_i) || char == '.'
      raise ParseError, "Invalid character: #{char}"
    end
    char = char.to_i
    char = nil if char == 0
    char
  end
end
