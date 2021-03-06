require_relative 'piece'
require_relative 'display'
require 'byebug'

class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @sentinel = NullPiece.instance
    populate
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  
  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end
  
  def display
    @grid.each { |row| p row }
  end
  
  def move_piece(start_pos, end_pos)
    # raise "Can't move a null piece" if self[start_pos].is_a?(NullPiece)
    p start_pos
    p "----"
    p end_pos
    unless start_pos[0].between?(0, 7) && start_pos[1].between?(0, 7)
      raise "Can't select pieces off the board"
    end
    
    unless end_pos[0].between?(0, 7) && end_pos[1].between?(0, 7)
      raise "You can't move pieces off the board"
    end
    
    self[end_pos], self[start_pos] = self[start_pos], self[end_pos]
  end
  
  def populate #creates instances of pieces and puts them where they need to go (inclding NullPiece)
    @grid.each_with_index do |row, ri|
      row.each_with_index do |cell, ci|
        if ri == 0 || ri == 1
          team = "green"
        elsif ri == 6 || ri == 7
          team = "red"
        end
        
        if ri == 0 || ri == 7 || ri == 1 || ri == 6
          row[ci] = Rook.new([ri, ci], self, team)
        else
          row[ci] = @sentinel
        end
      end
    end
  end 
  
  def testing
    thing = Display.new(self)
    thing.render
      # Cursor.get_input
  end
  
  def valid_pos?(next_pos)
    next_pos[0].between?(0, 7) && next_pos[1].between?(0, 7)
  end 
end

game = Board.new
game.testing