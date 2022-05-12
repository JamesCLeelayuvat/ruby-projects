require "./lib/board.rb"
require "./lib/Displayable.rb"
require "./lib/game.rb"
require "./lib/main.rb"
require "./lib/prompts.rb"
require "./lib/pieces/bishop.rb"
require "./lib/pieces/king.rb"
require "./lib/pieces/knight.rb"
require "./lib/pieces/pawn.rb"
require "./lib/pieces/queen.rb"
require "./lib/pieces/rook.rb"
require "./lib/movements/basic_movement.rb"
require "./lib/movements/castling_movement.rb"
require "./lib/movements/en_passant_movement.rb"
require "./lib/movements/pawn_promotion_movement.rb"

describe Prompts do
  describe "#get_selection" do
    it "returns the piece object based on selecting a valid square with algebraic notation" do
      board = Board.new
      board.new_board
      prompt = Prompts.new
      expect(prompt.get_selection("white", board.board)).to eql(board.board[0][0])
    end
  end
end
