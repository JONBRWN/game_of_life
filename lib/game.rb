require "./world"

class Game
	attr_reader :world

	def initialize(rows, columns)
		@world = World.new(rows, columns)
	end

	def cycle_through_world
		@world.board.each_with_index do |cell, row, col|
			@world.check_neighbors_for_life(cell, row, col)
			@world.change_state?(cell)
		end
	end

	def tick!
		@world.change_state!
		@world.change_state_of.clear
	end
end