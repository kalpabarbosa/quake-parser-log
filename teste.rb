#!/usr/bin/ruby -W

class QuakeLog

	def initialize(arquivo)
		@arq = File.readlines(arquivo)
		@num_of_games = 0
	end

	def getGame		
		@arq.each do |line|
			if line.include? 'InitGame'
				#starts the game
				@num_of_games += 1
			else
				#
			end
		end
		puts @num_of_games
	end

end

log = QuakeLog.new('../documentacao/games.log')
log.getGame
