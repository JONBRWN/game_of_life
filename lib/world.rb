require "matrix"
require "./cell"

class World
	attr_reader :board
	attr_accessor :change_state_of

	NEIGHBOR_LOCATIONS = [	{:row =>  1, :col => -1}, {:row =>  1, :col =>  0}, {:row =>  1, :col =>  1},
							{:row =>  0, :col => -1}						  , {:row =>  0, :col =>  1},
							{:row => -1, :col => -1}, {:row => -1, :col =>  0}, {:row => -1, :col =>  1}]

	def initialize(rows, columns)
		@board = Matrix.build(rows, columns) {Cell.new}
		@change_state_of = Array.new
	end

	def check_neighbors_for_life(cell, cell_row, cell_col)
		living_neighbors = Array.new
		NEIGHBOR_LOCATIONS.each do |neighbor_location|
			neighbor = @board[(cell_row + neighbor_location[:row]), (cell_col + neighbor_location[:col])]
			next if neighbor.nil?
			living_neighbors << neighbor if neighbor.is_alive?
		end
		cell.living_neighbors = living_neighbors.count
	end

	def change_state?(cell)
		if cell.is_alive?
			@change_state_of << cell if cell.living_neighbors < 2 ||  cell.living_neighbors > 3
		else
			@change_state_of << cell if cell.living_neighbors == 3
		end
	end

	def change_state!
		@change_state_of.each do |cell|
			cell.change_state
		end
	end


end