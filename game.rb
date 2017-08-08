#!/usr/bin/ruby -W

class Game
	def initialize(game_num)
		@game_num = game_num
		@total_kills = 0
		@players = Hash.new
		@kills = Hash.new
	end

	def getPlayer(player_id, player_nickname)
		@players[player_id] = player_nickname
	end
	
end
