class Cell
attr_accessor :state, :living_neighbors

STATES = ["DEAD", "ALIVE"]
	
	def initialize
		@state = STATES.sample	
	end

	def is_alive?
		@state == "ALIVE"
	end

	def change_state
		@state = STATES[1-STATES.index(@state)]
	end

end