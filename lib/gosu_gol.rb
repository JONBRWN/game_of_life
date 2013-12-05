require "gosu"
require "./game"

class GameOfLifeWindow < Gosu::Window 

	def initialize(height = 800, width = 600)
		@height = height
		@width = width
		super height, width, false
		self.caption = "My Game of Life"
		#Color
		@colors = [	Gosu::Color.argb(0xff808080), Gosu::Color.argb(0xff000000), Gosu::Color.argb(0xff00ffff),
					Gosu::Color.argb(0xffff0000), Gosu::Color.argb(0xff00ff00), Gosu::Color.argb(0xff0000ff),
					Gosu::Color.argb(0xffffff00), Gosu::Color.argb(0xffff00ff), Gosu::Color.argb(0xff00ffff)
				   ]


		@background = Gosu::Color.argb(0xffffffff)
		@alive = Gosu::Color.argb(0xff000000)
		@dead = Gosu::Color.argb(0xffffffff)

		#Game World
		@rows = height/10
		@cols = width/10
		@game = Game.new(@rows, @cols)
		@row_height = height/@rows
		@col_width = width/@cols

	end

	def update
		@game.cycle_through_world
		@game.tick!
	end
	
	def draw
		draw_background

		@game.world.board.each_with_index do |cell, row, col|
			 if cell.is_alive?
			 	@alive = @colors.sample
		        draw_quad(row * @col_width, col * @row_height, @alive,
		                  row * @col_width + (@col_width - 1), col * @row_height, @alive,
		                  row * @col_width + (@col_width - 1), col * @row_height + (@row_height - 1), @alive,
		                  row * @col_width, col * @row_height + (@row_height - 1), @alive)
		     else
		        draw_quad(row * @col_width, col * @row_height, @dead,
		                  row * @col_width + (@col_width - 1), col * @row_height, @dead,
		                  row * @col_width + (@col_width - 1), col * @row_height + (@row_height - 1), @dead,
		                  row * @col_width, col * @row_height + (@row_height - 1), @dead)
		     end
		end
	end

	def needs_cursor?
		true
	end

	def draw_background
	    draw_quad(0, 0, @background,
	              width, 0, @background,
	              width, height, @background,
	              0, height, @background)
    end


end

window = GameOfLifeWindow.new
window.show